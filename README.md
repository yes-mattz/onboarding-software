# Instalação de software: novo colaborador

Instala os programas usados na equipe no seu PC. Você escolhe o seu perfil numa janela e o script faz o resto; o que não dá para instalar sozinho abre a página do fabricante no fim.

## Como usar

1. Abrir o PowerShell (menu Iniciar, digitar `PowerShell`, Enter). Não precisa ser como administrador.
2. Colar este comando e dar Enter:
   ```
   irm yes-mattz.github.io/onboarding-software/i.txt | iex
   ```
3. Confirmar o aviso do Windows pedindo permissão de administrador. Abre uma janela nova.
4. Na janela de seleção, marcar o(s) perfil(is) da sua função. Os essenciais já vêm marcados; desmarque o que não quiser e marque os sob demanda que o seu projeto usa. Para só ver o que aconteceria, marque "Simular".
5. Clicar em Instalar e acompanhar. Instaladores baixados do fabricante abrem as telas normais: seguir com as opções padrão.
6. No fim, o resumo mostra o que foi instalado, o que falhou e o que é manual. As páginas dos manuais abrem no navegador.
7. Fazer a conferência final (abaixo).

Dúvidas e licenças: Cristiano Facco.

Confira se o endereço no comando é exatamente este repositório antes de rodar: o script roda como administrador.

## Perfis

O perfil `base` vai para todos. Some a ele o(s) da sua função; na dúvida, pergunte ao seu gestor.

| Perfil | Para quem | Essenciais |
|---|---|---|
| `base` | Todos os colaboradores | 13 |
| `firmware` | Desenvolvimento de firmware: microcontroladores, gravadores, comunicação serial | 11 |
| `hardware` | Projeto de hardware e eletrônica de potência: simulação, cálculo, CAD | 5 |
| `iluminacao` | Luminotécnica e fotometria | 5 |
| `bancada` | Quem usa os equipamentos de bancada (analisador de energia, fonte AC, osciloscópio, EMI) | 6 |

## Programas por perfil

### base

Todos os colaboradores.

**Essenciais**

| Programa | Para que serve | Versão | Instalação | Licença |
|---|---|---|---|---|
| AnyDesk | Acesso remoto | última | automático (winget) | pago |
| Foxit PDF Reader | Leitor de PDF | última | automático (winget) | gratuito |
| Git | Controle de versão de código | última | automático (winget) | gratuito |
| Google Chrome | Navegador web | última | automático (winget) | gratuito |
| KiCad | CAD eletrônico (esquemático e PCB) | última | automático (winget) | gratuito |
| LTspice | Simulador eletrônico | última | automático (winget) | gratuito |
| Notepad++ | Editor de texto | última | automático (winget) | gratuito |
| Office Desktop | Word, PowerPoint, OneNote, Excel e Outlook | última | automático (winget) | pago |
| PowerToys | Ferramenta de produtividade do Windows | última | automático (winget) | gratuito |
| SMath Studio | Cálculo matemático | última | automático (winget) | gratuito |
| TortoiseGit | Interface Git para Windows | última | automático (winget) | gratuito |
| Visual Studio Code | Editor de código (IDE) | última | automático (winget) | gratuito |
| Zoom Workplace | Videoconferência | última | automático (winget) | gratuito |

**Sob demanda**

| Programa | Para que serve | Versão | Instalação | Licença |
|---|---|---|---|---|
| CamStudio | Gravação de tela | 2.7.4 | manual: pedir a Cristiano Facco | gratuito |
| CorelDRAW Graphics Suite | Design gráfico e vetorização | 2025 | manual: pedir a Cristiano Facco | pago |
| CPUID HW Monitor | Monitor de temperatura e sensores do PC | última | automático (winget) | gratuito |
| Inkscape | Vetorização gráfica | última | automático (winget) | gratuito |
| MathType | Editor de equações | - | manual: pedir a Cristiano Facco | pago |
| Mozilla Firefox (x64) | Navegador web | última | automático (winget) | gratuito |
| PDF-XChange Editor | Edição de arquivos PDF | última | automático (winget) | gratuito |
| VLC Media Player | Reprodutor multimídia | última | automático (winget) | gratuito |

### firmware

Desenvolvimento de firmware: microcontroladores, gravadores, comunicação serial.

**Essenciais**

