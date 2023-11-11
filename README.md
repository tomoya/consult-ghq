# consult-ghq: Ghq interface using consult

https://user-images.githubusercontent.com/18009/120468941-b8779c00-c3dc-11eb-872d-42ac5689e03a.mp4

## Commands

This package provides these commands.

### consult-ghq-find

Select a repository from the [ghq](https://github.com/x-motemen/ghq) list and then find repository files using [affe-find](https://github.com/minad/affe) (if installed) or consult-find.

If you want to use consult-find despite having affe installed, you can change like below:

```elisp
(setq consult-ghq-find-function #'consult-find)
```

### consult-ghq-grep

Select a repository from the ghq list and then grep repository files using affe-grep (similar to consult-ripgrep or consult-grep).

Also, you can change grep function like below:

```elisp
(setq consult-ghq-grep-function #'consult-grep)
```

### consult-ghq-switch-project

Select a project from the ghq list and then switch to it via project.el (default) or projectile

You can change switch project function like below:

```elisp
(setq consult-ghq-switch-project-function #'projectile-switch-project)
```
