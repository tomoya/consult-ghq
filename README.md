# consult-ghq: Ghq interface using consult

## Command

- consult-ghq

Select a repository from the [ghq](https://github.com/x-motemen/ghq) list and then find repository files using [affe-find](https://github.com/minad/affe) (similar to consult-find).

If you want to use consult-find instead, you can change like bellow:

```elisp
(setq consult-ghq-find-function #'consult-find)
```
