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

iabbrev qone $id = $this->db->getOne("SELECT {$this->keyName} FROM {$this->tableName} WHERE 1=1", array());<CR>if( PEAR::isError($id) )<CR><Tab>die( $id->getMessage() );
iabbrev qcol $ids = $this->db->getCol("SELECT {$this->keyName} FROM {$this->tableName} WHERE 1=1", 0, array());<CR>if( PEAR::isError($ids) )<CR><Tab>die( $ids->getMessage() );
iabbrev qall $res = $this->db->getAll("SELECT {$this->keyName} FROM {$this->tableName} WHERE 1=1", array(), DB_FETCHMODE_ASSOC);<CR>if( PEAR::isError($res) )<CR><Tab>die( $res->getMessage() );

" select all
nnoremap <C-A> ggVG<CR>

" tidy shortcuts
vnoremap <C-T> :!tidy -q -i -b -w 0 --show-errors 0 --show-body-only 1<CR>
vnoremap <C-R> :!csstidy - --silent=true --preserve_css=true --sort_properties=true<CR>

" node shortcuts
command NodeLog :TabTail /var/log/node.log
command NodeStart :!sudo /sbin/start node
command NodeRestart :!sudo /sbin/restart node

" apache error log tails
command Prod :TabTail /var/log/apache2/www.error_log
command Dev :TabTail /var/log/apache2/dev.error_log
command Webdev :TabTail /var/log/apache2/webdev.error_log
command Secure :TabTail /var/log/apache2/secure_error_log
command Error :TabTail /var/log/apache2/error.log

" mysql tab
command Mysql :ConqueTermTab mysql -u root -p

" highlight bad whitespace
"highlight ExtraWhitespace ctermbg=darkgray guibg=darkgray
"match ExtraWhitespace /\s\+$\| \+\ze\t/
"set list listchars=tab:\uBB\uB7,nbsp:~,trail:\uB7
set list listchars=tab:\ \ ,trail:$

" turn on autoindent, incremental search, and search highlighting
set autoindent
set incsearch
set hlsearch

"highlight ColorColumn ctermbg=magenta
"call matchadd('ColorColumn', '\%81v', 100)

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

inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
""inoremap { {<CR>}<Esc>O
autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
""inoremap } <c-r>=CloseBracket()<CR>
inoremap } <c-r>=ClosePair('}')<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

function ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endf

function CloseBracket()
	if match(getline(line('.') + 1), '\s*}') < 0
		return "\<CR>}"
	else
		return "\<Esc>j0f}a"
	endif
endf

function QuoteDelim(char)
	let line = getline('.')
	let col = col('.')
	if line[col - 2] == "\\"
		"Inserting a quoted quotation mark into the string
		return a:char
	elseif line[col - 1] == a:char
		"Escaping out of the string
		return "\<Right>"
	else
		"Starting a string
		return a:char.a:char."\<Esc>i"
	endif
endf
