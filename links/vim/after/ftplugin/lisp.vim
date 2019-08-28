" Vim filetype plugin
" Language:              lisp
" Maintainer:            Ben Knoble <ben.knoble@gmail.com>

let b:interpreter = 'clisp'

nnoremap <Localleader>l :call lisp#load()<CR>

let b:undo_ftplugin = ftplugin#undo({
      \ 'opts': [
      \ ],
      \ 'vars': [
      \   'b:interpreter',
      \ ],
      \ 'commands': [
      \ ],
      \ 'maps': [
      \   [ 'n', '<Localleader>l' ],
      \ ],
      \ 'funcs': [
      \ ],
      \ })
