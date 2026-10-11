# Manutenção

Para quem mantém a lista. O colaborador só usa o comando do [README.md](README.md).

## Arquivos

| Arquivo | O que é | Editar? |
|---|---|---|
| `software.csv` | Fonte única: um programa por linha | Sim |
| `modelo_instalar.ps1` | Modelo do script (janela, instalação, resumo); os dados entram nas marcas `#__DADOS__` etc. | Só para mudar o comportamento |
| `gerar_guia.py` | Gera `README.md`, `instalar.ps1` e `i.txt`; valida o CSV. `RESPONSAVEL` e `URL_SCRIPT` ficam no início | Raramente |
| `README.md` | Guia do colaborador | Não (gerado) |
| `instalar.ps1` | Script completo; também serve para baixar e rodar com botão direito | Não (gerado) |
| `i.txt` | Cópia de `instalar.ps1` que o comando baixa, servida pelo GitHub Pages (`yes-mattz.github.io/onboarding-software/i.txt`). `.txt` para vir como `text/plain` | Não (gerado) |
| `instaladores/` | Instaladores dos programas com `instalacao = pasta`, servidos pelo GitHub Pages. Público: só gratuitos redistribuíveis | Sim |

## Colunas do CSV

| Coluna | Valores |
|---|---|
| `nome`, `finalidade` | Nome (único) e para que serve |
| `perfil` | `base` (todos), `firmware`, `hardware`, `iluminacao`, `bancada`. Programa de vários perfis fica no mais amplo |
| `prioridade` | `essencial` (vem marcado na janela) ou `sob-demanda` (desmarcado) |
| `versao` | Versão de referência em uso na equipe |
| `licenca` | `gratuito` ou `pago` |
| `instalacao` | `winget`, `download` (baixa do fabricante e confere hash), `pasta` (baixa de `instaladores/` deste repositório e confere hash) ou `manual` (abre `link`, ou pede ao responsável) |
| `winget_id` | Obrigatório com `winget`. Conferir com `winget show --id <id> -e` |
| `winget_versao` | Vazio instala a última; preenchido fixa a versão |
| `download_url` | Obrigatório com `download`: link direto e fixo do arquivo, `https` |
| `sha256` | Obrigatório com `download`: hash do arquivo |
| `args` | Opcional: parâmetros do instalador (ex.: modo silencioso documentado pelo fabricante). Vazio abre as telas normais |
| `categoria`, `link` | Tipo de programa e página do fabricante |
| `arquivo` | Obrigatório com `pasta`: nome do instalador em `instaladores/`. Deixar `download_url` e `sha256` vazios: o `gerar_guia.py` calcula |

Uma informação por célula, UTF-8. O Excel em português salva com `;`: salvar como "CSV UTF-8 (delimitado por vírgulas)" ou editar no VS Code.

## Tarefas

**Publicar uma mudança**: editar o CSV, rodar `python gerar_guia.py` (para em caso de erro no CSV), conferir, `git commit` e `git push`. O comando dos colaboradores pega a versão nova na hora.

**Programa na pasta do kit**: para instalador sem link estável, que hoje é "pedir ao responsável". Só programa gratuito cuja licença permite redistribuir: a pasta é pública, e o `gerar_guia.py` recusa `pago`. Até 100 MB por arquivo (limite do GitHub).

1. Copiar o instalador para `instaladores/` (conferir a assinatura, como abaixo).
2. Na linha do programa: `instalacao` = `pasta`, `arquivo` = nome do arquivo; `args` se quiser modo silencioso.
3. `python gerar_guia.py`, `git add instaladores/<arquivo>`, commit e push.

Para trocar de versão, substituir o arquivo e rodar o gerador de novo: o hash é recalculado.

**Programa com download direto**: só vale para link fixo de um arquivo com versão no nome. Calcular o hash e conferir a assinatura:

```powershell
Invoke-WebRequest -UseBasicParsing -Uri <url> -UserAgent 'Wget/1.21' -OutFile instalador.exe
(Get-FileHash instalador.exe).Hash
Get-AuthenticodeSignature instalador.exe | Format-List Status, SignerCertificate
```

Se o fabricante trocar o arquivo no mesmo link, o script recusa ("SHA-256 diferente") até a linha ser atualizada.

**Versão nova de um programa**: winget sem versão fixa não precisa de nada. `download`: trocar `download_url`, `sha256` e `versao`. `manual`: atualizar `versao` e `link`.

**Testar sem instalar**: `powershell -ExecutionPolicy Bypass -File .\instalar.ps1` e marcar "Simular" na janela.

## Situação dos programas manuais

Levantamento de 2026-10-09: muitos sites de fabricante bloqueiam download automático (Microchip para MPLAB X e XC-DSC, Qorvo, NXP, Renesas, Infineon) ou não têm link estável (fabricantes chineses, PulseView nightly). Ficaram `download` só Microchip Studio e RealTerm.

Essenciais manuais sem link (o colaborador precisa pedir): `python gerar_guia.py` lista. São sobretudo softwares de equipamento de bancada e de iluminação, que vêm do fabricante do equipamento. Para estes, uma pasta compartilhada com os instaladores resolveria; os pagos e os de licença restrita não podem ir para este repositório público.

## Segurança

- O comando roda o `i.txt` deste repositório (via GitHub Pages, branch `main`, raiz) como administrador no PC do colaborador. Conta do GitHub com 2FA; só o mantenedor com escrita.
- Nada interno no repositório: sem nomes, caminhos de rede, chaves ou instaladores.
- `download` só executa arquivo com hash igual ao registrado.
- `instalar.ps1` e `i.txt` são publicados em UTF-8 sem BOM (o BOM quebra o `irm | iex`); o script regrava a cópia elevada com BOM para o PowerShell 5.1 ler os acentos.

## Pendências

- Definir o responsável (`RESPONSAVEL` em `gerar_guia.py`).
- Licença de uso comercial: AnyDesk e Visual Studio Community marcados como `pago`; confirmar se há licença.
- Links das páginas dos fabricantes para os manuais sem link.
- Piloto com o próximo colaborador.
