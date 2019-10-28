function! json#format() abort
  let l:cursor = getcurpos()
  let l:start = v:lnum
  let l:end = l:start + v:count - 1
  silent execute printf('%d,%d!python -m json.tool', l:start, l:end)
  if v:shell_error
    undo
  endif
  call setpos('.', l:cursor)
endfunction