| Programa | Para que serve | Versão | Instalação | Licença |
|---|---|---|---|---|
| Atmel Driver Files | Drivers para microcontroladores Atmel | - | manual: pedir a Cristiano Facco | gratuito |
| MPLAB X IDE / MPLAB IPE | IDE microcontrolador Microchip e Atmel | 6.25+ | manual: [página do fabricante](https://www.microchip.com/en-us/tools-resources/develop/mplab-x-ide) | gratuito |
| MPLAB XC-DSC | Compilador Microchip dsPIC | - | manual: [página do fabricante](https://www.microchip.com/en-us/tools-resources/develop/mplab-xc-compilers/xc-dsc) | gratuito |
| MPLAB XC16 | Compilador Microchip 16 bits | última | automático (winget) | gratuito |
| MPLAB XC8 | Compilador Microchip 8 bits | última | automático (winget) | gratuito |
| PICkit 2 | Gravador e depurador Microchip | 2.61 | manual: [página do fabricante](https://www.microchip.com/en-us/development-tools-tools-and-software/mplab-ecosystem-downloads-archive) | gratuito |
| PICkit 3 | Gravador de microcontroladores PIC | 3.10 | manual: [página do fabricante](https://www.microchip.com/en-us/development-tools-tools-and-software/mplab-ecosystem-downloads-archive) | gratuito |
| PulseView | Analisador lógico | 0.5.0 | manual: [página do fabricante](https://sigrok.org/wiki/Downloads) | gratuito |
| PuTTY | Comunicação serial | última | automático (winget) | gratuito |
| RealTerm | Comunicação serial | 2.0.0.70 | automático (site do fabricante, com conferência de hash) | gratuito |
| Tera Term | Comunicação serial | última | automático (winget) | gratuito |

**Sob demanda**

| Programa | Para que serve | Versão | Instalação | Licença |
|---|---|---|---|---|
| Arduino IDE | IDE microcontrolador Arduino | última | automático (winget) | gratuito |
| CCS C Compiler (PIC-C) | IDE e compilador C para PIC | 5.015 | manual: pedir a Cristiano Facco | pago |
| CMT IDE / CMT Writer | IDE microcontrolador Hope RF | 2.1.5 / 5.2.3 | manual: pedir a Cristiano Facco | gratuito |
| e² studio / Renesas Flash Programmer | IDE microcontrolador Renesas | 24.7.0 / 3.19 | manual: [página do fabricante](https://www.renesas.com/en/software-tool/e2-studio) | gratuito |
| FMD IDE / FMD Programmer | IDE microcontrolador FMD | 3.1.1.3 / 5.3.8.0 | manual: pedir a Cristiano Facco | gratuito |
| HT-IDE3000 / HOPE3000 | IDE microcontrolador Holtek | - | manual: pedir a Cristiano Facco | gratuito |
| Keil uVision | IDE núcleo ARM | 5.42.0.0 | manual: pedir a Cristiano Facco | pago |
| MCUXpresso IDE / Config Tools | IDE microcontrolador NXP | v11.8.1_1197 / v15 | manual: pedir a Cristiano Facco | gratuito |
| Microchip Studio | IDE microcontrolador Microchip e Atmel | 7.0.2594 | automático (site do fabricante, com conferência de hash) | gratuito |
| Nextion Editor | Editor de telas HMI Nextion | 3.1.59 | manual: [página do fabricante](https://nextion.tech/nextion-editor/) | gratuito |
| Node.js | Ambiente JavaScript (ferramentas de desenvolvimento) | última | automático (winget) | gratuito |
| NuEclipse / NuMicro ICP Programming Tool | IDE microcontrolador Nuvoton | 1.02.024r | manual: pedir a Cristiano Facco | gratuito |
| NYIDE / Q-Writer | IDE microcontrolador Nyquest | 5.10 / 5.44 | manual: pedir a Cristiano Facco | gratuito |
| Padauk FPPA IDE / Writer | IDE microcontrolador Padauk | 1.0.3A1 | manual: pedir a Cristiano Facco | gratuito |
| Postman | Teste de APIs HTTP | última | automático (winget) | gratuito |
| PSoC Creator / PSoC Programmer | IDE microcontrolador Infineon | 4.4 / 3.29.6 | manual: pedir a Cristiano Facco | gratuito |
| Visual Studio 2022 | IDE C/C++/C# para aplicações Windows | última | automático (winget) | pago |

### hardware

Projeto de hardware e eletrônica de potência: simulação, cálculo, CAD.

**Essenciais**

| Programa | Para que serve | Versão | Instalação | Licença |
|---|---|---|---|---|
| AppCAD | Calculadora de RF e microondas | 4.0.0 | manual: pedir a Cristiano Facco | gratuito |
| DFM Now! | Análise de manufaturabilidade de PCB | 8.1.6 | manual: pedir a Cristiano Facco | gratuito |
| FreeCAD | Modelagem CAD 3D | última | automático (winget) | gratuito |
| Octave | Ambiente matemático | última | automático (winget) | gratuito |
| QSpice | Simulador eletrônico | - | manual: [página do fabricante](https://www.qorvo.com/design-hub/calculators-simulation/qspice/get-qspice) | gratuito |

**Sob demanda**

| Programa | Para que serve | Versão | Instalação | Licença |
|---|---|---|---|---|
| Altium | Projeto de placas antigos para revisar (fora de rede) | 18+ | manual: pedir a Cristiano Facco | pago |
| AutoCAD | CAD 2D/3D mecânico | 2021+ | manual: pedir a Cristiano Facco | pago |
| CircuitStudio | CAD eletrônico | 1.5.2.30 | manual: pedir a Cristiano Facco | pago |
| Mathcad | Cálculo e documentação de engenharia (fora de rede) | 15 | manual: pedir a Cristiano Facco | pago |
| Matlab | Simulação de modelos matemáticos | 2022+ | manual: pedir a Cristiano Facco | pago |

### iluminacao

Luminotécnica e fotometria.

**Essenciais**

| Programa | Para que serve | Versão | Instalação | Licença |
|---|---|---|---|---|
| DIALux evo | Cálculo luminotécnico | última | automático (winget) | gratuito |
| ICAP 4 Windows Demo | Software óptico / fotometria | Build 4444 | manual: pedir a Cristiano Facco | gratuito |
| LSG-1800B Goniophotometer | Medições fotométricas (goniofotômetro) | - | manual: pedir a Cristiano Facco | gratuito |
| LTD Editor | Editor de curvas IES | 1.5.1.0 | manual: pedir a Cristiano Facco | gratuito |
| OxyTech LITESTAR 4D | Simulação luminotécnica | - | manual: pedir a Cristiano Facco | gratuito |

### bancada

Quem usa os equipamentos de bancada (analisador de energia, fonte AC, osciloscópio, EMI).

**Essenciais**

| Programa | Para que serve | Versão | Instalação | Licença |
|---|---|---|---|---|
| AC SOURCE GUI | Controle da fonte AC programável | - | manual: pedir a Cristiano Facco | gratuito |
| ANL7000 | Software técnico de instrumentação: analisador de energia | 5.05 | manual: pedir a Cristiano Facco | gratuito |
| CPR Standard USB Driver | Driver USB | 2.5.0.0 | manual: pedir a Cristiano Facco | gratuito |
| Fresco Logic USB Display Driver | Driver de vídeo USB | 2.1.36287.0 | manual: pedir a Cristiano Facco | gratuito |
| RIGOL Ultra Sigma | Controle de instrumentos Rigol pelo PC | 1.6.1 | manual: pedir a Cristiano Facco | gratuito |
| S1210 EMI Pre-Compliance | Pré-conformidade EMI | 00.06.00.02 | manual: pedir a Cristiano Facco | gratuito |

## Programas pagos

Precisam de licença da empresa: pedir a Cristiano Facco antes de usar.

- AnyDesk (base, essencial)
- Office Desktop (base, essencial)
- CorelDRAW Graphics Suite (base, sob-demanda)
- MathType (base, sob-demanda)
- CCS C Compiler (PIC-C) (firmware, sob-demanda)
- Keil uVision (firmware, sob-demanda)
- Visual Studio 2022 (firmware, sob-demanda)
- Altium (hardware, sob-demanda)
- AutoCAD (hardware, sob-demanda)
- CircuitStudio (hardware, sob-demanda)
- Mathcad (hardware, sob-demanda)
- Matlab (hardware, sob-demanda)

## Conferência final

- [ ] Abrir cada programa essencial uma vez (alguns terminam a configuração na primeira execução).
- [ ] Office: entrar com a conta da empresa.
- [ ] Git: `git config --global user.name "Seu Nome"` e `git config --global user.email "seu@email"`.
- [ ] firmware: ligar o gravador (PICkit) e conferir se o MPLAB IPE reconhece; abrir uma porta COM no terminal serial.
- [ ] Reiniciar o PC se instalou drivers.

## Problemas comuns

- `winget` não encontrado: instalar o "Instalador de Aplicativo" (App Installer) pela Microsoft Store e rodar o comando de novo.
- O comando não faz nada ou dá erro de rede: antivírus ou proxy bloqueando. Baixar o [instalar.ps1](instalar.ps1), botão direito, "Executar com o PowerShell".
- Um programa do winget falhou: o resumo mostra o código; rodar o comando de novo e marcar só ele.
- "SHA-256 diferente": o fabricante trocou o arquivo no site. O script não executa; avisar o responsável para atualizar a lista.
- Log completo: `%TEMP%\onboarding-<data>.log`.

<sub>Gerado de `software.csv` em 2026-10-11 por `gerar_guia.py`. Não editar este arquivo à mão; manutenção em [MANUTENCAO.md](MANUTENCAO.md).</sub>
