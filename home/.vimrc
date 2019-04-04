imap fd <Esc>
set relativenumber
set expandtab
set shiftwidth=2
set softtabstop=2
set smartindent

set incsearch
set hlsearch
" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

syntax enable
set background=dark
colorscheme solarized


" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction

" Moving back and forth between lines of same or lower indentation.
nnoremap <silent> [a :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> ]a :call NextIndent(0, 1, 0, 1)<CR>
nnoremap <silent> [A :call NextIndent(0, 0, 1, 1)<CR>
nnoremap <silent> ]A :call NextIndent(0, 1, 1, 1)<CR>
vnoremap <silent> [a <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> ]a <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
vnoremap <silent> [A <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
vnoremap <silent> ]A <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
onoremap <silent> [a :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> ]a :call NextIndent(0, 1, 0, 1)<CR>
onoremap <silent> [A :call NextIndent(1, 0, 1, 1)<CR>
onoremap <silent> ]A :call NextIndent(1, 1, 1, 1)<CR>
