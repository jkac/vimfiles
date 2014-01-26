" autocmd FileType php set omnifunc=phpcomplete#CompletePHP
" set cot+=menuone

set t_Co=256
colorscheme zenburn

" tone down the listchars colors and make the highlighting more visible
hi NonText         ctermfg=61
hi SpecialKey      ctermfg=61
hi Search          ctermfg=230   ctermbg=0
hi IncSearch       ctermfg=1     ctermbg=0

inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR>

" node shortcuts
command NodeLog :TabTail /var/log/node.log
command NodeStart :!sudo /sbin/start node
command NodeRestart :!sudo /sbin/restart node

" apache error log tails
command Prod :TabTail /var/log/apache2/www.error_log
command Dev :TabTail /var/log/apache2/dev.error_log
command Webdev :TabTail /var/log/apache2/webdev.error_log
command Error :TabTail /var/log/apache2/error.log
command Media :TabTail /var/log/apache2/media.error.log

" mysql tab
command Mysql :ConqueTermTab mysql -u root -p

" highlight bad whitespace
"highlight ExtraWhitespace ctermbg=darkgray guibg=darkgray
"match ExtraWhitespace /\s\+$\| \+\ze\t/
set list listchars=tab\ \ ,trail:$

" turn on autoindent, incremental search, and search highlighting
set autoindent
set incsearch
set hlsearch

highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" shift+direction moves a block - needs the dragvisuals plugin
vmap  <expr>  <S-LEFT>   DVB_Drag('left')
vmap  <expr>  <S-RIGHT>  DVB_Drag('right')
vmap  <expr>  <S-DOWN>   DVB_Drag('down')
vmap  <expr>  <S-UP>     DVB_Drag('up')

" This rewires n and N to do the highlighing
nnoremap <silent> n   n:call HLNext(0.4)<cr>
nnoremap <silent> N   N:call HLNext(0.4)<cr>

" this is the highlighting method
function! HLNext (blinktime)
  highlight WhiteOnRed ctermfg=white ctermbg=red
  let [bufnum, lnum, col, off] = getpos('.')
  let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
  let target_pat = '\c\%#'.@/
  let ring = matchadd('WhiteOnRed', target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
  call matchdelete(ring)
  redraw
endfunction
