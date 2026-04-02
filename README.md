# 🚀 Make Git faster with aliases

A consistent, prefix-based dialect for high-productivity Git usage.

Examples:

- `git st` → `git status`
- `git cm` → `git commit`
- `git pl` → `git pull`

## 🛠️ Install

```bash
curl -sL https://raw.githubusercontent.com/rockberpro/git-aliases/main/setup.sh | bash
```

The script downloads `git-aliases.gitconfig` to `~/.git-aliases.gitconfig` and automatically adds the `[include]` to your global `~/.gitconfig`.

## 📋 Alias list

| Alias | Command                                     |
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
| dfw   | diff --ignore-all-space                     |
| dfwd  | diff --word-diff                            |
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
| rbo   | rebase --onto                               |
| rs    | restore                                     |
| rsa   | restore .                                   |
| rss   | restore --staged                            |
| rst   | reset                                       |
| rt    | remote                                      |
| rv    | revert                                      |
| scb   | branch --show-current                       |
| sh    | show --patch                                |
| st    | status                                      |
| sts   | status --short --branch                     |
| sth   | stash                                       |
| sthc  | stash clear                                 |
| sthd  | stash drop                                  |
| sthl  | stash list                                  |
| stho  | stash pop                                   |
| sthp  | stash push                                  |
| stha  | stash apply                                 |
| sths  | stash show --patch                          |
| sw    | switch                                      |
| swc   | switch --create                             |
| tg    | tag                                         |

## 💡 Tip

Edit `git-aliases.gitconfig` to add, remove, or adjust aliases to your preference.

---

[setup.sh](setup.sh) · [git-aliases.gitconfig](git-aliases.gitconfig)
