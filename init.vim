" by xon-dev
" Mostly use rafi/vim-config
"
" ---------------------------

" Vim Plug {{{

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

" }}}
" Directories {{{

" Data path
let $DATA_PATH =
	\ expand(($XDG_CACHE_HOME ? $XDG_CACHE_HOME : '~/.cache') . '/nvim')

" Vim path
let $VIM_PATH =
	\ expand(($XDG_CONFIG_HOME ? $XDG_CONFIG_HOME : '~/.config') . '/nvim')

" }}}
" On start {{{

if has('vim_starting')

" }}}

	" leader keys
	let g:mapleader="\<Space>"
	let g:maplocalleader=';'

	" Remove mappings on leader keys
	nnoremap <Space>  <Nop>
	xnoremap <Space>  <Nop>
	nnoremap ,        <Nop>
	xnoremap ,        <Nop>
	nnoremap ;        <Nop>
	xnoremap ;        <Nop>

	" System clipboard
	if has('clipboard')
		set clipboard& clipboard+=unnamedplus
	endif

	" Colors
	if has('termguicolors')
		set termguicolors
	endif

	" Use UTF-8
	set encoding=utf-8
	scriptencoding utf-8

	" Check directories
	for s:path in [ $DATA_PATH, $DATA_PATH . '/undo', $DATA_PATH . '/backup',
				\ $DATA_PATH . '/session', $DATA_PATH . '/spell' ]
		if ! isdirectory(s:path)
			call mkdir(s:path, 'p')
		endif
	endfor

	if &runtimepath !~# $VIM_PATH
		set runtimepath^=$VIM_PATH
	endif

endif

" }}}
" Functions {{{

" Source files
function! s:source_file(path, ...)

	" Source user configuration files with set/global sensitivity
	let use_global = get(a:000, 0, ! has('vim_starting'))
	let abspath = resolve($VIM_PATH . '/' . a:path)
	if ! use_global
		execute 'source' fnameescape(abspath)
		return
	endif

	let tempfile = tempname()
	let content = map(readfile(abspath),
		\ "substitute(v:val, '^\\W*\\zsset\\ze\\W', 'setglobal', '')")
	try
		call writefile(content, tempfile)
		execute printf('source %s', fnameescape(tempfile))
	finally
		if filereadable(tempfile)
			call delete(tempfile)
		endif
	endtry
endfunction

" }}}
" Plugins {{{

call plug#begin(system('echo -n "${XDG_CACHE_HOME:-$HOME/.cache}/nvim/plugged"'))
call s:source_file('/plugins.vim')
call plug#end()


" }}}
" Default plugins off {{{

let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1

let g:loaded_matchit = 1
let g:loaded_matchparen = 1
let g:loaded_2html_plugin = 1
let g:loaded_logiPat = 1
let g:loaded_rrhelper = 1

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

" }}}
" Sourced files {{{

source $VIM_PATH/plugins/all.vim
source $VIM_PATH/general.vim
source $VIM_PATH/bindings.vim
source $VIM_PATH/theme.vim

" }}}
" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :