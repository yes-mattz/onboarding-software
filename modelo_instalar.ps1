# Instalação de software para novos colaboradores.
#
# Uso (PowerShell comum, não precisa ser administrador):
#   irm __URL_SCRIPT__ | iex
#
# Gerado por gerar_guia.py a partir de software.csv em __DATA__. Não editar instalar.ps1:
# editar software.csv (ou modelo_instalar.ps1) e rodar python gerar_guia.py.
#
# Sem bloco param() e sem exit: o script também roda via Invoke-Expression, na sessão do usuário.

$UrlScript = '__URL_SCRIPT__'
$Responsavel = '__RESPONSAVEL__'

$Software = @(
#__DADOS__
)

$Perfis = [ordered]@{
#__PERFIS__
}

function Test-Admin {
    $id = [Security.Principal.WindowsIdentity]::GetCurrent()
    ([Security.Principal.WindowsPrincipal]$id).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Start-Elevado {
    # Copia o script para o TEMP (baixando, quando veio por irm | iex) e reabre como administrador
    # O arquivo publicado não tem BOM (o BOM quebra o irm | iex); a cópia ganha BOM para o PowerShell 5.1 ler os acentos
    $alvo = Join-Path $env:TEMP 'onboarding-instalar.ps1'
    if ($PSCommandPath) {
        $texto = [IO.File]::ReadAllText($PSCommandPath, [Text.Encoding]::UTF8)
    } else {
        $texto = (Invoke-WebRequest -UseBasicParsing -Uri $UrlScript).Content
    }
    [IO.File]::WriteAllText($alvo, $texto, (New-Object Text.UTF8Encoding $true))
    Start-Process powershell.exe -Verb RunAs -ArgumentList @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', "`"$alvo`"")
}

function Get-WingetInstalados {
    # winget export lista os IDs completos (winget list corta IDs longos conforme a largura da janela)
    $arquivo = Join-Path $env:TEMP 'onboarding-instalados.json'
    try {
        winget export -o $arquivo --accept-source-agreements --disable-interactivity *> $null
        $json = Get-Content -LiteralPath $arquivo -Raw -Encoding UTF8 | ConvertFrom-Json
        @($json.Sources | ForEach-Object { $_.Packages } | ForEach-Object { $_.PackageIdentifier })
    } catch { @() }
}

function Show-Selecao($instalados) {
    Add-Type -AssemblyName System.Windows.Forms, System.Drawing
    [System.Windows.Forms.Application]::EnableVisualStyles()

    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'Instalação de software'
    $form.Size = New-Object System.Drawing.Size(1100, 700)
    $form.StartPosition = 'CenterScreen'
    $form.Font = New-Object System.Drawing.Font('Segoe UI', 9)

    $topo = New-Object System.Windows.Forms.Label
    $topo.Text = "Marque o(s) perfil(is) da sua função. Os programas essenciais já vêm marcados; os sob demanda, só se o projeto pedir.`nManual = abre a página do fabricante no fim; programa pago: pedir licença a $Responsavel."
    $topo.Dock = 'Top'; $topo.Height = 44; $topo.Padding = New-Object System.Windows.Forms.Padding(8, 6, 8, 0)

    $painelPerfis = New-Object System.Windows.Forms.FlowLayoutPanel
    $painelPerfis.Dock = 'Top'; $painelPerfis.Height = 34; $painelPerfis.Padding = New-Object System.Windows.Forms.Padding(6, 4, 6, 0)

    $lista = New-Object System.Windows.Forms.ListView
    $lista.View = 'Details'; $lista.CheckBoxes = $true; $lista.FullRowSelect = $true; $lista.Dock = 'Fill'
    foreach ($c in @(@('Programa', 230), @('Para que serve', 330), @('Versão', 110), @('Instalação', 90), @('Licença', 70), @('Situação', 110))) {
        [void]$lista.Columns.Add($c[0], $c[1])
    }

    $rodape = New-Object System.Windows.Forms.Panel
    # largura antes dos botões: a âncora à direita usa a largura do painel no momento em que são posicionados
    $rodape.Size = New-Object System.Drawing.Size($form.ClientSize.Width, 48); $rodape.Dock = 'Bottom'
    $simular = New-Object System.Windows.Forms.CheckBox
    $simular.Text = 'Simular'
    $simular.AutoSize = $true; $simular.Location = New-Object System.Drawing.Point(10, 14)
    $contador = New-Object System.Windows.Forms.Label
    $contador.AutoSize = $true; $contador.Location = New-Object System.Drawing.Point(380, 15)
    $instalar = New-Object System.Windows.Forms.Button
    $instalar.Text = 'Instalar'; $instalar.Size = New-Object System.Drawing.Size(110, 30)
    $instalar.Anchor = 'Right, Bottom'; $instalar.Location = New-Object System.Drawing.Point(850, 9)
    $instalar.DialogResult = 'OK'
    $cancelar = New-Object System.Windows.Forms.Button
    $cancelar.Text = 'Cancelar'; $cancelar.Size = New-Object System.Drawing.Size(100, 30)
    $cancelar.Anchor = 'Right, Bottom'; $cancelar.Location = New-Object System.Drawing.Point(970, 9)
    $cancelar.DialogResult = 'Cancel'
    $rodape.Controls.AddRange(@($simular, $contador, $instalar, $cancelar))
    $form.AcceptButton = $instalar; $form.CancelButton = $cancelar

    # marcações que o usuário mudou à mão sobrevivem à troca de perfil
    $escolhas = @{}
    $caixas = @{}
    $script:atualizando = $false

    $atualizarContador = {
        $contador.Text = "$($lista.CheckedItems.Count) programa(s) marcado(s)"
    }

    $preencher = {
        $script:atualizando = $true
        $lista.BeginUpdate()
        $lista.Items.Clear(); $lista.Groups.Clear()
        foreach ($p in $Perfis.Keys) {
            if (-not $caixas[$p].Checked) { continue }
            $grupo = New-Object System.Windows.Forms.ListViewGroup($p, "$p - $($Perfis[$p])")
            [void]$lista.Groups.Add($grupo)
            foreach ($s in $Software | Where-Object { $_.perfil -eq $p }) {
                $jaTem = $s.instalacao -eq 'winget' -and $instalados -contains $s.winget_id
                $versao = if ($s.instalacao -eq 'winget' -and -not $s.winget_versao) { 'última' } elseif ($s.winget_versao) { $s.winget_versao } else { $s.versao }
                $situacao = if ($jaTem) { 'já instalado' } elseif ($s.prioridade -eq 'essencial') { 'essencial' } else { 'sob demanda' }
                $item = New-Object System.Windows.Forms.ListViewItem($s.nome, $grupo)
                foreach ($t in @($s.finalidade, $versao, $s.instalacao, $s.licenca, $situacao)) { [void]$item.SubItems.Add([string]$t) }
                $item.Tag = $s
                if ($escolhas.ContainsKey($s.nome)) { $item.Checked = $escolhas[$s.nome] }
                else { $item.Checked = ($s.prioridade -eq 'essencial') -and -not $jaTem }
                if ($jaTem) { $item.ForeColor = [System.Drawing.Color]::Gray }
                [void]$lista.Items.Add($item)
            }
        }
        $lista.EndUpdate()
        $script:atualizando = $false
        & $atualizarContador
    }

    foreach ($p in $Perfis.Keys) {
        $cb = New-Object System.Windows.Forms.CheckBox
        $cb.Text = $p; $cb.AutoSize = $true; $cb.Margin = New-Object System.Windows.Forms.Padding(4, 2, 18, 0)
        if ($p -eq 'base') { $cb.Checked = $true; $cb.Enabled = $false }
        $cb.Add_CheckedChanged({ & $preencher })
        $caixas[$p] = $cb
        [void]$painelPerfis.Controls.Add($cb)
    }
    $lista.Add_ItemChecked({
        param($remetente, $e)
        if (-not $script:atualizando) { $escolhas[$e.Item.Text] = $e.Item.Checked; & $atualizarContador }
    })

    $form.Controls.Add($lista)
    $form.Controls.Add($painelPerfis)
    $form.Controls.Add($topo)
    $form.Controls.Add($rodape)
    & $preencher

    $resultado = $form.ShowDialog()
    if ($resultado -ne 'OK') { return $null }
    [pscustomobject]@{
        Simular   = $simular.Checked
        Programas = @($lista.CheckedItems | ForEach-Object { $_.Tag })
    }
}

function Install-Winget($s, $simular) {
    $argumentos = @('install', '--id', $s.winget_id, '-e', '--accept-package-agreements', '--accept-source-agreements')
    if ($s.winget_versao) { $argumentos += @('--version', $s.winget_versao) }
    if ($simular) { Write-Host "  winget $($argumentos -join ' ')"; return 'simulado' }
    winget @argumentos
    if ($LASTEXITCODE -eq 0) { 'ok' } else { "falhou (winget código $LASTEXITCODE)" }
}

function Install-Download($s, $simular) {
    $pasta = Join-Path $env:TEMP 'onboarding'
    $arquivo = Join-Path $pasta ([IO.Path]::GetFileName(([uri]$s.download_url).AbsolutePath))
    if ($simular) { Write-Host "  baixar $($s.download_url)"; Write-Host "  conferir SHA-256 $($s.sha256) e executar"; return 'simulado' }
    New-Item -ItemType Directory -Force -Path $pasta | Out-Null
    Write-Host "  baixando $($s.download_url)"
    $ProgressPreference = 'SilentlyContinue'
    try {
        Invoke-WebRequest -UseBasicParsing -Uri $s.download_url -UserAgent 'Wget/1.21' -OutFile $arquivo
    } catch {
        return "falhou no download: $($_.Exception.Message)"
    }
    $hash = (Get-FileHash -Algorithm SHA256 -LiteralPath $arquivo).Hash
    if ($hash -ne $s.sha256.ToUpper()) {
        Remove-Item -LiteralPath $arquivo -Force
        return "NÃO executado: SHA-256 diferente do registrado (arquivo trocado no site ou adulterado)"
    }
    Write-Host '  SHA-256 confere; abrindo o instalador (siga as telas)'
    if ($arquivo -like '*.msi') {
        $p = Start-Process msiexec.exe -ArgumentList (@('/i', "`"$arquivo`"") + ($s.args -split ' ' | Where-Object { $_ })) -Wait -PassThru
    } elseif ($s.args) {
        $p = Start-Process -FilePath $arquivo -ArgumentList $s.args -Wait -PassThru
    } else {
        $p = Start-Process -FilePath $arquivo -Wait -PassThru
    }
    if ($p.ExitCode -eq 0 -or $p.ExitCode -eq 3010) { 'ok' } else { "instalador terminou com código $($p.ExitCode)" }
}

function Main {
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
    # sem isso o PowerShell 5.1 escreve o ✓ como ?
    [Console]::OutputEncoding = [Text.Encoding]::UTF8

    if (-not (Test-Admin)) {
        Write-Host 'Abrindo como administrador (confirme o aviso do Windows)...' -ForegroundColor Cyan
        Start-Elevado
        return
    }
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host 'winget não encontrado. Instale o "Instalador de Aplicativo" (App Installer) pela Microsoft Store e rode de novo.' -ForegroundColor Red
        Read-Host 'Enter para fechar' | Out-Null
        return
    }

    Write-Host 'Verificando o que já está instalado...' -ForegroundColor Cyan
    $instalados = Get-WingetInstalados
    $escolha = Show-Selecao $instalados
    if (-not $escolha -or $escolha.Programas.Count -eq 0) { Write-Host 'Nada selecionado.'; return }

    $log = Join-Path $env:TEMP ("onboarding-{0:yyyy-MM-dd-HHmm}.log" -f (Get-Date))
    Start-Transcript -Path $log | Out-Null
    $modo = if ($escolha.Simular) { ' (SIMULAÇÃO)' } else { '' }
    Write-Host "`nInstalando $($escolha.Programas.Count) programa(s)$modo" -ForegroundColor Cyan

    $resultados = @()
    $ordem = @{ winget = 0; download = 1; manual = 2 }
    foreach ($s in $escolha.Programas | Sort-Object { $ordem[$_.instalacao] }) {
        Write-Host "`n> $($s.nome)" -ForegroundColor Cyan
        switch ($s.instalacao) {
            'winget'   { $r = Install-Winget $s $escolha.Simular }
            'download' { $r = Install-Download $s $escolha.Simular }
            'manual'   {
                if ($s.link) {
                    if (-not $escolha.Simular) { Start-Process $s.link }
                    $r = "manual: página aberta no navegador ($($s.link))"
                } else {
                    $r = "manual: pedir instalador a $Responsavel"
                }
                if ($s.licenca -eq 'pago') { $r += '; licença paga' }
            }
        }
        if ($r -eq 'ok') {
            $r = "$([char]0x2713) Instalado"
            Write-Host "  $r" -ForegroundColor Green
        } else {
            Write-Host "  $r"
        }
        $resultados += [pscustomobject]@{ Programa = $s.nome; Resultado = $r }
    }

    Write-Host "`nResumo$modo" -ForegroundColor Cyan
    $resultados | Format-Table -AutoSize -Wrap | Out-String -Width 200 | Write-Host
    Write-Host "Log: $log"
    Write-Host 'Depois: reiniciar o PC se instalou drivers, e fazer a conferência final do guia.'
    Stop-Transcript | Out-Null
    Read-Host 'Enter para fechar' | Out-Null
}

Main
