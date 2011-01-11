" autocmd FileType php set omnifunc=phpcomplete#CompletePHP
" set cot+=menuone

set t_Co=256
colorscheme zenburn

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

" mysql tab
command Mysql :ConqueTermTab mysql -u root -p

