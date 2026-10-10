# Instalação de software para novos colaboradores.
#
# Uso (PowerShell comum, não precisa ser administrador):
#   irm https://raw.githubusercontent.com/yes-mattz/onboarding-software/main/instalar.ps1 | iex
#
# Gerado por gerar_guia.py a partir de software.csv em 2026-10-10. Não editar instalar.ps1:
# editar software.csv (ou modelo_instalar.ps1) e rodar python gerar_guia.py.
#
# Sem bloco param() e sem exit: o script também roda via Invoke-Expression, na sessão do usuário.

$UrlScript = 'https://raw.githubusercontent.com/yes-mattz/onboarding-software/main/instalar.ps1'
$Responsavel = '(responsável a definir)'

$Software = @(
    [pscustomobject]@{ nome = 'AnyDesk'; finalidade = 'Acesso remoto'; perfil = 'base'; prioridade = 'essencial'; versao = '9.0.10'; licenca = 'pago'; instalacao = 'winget'; winget_id = 'AnyDesk.AnyDesk'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'Foxit PDF Reader'; finalidade = 'Leitor de PDF'; perfil = 'base'; prioridade = 'essencial'; versao = '12.1.3.15356'; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'Foxit.FoxitReader'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'Git'; finalidade = 'Controle de versão de código'; perfil = 'base'; prioridade = 'essencial'; versao = '2.52.0'; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'Git.Git'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = 'https://git-scm.com/install/windows' },
    [pscustomobject]@{ nome = 'Google Chrome'; finalidade = 'Navegador web'; perfil = 'base'; prioridade = 'essencial'; versao = ''; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'Google.Chrome'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'KiCad'; finalidade = 'CAD eletrônico (esquemático e PCB)'; perfil = 'base'; prioridade = 'essencial'; versao = ''; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'KiCad.KiCad'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = 'https://www.kicad.org/download/' },
    [pscustomobject]@{ nome = 'LTspice'; finalidade = 'Simulador eletrônico'; perfil = 'base'; prioridade = 'essencial'; versao = '24.1.9.1+'; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'AnalogDevices.LTspice'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = 'https://www.analog.com/en/resources/design-tools-and-calculators/ltspice-simulator.html' },
    [pscustomobject]@{ nome = 'Notepad++'; finalidade = 'Editor de texto'; perfil = 'base'; prioridade = 'essencial'; versao = '8.5.3'; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'Notepad++.Notepad++'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'Office Desktop'; finalidade = 'Word, PowerPoint, OneNote, Excel e Outlook'; perfil = 'base'; prioridade = 'essencial'; versao = ''; licenca = 'pago'; instalacao = 'winget'; winget_id = 'Microsoft.Office'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'PowerToys'; finalidade = 'Ferramenta de produtividade do Windows'; perfil = 'base'; prioridade = 'essencial'; versao = '0.95.1'; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'Microsoft.PowerToys'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'SMath Studio'; finalidade = 'Cálculo matemático'; perfil = 'base'; prioridade = 'essencial'; versao = '1.0.8151'; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'SMath.SMathStudio'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = 'https://smath.com/en-US/view/SMathStudio/download' },
    [pscustomobject]@{ nome = 'TortoiseGit'; finalidade = 'Interface Git para Windows'; perfil = 'base'; prioridade = 'essencial'; versao = '2.18.0.1'; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'TortoiseGit.TortoiseGit'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = 'https://tortoisegit.org/download/' },
    [pscustomobject]@{ nome = 'Visual Studio Code'; finalidade = 'Editor de código (IDE)'; perfil = 'base'; prioridade = 'essencial'; versao = '1.108.2'; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'Microsoft.VisualStudioCode'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = 'https://code.visualstudio.com/download' },
    [pscustomobject]@{ nome = 'Zoom Workplace'; finalidade = 'Videoconferência'; perfil = 'base'; prioridade = 'essencial'; versao = ''; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'Zoom.Zoom'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'CamStudio'; finalidade = 'Gravação de tela'; perfil = 'base'; prioridade = 'sob-demanda'; versao = '2.7.4'; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'CorelDRAW Graphics Suite'; finalidade = 'Design gráfico e vetorização'; perfil = 'base'; prioridade = 'sob-demanda'; versao = '2025'; licenca = 'pago'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'CPUID HW Monitor'; finalidade = 'Monitor de temperatura e sensores do PC'; perfil = 'base'; prioridade = 'sob-demanda'; versao = '1.47'; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'CPUID.HWMonitor'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'Inkscape'; finalidade = 'Vetorização gráfica'; perfil = 'base'; prioridade = 'sob-demanda'; versao = ''; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'Inkscape.Inkscape'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'MathType'; finalidade = 'Editor de equações'; perfil = 'base'; prioridade = 'sob-demanda'; versao = ''; licenca = 'pago'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'Mozilla Firefox (x64)'; finalidade = 'Navegador web'; perfil = 'base'; prioridade = 'sob-demanda'; versao = ''; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'Mozilla.Firefox'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'PDF-XChange Editor'; finalidade = 'Edição de arquivos PDF'; perfil = 'base'; prioridade = 'sob-demanda'; versao = ''; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'TrackerSoftware.PDF-XChangeEditor'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'VLC Media Player'; finalidade = 'Reprodutor multimídia'; perfil = 'base'; prioridade = 'sob-demanda'; versao = '3.0.20'; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'VideoLAN.VLC'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'Atmel Driver Files'; finalidade = 'Drivers para microcontroladores Atmel'; perfil = 'firmware'; prioridade = 'essencial'; versao = ''; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'MPLAB X IDE / MPLAB IPE'; finalidade = 'IDE microcontrolador Microchip e Atmel'; perfil = 'firmware'; prioridade = 'essencial'; versao = '6.25+'; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = 'https://www.microchip.com/en-us/tools-resources/develop/mplab-x-ide' },
    [pscustomobject]@{ nome = 'MPLAB XC-DSC'; finalidade = 'Compilador Microchip dsPIC'; perfil = 'firmware'; prioridade = 'essencial'; versao = ''; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = 'https://www.microchip.com/en-us/tools-resources/develop/mplab-xc-compilers/xc-dsc' },
    [pscustomobject]@{ nome = 'MPLAB XC16'; finalidade = 'Compilador Microchip 16 bits'; perfil = 'firmware'; prioridade = 'essencial'; versao = ''; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'Microchip.MPLABXC16CCompiler'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'MPLAB XC8'; finalidade = 'Compilador Microchip 8 bits'; perfil = 'firmware'; prioridade = 'essencial'; versao = ''; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'Microchip.MPLABXC8CCompiler'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'PICkit 2'; finalidade = 'Gravador e depurador Microchip'; perfil = 'firmware'; prioridade = 'essencial'; versao = '2.61'; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = 'https://www.microchip.com/en-us/development-tools-tools-and-software/mplab-ecosystem-downloads-archive' },
    [pscustomobject]@{ nome = 'PICkit 3'; finalidade = 'Gravador de microcontroladores PIC'; perfil = 'firmware'; prioridade = 'essencial'; versao = '3.10'; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = 'https://www.microchip.com/en-us/development-tools-tools-and-software/mplab-ecosystem-downloads-archive' },
    [pscustomobject]@{ nome = 'PulseView'; finalidade = 'Analisador lógico'; perfil = 'firmware'; prioridade = 'essencial'; versao = '0.5.0'; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = 'https://sigrok.org/wiki/Downloads' },
    [pscustomobject]@{ nome = 'PuTTY'; finalidade = 'Comunicação serial'; perfil = 'firmware'; prioridade = 'essencial'; versao = '0.79'; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'PuTTY.PuTTY'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = 'https://putty.org/index.html' },
    [pscustomobject]@{ nome = 'RealTerm'; finalidade = 'Comunicação serial'; perfil = 'firmware'; prioridade = 'essencial'; versao = '2.0.0.70'; licenca = 'gratuito'; instalacao = 'download'; winget_id = ''; winget_versao = ''; download_url = 'https://downloads.sourceforge.net/project/realterm/Realterm/2.0.0.70/Realterm_2.0.0.70_Signed_Wrapper_setup.exe'; sha256 = 'F75B79C1E7FD34B0B33C848C6DF0BBE9AE48E981CB56002B42D63BB4B60E53B0'; args = ''; link = 'https://sourceforge.net/projects/realterm/' },
    [pscustomobject]@{ nome = 'Tera Term'; finalidade = 'Comunicação serial'; perfil = 'firmware'; prioridade = 'essencial'; versao = ''; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'TeraTermProject.teraterm5'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = 'https://teratermproject.github.io/index-en.html' },
    [pscustomobject]@{ nome = 'Arduino IDE'; finalidade = 'IDE microcontrolador Arduino'; perfil = 'firmware'; prioridade = 'sob-demanda'; versao = '2.3.4'; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'ArduinoSA.IDE.stable'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = 'https://support.arduino.cc/hc/en-us/articles/360019833020-Download-and-install-Arduino-IDE' },
    [pscustomobject]@{ nome = 'CCS C Compiler (PIC-C)'; finalidade = 'IDE e compilador C para PIC'; perfil = 'firmware'; prioridade = 'sob-demanda'; versao = '5.015'; licenca = 'pago'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'CMT IDE / CMT Writer'; finalidade = 'IDE microcontrolador Hope RF'; perfil = 'firmware'; prioridade = 'sob-demanda'; versao = '2.1.5 / 5.2.3'; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'e² studio / Renesas Flash Programmer'; finalidade = 'IDE microcontrolador Renesas'; perfil = 'firmware'; prioridade = 'sob-demanda'; versao = '24.7.0 / 3.19'; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = 'https://www.renesas.com/en/software-tool/e2-studio' },
    [pscustomobject]@{ nome = 'FMD IDE / FMD Programmer'; finalidade = 'IDE microcontrolador FMD'; perfil = 'firmware'; prioridade = 'sob-demanda'; versao = '3.1.1.3 / 5.3.8.0'; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'HT-IDE3000 / HOPE3000'; finalidade = 'IDE microcontrolador Holtek'; perfil = 'firmware'; prioridade = 'sob-demanda'; versao = ''; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'Keil uVision'; finalidade = 'IDE núcleo ARM'; perfil = 'firmware'; prioridade = 'sob-demanda'; versao = '5.42.0.0'; licenca = 'pago'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'MCUXpresso IDE / Config Tools'; finalidade = 'IDE microcontrolador NXP'; perfil = 'firmware'; prioridade = 'sob-demanda'; versao = 'v11.8.1_1197 / v15'; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'Microchip Studio'; finalidade = 'IDE microcontrolador Microchip e Atmel'; perfil = 'firmware'; prioridade = 'sob-demanda'; versao = '7.0.2594'; licenca = 'gratuito'; instalacao = 'download'; winget_id = ''; winget_versao = ''; download_url = 'https://ww1.microchip.com/downloads/aemDocuments/documents/DEV/ProductDocuments/SoftwareTools/as-installer-7.0.2594-full.exe'; sha256 = 'C964AD7F5F11924805D679A4F3E02D9D15EC82D3F84E58407675109FD8E93BC2'; args = ''; link = 'https://www.microchip.com/en-us/tools-resources/develop/microchip-studio' },
    [pscustomobject]@{ nome = 'Nextion Editor'; finalidade = 'Editor de telas HMI Nextion'; perfil = 'firmware'; prioridade = 'sob-demanda'; versao = '3.1.59'; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = 'https://nextion.tech/nextion-editor/' },
    [pscustomobject]@{ nome = 'Node.js'; finalidade = 'Ambiente JavaScript (ferramentas de desenvolvimento)'; perfil = 'firmware'; prioridade = 'sob-demanda'; versao = '22.16.0'; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'OpenJS.NodeJS.LTS'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'NuEclipse / NuMicro ICP Programming Tool'; finalidade = 'IDE microcontrolador Nuvoton'; perfil = 'firmware'; prioridade = 'sob-demanda'; versao = '1.02.024r'; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'NYIDE / Q-Writer'; finalidade = 'IDE microcontrolador Nyquest'; perfil = 'firmware'; prioridade = 'sob-demanda'; versao = '5.10 / 5.44'; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'Padauk FPPA IDE / Writer'; finalidade = 'IDE microcontrolador Padauk'; perfil = 'firmware'; prioridade = 'sob-demanda'; versao = '1.0.3A1'; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'Postman'; finalidade = 'Teste de APIs HTTP'; perfil = 'firmware'; prioridade = 'sob-demanda'; versao = '11.20.0'; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'Postman.Postman'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'PSoC Creator / PSoC Programmer'; finalidade = 'IDE microcontrolador Infineon'; perfil = 'firmware'; prioridade = 'sob-demanda'; versao = '4.4 / 3.29.6'; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'Visual Studio 2022'; finalidade = 'IDE C/C++/C# para aplicações Windows'; perfil = 'firmware'; prioridade = 'sob-demanda'; versao = ''; licenca = 'pago'; instalacao = 'winget'; winget_id = 'Microsoft.VisualStudio.2022.Community'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'AppCAD'; finalidade = 'Calculadora de RF e microondas'; perfil = 'hardware'; prioridade = 'essencial'; versao = '4.0.0'; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'DFM Now!'; finalidade = 'Análise de manufaturabilidade de PCB'; perfil = 'hardware'; prioridade = 'essencial'; versao = '8.1.6'; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'FreeCAD'; finalidade = 'Modelagem CAD 3D'; perfil = 'hardware'; prioridade = 'essencial'; versao = '1.0.0'; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'FreeCAD.FreeCAD'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'Octave'; finalidade = 'Ambiente matemático'; perfil = 'hardware'; prioridade = 'essencial'; versao = '7.2.0'; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'GNU.Octave'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'QSpice'; finalidade = 'Simulador eletrônico'; perfil = 'hardware'; prioridade = 'essencial'; versao = ''; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = 'https://www.qorvo.com/design-hub/calculators-simulation/qspice/get-qspice' },
    [pscustomobject]@{ nome = 'Altium'; finalidade = 'Projeto de placas antigos para revisar (fora de rede)'; perfil = 'hardware'; prioridade = 'sob-demanda'; versao = '18+'; licenca = 'pago'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'AutoCAD'; finalidade = 'CAD 2D/3D mecânico'; perfil = 'hardware'; prioridade = 'sob-demanda'; versao = '2021+'; licenca = 'pago'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'CircuitStudio'; finalidade = 'CAD eletrônico'; perfil = 'hardware'; prioridade = 'sob-demanda'; versao = '1.5.2.30'; licenca = 'pago'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'Mathcad'; finalidade = 'Cálculo e documentação de engenharia (fora de rede)'; perfil = 'hardware'; prioridade = 'sob-demanda'; versao = '15'; licenca = 'pago'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'Matlab'; finalidade = 'Simulação de modelos matemáticos'; perfil = 'hardware'; prioridade = 'sob-demanda'; versao = '2022+'; licenca = 'pago'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'DIALux evo'; finalidade = 'Cálculo luminotécnico'; perfil = 'iluminacao'; prioridade = 'essencial'; versao = ''; licenca = 'gratuito'; instalacao = 'winget'; winget_id = 'DIAL.DIALux-evo'; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'ICAP 4 Windows Demo'; finalidade = 'Software óptico / fotometria'; perfil = 'iluminacao'; prioridade = 'essencial'; versao = 'Build 4444'; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'LSG-1800B Goniophotometer'; finalidade = 'Medições fotométricas (goniofotômetro)'; perfil = 'iluminacao'; prioridade = 'essencial'; versao = ''; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'LTD Editor'; finalidade = 'Editor de curvas IES'; perfil = 'iluminacao'; prioridade = 'essencial'; versao = '1.5.1.0'; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'OxyTech LITESTAR 4D'; finalidade = 'Simulação luminotécnica'; perfil = 'iluminacao'; prioridade = 'essencial'; versao = ''; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'AC SOURCE GUI'; finalidade = 'Controle da fonte AC programável'; perfil = 'bancada'; prioridade = 'essencial'; versao = ''; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'ANL7000'; finalidade = 'Software técnico de instrumentação: analisador de energia'; perfil = 'bancada'; prioridade = 'essencial'; versao = '5.05'; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'CPR Standard USB Driver'; finalidade = 'Driver USB'; perfil = 'bancada'; prioridade = 'essencial'; versao = '2.5.0.0'; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'Fresco Logic USB Display Driver'; finalidade = 'Driver de vídeo USB'; perfil = 'bancada'; prioridade = 'essencial'; versao = '2.1.36287.0'; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'RIGOL Ultra Sigma'; finalidade = 'Controle de instrumentos Rigol pelo PC'; perfil = 'bancada'; prioridade = 'essencial'; versao = '1.6.1'; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' },
    [pscustomobject]@{ nome = 'S1210 EMI Pre-Compliance'; finalidade = 'Pré-conformidade EMI'; perfil = 'bancada'; prioridade = 'essencial'; versao = '00.06.00.02'; licenca = 'gratuito'; instalacao = 'manual'; winget_id = ''; winget_versao = ''; download_url = ''; sha256 = ''; args = ''; link = '' }
)

$Perfis = [ordered]@{
    'base' = 'Todos os colaboradores'
    'firmware' = 'Desenvolvimento de firmware: microcontroladores, gravadores, comunicação serial'
    'hardware' = 'Projeto de hardware e eletrônica de potência: simulação, cálculo, CAD'
    'iluminacao' = 'Luminotécnica e fotometria'
    'bancada' = 'Quem usa os equipamentos de bancada (analisador de energia, fonte AC, osciloscópio, EMI)'
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
    $simular.Text = 'Simular (não instala nada, só mostra o que faria)'
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
        Write-Host "  $r"
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
