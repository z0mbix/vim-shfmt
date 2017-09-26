" The "Vim shfmt" plugin runs shfmt and displays the results in Vim.
"
" Author:	 David Wooldridge
" URL:		 https://github.com/z0mbix/vim-shfmt
" Version:	 0.2
" Copyright: Copyright (c) 2017 David Wooldridge
" License:	 MIT
" ----------------------------------------------------------------------------

if exists("g:loaded_vimshfmt") || &cp || !executable('shfmt')
	finish
endif
let g:loaded_vimshfmt = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists("g:shfmt_fmt_on_save")
	let g:shfmt_fmt_on_save = 0
endif

if !exists('g:shfmt_cmd')
	let g:shfmt_cmd = 'shfmt -w'
endif

" Options
if !exists('g:shfmt_extra_args')
	let g:shfmt_extra_args = ''
endif

let s:shfmt_switches = ['-p', '-i', '-bn', '-ci', '-ln', '-s']

function! s:ShfmtSwitches(...)
	return join(s:shfmt_switches, "\n")
endfunction

function! s:Shfmt(current_args)
	let l:extra_args = g:shfmt_extra_args
	let l:filename = @%
	let l:shfmt_cmd = g:shfmt_cmd
	let l:shfmt_opts = ' ' . a:current_args . ' ' . l:extra_args
	if a:current_args != ''
		let l:shfmt_opts = a:current_args
	endif
	let l:shfmt_output = system(l:shfmt_cmd . ' ' . l:shfmt_opts . ' ' . l:filename)
	edit!
endfunction

augroup shfmt
	autocmd!
	if get(g:, "shfmt_fmt_on_save", 1)
		autocmd BufWritePre *.sh Shfmt
		autocmd FileType sh autocmd BufWritePre <buffer> Shfmt
	endif
augroup END

command! -complete=custom,s:ShfmtSwitches -nargs=? Shfmt :call <SID>Shfmt(<q-args>)

let &cpo = s:save_cpo
