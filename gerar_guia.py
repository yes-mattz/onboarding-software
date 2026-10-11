"""Gera README.md (guia do colaborador), instalar.ps1 e i.txt a partir de software.csv.

software.csv é a fonte única; instalar.ps1 sai de modelo_instalar.ps1 com os dados embutidos.
Para mudar o guia ou o script, editar o CSV (ou o modelo) e rodar de novo.

Uso: python gerar_guia.py
"""

import csv
import re
import sys
from datetime import date
from pathlib import Path

PASTA = Path(__file__).resolve().parent
CSV = PASTA / "software.csv"
MODELO = PASTA / "modelo_instalar.ps1"

# i.txt é cópia de instalar.ps1 servida pelo GitHub Pages: endereço curto e text/plain
# (o Pages entrega .ps1 como octet-stream, que o irm do PowerShell 7 pode devolver como bytes).
# Sem https:// no comando para encurtar: o irm usa http e o Pages redireciona para https.
URL_SCRIPT = "https://yes-mattz.github.io/onboarding-software/i.txt"
COMANDO = f"irm {URL_SCRIPT.removeprefix('https://')} | iex"

# Quem responde dúvidas e libera licenças. Preencher e rodar de novo.
RESPONSAVEL = "Cristiano Facco"

PERFIS = {
    "base": "Todos os colaboradores",
    "firmware": "Desenvolvimento de firmware: microcontroladores, gravadores, comunicação serial",
    "hardware": "Projeto de hardware e eletrônica de potência: simulação, cálculo, CAD",
    "iluminacao": "Luminotécnica e fotometria",
    "bancada": "Quem usa os equipamentos de bancada (analisador de energia, fonte AC, osciloscópio, EMI)",
}
PRIORIDADES = {"essencial", "sob-demanda"}
LICENCAS = {"gratuito", "pago"}
INSTALACOES = {"winget", "download", "manual"}
CAMPOS_PS = ("nome", "finalidade", "perfil", "prioridade", "versao", "licenca", "instalacao",
             "winget_id", "winget_versao", "download_url", "sha256", "args", "link")


def ler():
    with open(CSV, encoding="utf-8-sig", newline="") as f:
        linhas = [{k: (v or "").strip() for k, v in r.items()} for r in csv.DictReader(f)]
    erros = []
    for i, r in enumerate(linhas, start=2):
        onde = f"linha {i} ({r['nome']})"
        for campo, validos in (("perfil", PERFIS), ("prioridade", PRIORIDADES),
                               ("licenca", LICENCAS), ("instalacao", INSTALACOES)):
            if r[campo] not in validos:
                erros.append(f"{onde}: {campo} '{r[campo]}' inválido")
        if r["instalacao"] == "winget" and not r["winget_id"]:
            erros.append(f"{onde}: winget sem winget_id")
        if r["instalacao"] == "download":
            if not r["download_url"].startswith("https://"):
                erros.append(f"{onde}: download sem download_url https")
            if not re.fullmatch(r"[0-9A-Fa-f]{64}", r["sha256"]):
                erros.append(f"{onde}: download sem sha256 válido")
    nomes = [r["nome"] for r in linhas]
    erros += [f"nome repetido: {n}" for n in sorted({n for n in nomes if nomes.count(n) > 1})]
    return linhas, erros


def responsavel():
    return RESPONSAVEL or "(responsável a definir)"


def versao(r):
    if r["instalacao"] == "winget" and not r["winget_versao"]:
        return "última"
    return r["winget_versao"] or r["versao"] or "-"


def como_instala(r):
    if r["instalacao"] == "winget":
        return "automático (winget)"
    if r["instalacao"] == "download":
        return "automático (site do fabricante, com conferência de hash)"
    if r["link"]:
        return f"manual: [página do fabricante]({r['link']})"
    return f"manual: pedir a {responsavel()}"


def celula(texto):
    return texto.replace("|", "\\|")


def tabela(linhas):
    saida = ["| Programa | Para que serve | Versão | Instalação | Licença |", "|---|---|---|---|---|"]
    for r in linhas:
        saida.append(f"| {celula(r['nome'])} | {celula(r['finalidade'])} | {celula(versao(r))} | "
                     f"{como_instala(r)} | {r['licenca']} |")
    return saida


