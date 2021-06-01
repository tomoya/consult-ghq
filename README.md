# consult-ghq: Ghq interface using consult

## Commands

This packaage provides these commands.

### consult-ghq-find

Select a repository from the [ghq](https://github.com/x-motemen/ghq) list and then find repository files using [affe-find](https://github.com/minad/affe) (similar to consult-find).

If you want to use consult-find instead, you can change like bellow:

```elisp
(setq consult-ghq-find-function #'consult-find)
```

### consult-ghq-grep

Select a repository from the ghq list and then grep repository files using affe-grep (similar to consult-ripgrep or consult-grep).

Also, you can change grep function like bellow:

```elisp
(setq consult-ghq-grep-function #'consult-grep)
```
