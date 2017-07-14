" The "Vim shfmt" plugin runs shfmt and displays the results in Vim.
"
" Author:	 David Wooldridge
" URL:		 https://github.com/z0mbix/vim-shfmt
" Version:	 0.1
" Copyright: Copyright (c) 2017 David Wooldridge
" License:	 MIT
" ----------------------------------------------------------------------------

if exists('g:loaded_vimshfmt') || &cp
	finish
endif
let g:loaded_vimshfmt = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:vimshfmt_shfmt_cmd')
	let g:vimshfmt_shfmt_cmd = 'shfmt -w '
endif

" Options
if !exists('g:vimshfmt_extra_args')
	let g:vimshfmt_extra_args = ''
endif

let s:shfmt_switches = ['-p', '-i']

function! s:ShfmtSwitches(...)
	return join(s:shfmt_switches, "\n")
endfunction

function! s:Shfmt(current_args)
	let l:extra_args = g:vimshfmt_extra_args
	let l:filename	 = @%
	let l:shfmt_cmd  = g:vimshfmt_shfmt_cmd
	let l:shfmt_opts = ' '.a:current_args.' '.l:extra_args

	let l:shfmt_output  = system(l:shfmt_cmd.l:shfmt_opts.' '.l:filename)
	edit!
endfunction

command! -complete=custom,s:ShfmtSwitches -nargs=? Shfmt :call <SID>Shfmt(<q-args>)

let &cpo = s:save_cpo
