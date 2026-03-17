# 🚀 Torne o Git mais rápido com aliases

Este repositório aplica aliases Git úteis para agilizar seu fluxo de trabalho. Execute o script uma vez e passe a usar comandos curtos e memoráveis.

## ✨ O que este script faz

O script adiciona aliases ao seu `git config --global`, encurtando comandos comuns.

Exemplos rápidos:

- `git st` → `git status`
- `git cm` → `git commit`
- `git pl` → `git pull`

## 🛠️ Como usar

1. Clone ou baixe este repositório
2. Torne o script executável:
```bash
chmod +x git-aliases.sh
```
3. Execute:
```bash
./git-aliases.sh
```
4. Pronto — os aliases estarão no seu `~/.gitconfig` global.

## 📋 Lista de aliases (definidos em `git-aliases.sh`)

| Alias | Comando original                            |
| ----- | ------------------------------------------- |
| ad    | add                                         |
| ada   | add .                                       |
| adu   | add --update                                |
| bl    | blame                                       |
| br    | branch                                      |
| brd   | branch --delete                             |
| brl   | branch --list                               |
| cfg   | config                                      |
| cfgl  | config --list                               |
| cln   | clean                                       |
| clf   | clean --force                               |
| clf   | clean --force                               |
| clo   | clone                                       |
| cha   | cherry-pick --abort                         |
| chc   | cherry-pick --continue                      |
| chp   | cherry-pick                                 |
| cm    | commit                                      |
| cmf   | commit --fixup                              |
| cma   | commit --amend                              |
| cmn   | commit --amend --no-edit                    |
| cmm   | commit --message                            |
| ck    | checkout                                    |
| df    | diff                                        |
| dfc   | diff --cached                               |
| ds    | describe                                    |
| ft    | fetch                                       |
| ftp   | fetch --prune                               |
| gp    | grep                                        |
| in    | init                                        |
| lg    | log                                         |
| lgo   | log --graph --oneline --decorate --all      |
| lgh   | log HEAD                                    |
| lgp   | log --patch                                 |
| mg    | merge                                       |
| mga   | merge --abort                               |
| mgc   | merge --continue                            |
| mgs   | merge --squash                              |
| pl    | pull                                        |
| plh   | pull origin HEAD                            |
| ps    | push                                        |
| psf   | push --force-with-lease                     |
| psh   | push origin HEAD                            |
| pshf  | push origin HEAD --force-with-lease         |
| rb    | rebase                                      |
| rba   | rebase --abort                              |
| rbc   | rebase --continue                           |
| rbi   | rebase --interactive                        |
| rs    | restore                                     |
| rsa   | restore .                                   |
| rss   | restore --staged                            |
| rst   | reset                                       |
| rt    | remote                                      |
| rv    | revert                                      |
| scb   | branch --show-current                       |
| sh    | show                                        |
| st    | status                                      |
| sts   | status --short --branch                     |
| sth   | stash                                       |
| sthd  | stash drop                                  |
| sthl  | stash list                                  |
| sthp  | stash pop                                   |
| stha  | stash apply                                 |
| sths  | stash show                                  |
| sw    | switch                                      |
| swc   | switch --create                             |
| tg    | tag                                         |

## 💡 Dica

Edite `git-aliases.sh` para adicionar, remover ou ajustar aliases conforme suas preferências.

---

Arquivo do script: [git-aliases.sh](git-aliases.sh)
