---
title: "My X Vim Tips"
date: 2023-06-22T15:55:30+02:00
categories:
- vim
- neovim
- tips
---
## Intro

This document is useful for using Vim (neovim) and other tools.


## 1. Edit the current shell command in Vim
>Note: assuming
```
export EDITOR=nvim
# Enable Ctrl-x-e to edit the command line
autoload -U edit-command-line
```

```
Ctrl-x Ctrl-e
```

## 2. Rename a few files at a time using VIM
```
curl https://raw.githubusercontent.com/thameera/vimv/master/vimv > /usr/local/bin/vimv && chmod +755 /usr/local/bin/vimv
```

`vimv *.txt`


P.S. Of course, you need the `$EDITOR` env variable.

## 3. Jump to interesting elements in an editor:

```
$ git jump diff
```

So assume you have such a diff:

```diff
diff --git foo.c foo.c
index a655540..5a59044 100644
--- foo.c
+++ foo.c
@@ -1,3 +1,3 @@
 int main(void) {
-  printf("hello word!\n");
+  printf("hello world!\n");
 }
```

`$ git jump diff`

Will open an `$EDITOR` on `foo.c:3`.



To be continued…
