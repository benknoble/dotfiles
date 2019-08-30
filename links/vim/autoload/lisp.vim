function! lisp#load() abort
  let l:file = expand('%')
  let l:terms = term_list()
  if empty(term_list())
    call terminal#run('++close')
    let l:terms = term_list()
  endif
  let l:term = l:terms[0]
  call term_sendkeys(l:term, printf("(load #P\"%s\")\n", l:file))
  let l:win = bufwinnr(l:term)
  exec l:win 'wincmd w'
endfunction
