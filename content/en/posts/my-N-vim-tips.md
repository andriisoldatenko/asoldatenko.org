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

If you env variable `$EDITOR` is set to `vim`,
you can use `Ctrl-x Ctrl-e` to edit in `vim` just typed command:

Example what you can put into your `.bashrc`:

```bash
export EDITOR=nvim
# Enable Ctrl-x-e to edit the command line
autoload -U edit-command-line
```

## 2. Rename a few files at a time using VIM

Download `vimv` script:

```bash
curl https://raw.githubusercontent.com/thameera/vimv/master/vimv > /usr/local/bin/vimv && \ 
  chmod +755 /usr/local/bin/vimv
```

Type in terminal `vinv` and pattern to rename files:

`vimv *.txt`

it will open vim like a window where you can rename files and apply.

P.S. you need the `$EDITOR` env variable to be set.

## 3. Jump to interesting elements in your default editor

```bash
git jump diff
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
