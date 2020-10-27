" Resize {{{

nnoremap <silent><Up>    :resize +1<CR>
nnoremap <silent><Down>  :resize -1<CR>
nnoremap <silent><Right> :vertical resize +1<CR>
nnoremap <silent><Left>  :vertical resize -1<CR>

" }}}
" Folds {{{


nnoremap <CR> za
nnoremap <A-CR> zMzvzt

" }}}
" Navigation {{{

" Move throught locations
nnoremap ]l :lnext<CR>
nnoremap [l :lprev<CR>

" Move throught errors
nnoremap ]e :cnext<CR>
nnoremap [e :cprev<CR>

if has_key ( plugs, 'vim-better-whitespace')
	" Move throught unneded whitespaces
	nnoremap ]w :NextTrailingWhitespace<CR>
	nnoremap [w :PrevTrailingWhitespace<CR>

endif


" }}}
" Annoying commands {{{

nnoremap q :wq<CR>
nnoremap <C-S> :w<CR>
xnoremap q :wq<CR>
xnoremap <C-S> :w<CR>

" }}}
" Code edit {{{

nnoremap <silent> <Leader>cw :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

" }}}
" Abbreviations {{{

cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev Wqa wqa
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa qa

" }}}

" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