def gerar_readme(linhas):
    pagos = [r for r in linhas if r["licenca"] == "pago"]
    m = [
        "# Instalação de software: novo colaborador",
        "",
        "Instala os programas usados na equipe no seu PC. Você escolhe o seu perfil numa janela e o script faz o resto; "
        "o que não dá para instalar sozinho abre a página do fabricante no fim.",
        "",
        "## Como usar",
        "",
        "1. Abrir o PowerShell (menu Iniciar, digitar `PowerShell`, Enter). Não precisa ser como administrador.",
        "2. Colar este comando e dar Enter:",
        "   ```",
        f"   {COMANDO}",
        "   ```",
        "3. Confirmar o aviso do Windows pedindo permissão de administrador. Abre uma janela nova.",
        "4. Na janela de seleção, marcar o(s) perfil(is) da sua função. Os essenciais já vêm marcados; "
        "desmarque o que não quiser e marque os sob demanda que o seu projeto usa. "
        "Para só ver o que aconteceria, marque \"Simular\".",
        "5. Clicar em Instalar e acompanhar. Instaladores baixados do fabricante abrem as telas normais: "
        "seguir com as opções padrão.",
        "6. No fim, o resumo mostra o que foi instalado, o que falhou e o que é manual. "
        "As páginas dos manuais abrem no navegador.",
        "7. Fazer a conferência final (abaixo).",
        "",
        f"Dúvidas e licenças: {responsavel()}.",
        "",
        "Confira se o endereço no comando é exatamente este repositório antes de rodar: o script roda como administrador.",
        "",
        "## Perfis",
        "",
        "O perfil `base` vai para todos. Some a ele o(s) da sua função; na dúvida, pergunte ao seu gestor.",
        "",
        "| Perfil | Para quem | Essenciais |",
        "|---|---|---|",
    ]
    for p, desc in PERFIS.items():
        n = sum(1 for r in linhas if r["perfil"] == p and r["prioridade"] == "essencial")
        m.append(f"| `{p}` | {desc} | {n} |")
    m += ["", "## Programas por perfil", ""]
    for p, desc in PERFIS.items():
        do_perfil = [r for r in linhas if r["perfil"] == p]
        m += [f"### {p}", "", desc + ".", ""]
        for prio, titulo in (("essencial", "Essenciais"), ("sob-demanda", "Sob demanda")):
            grupo = [r for r in do_perfil if r["prioridade"] == prio]
            if grupo:
                m += [f"**{titulo}**", "", *tabela(grupo), ""]
    m += ["## Programas pagos", "",
          f"Precisam de licença da empresa: pedir a {responsavel()} antes de usar.", ""]
    m += [f"- {r['nome']} ({r['perfil']}, {r['prioridade']})" for r in pagos]
    m += [
        "",
        "## Conferência final",
        "",
        "- [ ] Abrir cada programa essencial uma vez (alguns terminam a configuração na primeira execução).",
        "- [ ] Office: entrar com a conta da empresa.",
        "- [ ] Git: `git config --global user.name \"Seu Nome\"` e `git config --global user.email \"seu@email\"`.",
        "- [ ] firmware: ligar o gravador (PICkit) e conferir se o MPLAB IPE reconhece; abrir uma porta COM no terminal serial.",
        "- [ ] Reiniciar o PC se instalou drivers.",
        "",
        "## Problemas comuns",
        "",
        "- `winget` não encontrado: instalar o \"Instalador de Aplicativo\" (App Installer) pela Microsoft Store e rodar o comando de novo.",
        "- O comando não faz nada ou dá erro de rede: antivírus ou proxy bloqueando. Baixar o "
        "[instalar.ps1](instalar.ps1), botão direito, \"Executar com o PowerShell\".",
        "- Um programa do winget falhou: o resumo mostra o código; rodar o comando de novo e marcar só ele.",
        "- \"SHA-256 diferente\": o fabricante trocou o arquivo no site. O script não executa; avisar o responsável para atualizar a lista.",
        "- Log completo: `%TEMP%\\onboarding-<data>.log`.",
        "",
        f"<sub>Gerado de `software.csv` em {date.today().isoformat()} por `gerar_guia.py`. Não editar este arquivo à mão; "
        "manutenção em [MANUTENCAO.md](MANUTENCAO.md).</sub>",
        "",
    ]
    return "\n".join(m)


def ps_texto(texto):
    return "'" + texto.replace("'", "''") + "'"


def gerar_ps1(linhas):
    dados = ",\n".join(
        "    [pscustomobject]@{ " + "; ".join(f"{k} = {ps_texto(r[k])}" for k in CAMPOS_PS) + " }"
        for r in linhas)
    perfis = "\n".join(f"    {ps_texto(p)} = {ps_texto(d)}" for p, d in PERFIS.items())
    texto = MODELO.read_text(encoding="utf-8")
    for marca, valor in (("#__DADOS__", dados), ("#__PERFIS__", perfis), ("__URL_SCRIPT__", URL_SCRIPT),
                         ("__RESPONSAVEL__", responsavel().replace("'", "''")), ("__DATA__", date.today().isoformat())):
        assert marca in texto, marca
        texto = texto.replace(marca, valor)
    return texto


def main():
    sys.stdout.reconfigure(encoding="utf-8")
    linhas, erros = ler()
    if erros:
        print("Erros no software.csv:")
        print("\n".join(f"  {e}" for e in erros))
        sys.exit(1)
    (PASTA / "README.md").write_text(gerar_readme(linhas), encoding="utf-8")
    # UTF-8 sem BOM: o BOM quebra o irm | iex. O próprio script regrava a cópia elevada com BOM.
    ps1 = gerar_ps1(linhas).replace("\r\n", "\n").replace("\n", "\r\n")
    for nome in ("instalar.ps1", "i.txt"):
        (PASTA / nome).write_bytes(ps1.encode("utf-8"))
    por_tipo = {t: sum(1 for r in linhas if r["instalacao"] == t) for t in sorted(INSTALACOES)}
    print(f"{len(linhas)} programas ({', '.join(f'{t}: {n}' for t, n in por_tipo.items())}).")
    print("Gerados README.md, instalar.ps1 e i.txt.")
    manuais = [r for r in linhas if r["instalacao"] == "manual" and r["prioridade"] == "essencial" and not r["link"]]
    if manuais:
        print(f"\nEssenciais manuais sem link ({len(manuais)}): o colaborador terá de pedir ao responsável.")
        for r in manuais:
            print(f"  {r['perfil']}: {r['nome']}")


if __name__ == "__main__":
    main()
