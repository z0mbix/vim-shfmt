" The "Vim shfmt" plugin runs shfmt and displays the results in Vim.
"
" Author:	 David Wooldridge
" URL:		 https://github.com/z0mbix/vim-shfmt
" Version:	 0.2
" Copyright: Copyright (c) 2017 David Wooldridge
" License:	 MIT
" ----------------------------------------------------------------------------

if exists('g:loaded_vimshfmt') || &cp || !executable('shfmt')
	finish
endif
let g:loaded_vimshfmt = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:shfmt_fmt_on_save')
	let g:shfmt_fmt_on_save = 0
endif

if !exists('g:shfmt_cmd')
	let g:shfmt_cmd = 'shfmt'
endif

" Options
if !exists('g:shfmt_extra_args')
	let g:shfmt_extra_args = ''
endif

let s:shfmt_switches = ['-p', '-i', '-bn', '-ci', '-ln', '-s']

function! s:ShfmtSwitches(...)
	return join(s:shfmt_switches, "\n")
endfunction

command! -range=% -complete=custom,s:ShfmtSwitches -nargs=? Shfmt :call shfmt#shfmt(<q-args>, <line1>, <line2>)

augroup shfmt
	autocmd!
	if get(g:, 'shfmt_fmt_on_save', 1)
		" Use BufWritePre to filter the file before it's written since we're
		" processing current buffer instead of the saved file. 
		autocmd BufWritePre *.sh Shfmt
		autocmd FileType sh autocmd BufWritePre <buffer> Shfmt
	endif
augroup END

let &cpo = s:save_cpo
