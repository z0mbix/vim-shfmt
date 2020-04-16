function! shfmt#shfmt(current_args, line1, line2) abort
	let l:extra_args = g:shfmt_extra_args
	let l:filename = @%
	let l:shfmt_cmd = g:shfmt_cmd
	let l:shfmt_opts = ' ' . a:current_args . ' ' . l:extra_args
	if !empty(a:current_args)
		let l:shfmt_opts = a:current_args
	endif
	let l:cursor_position = getcurpos()
	silent execute  a:line1 . ',' . a:line2 . '!' . l:shfmt_cmd . ' ' . l:shfmt_opts
	if v:shell_error
		echoerr 'Shfmt returned an error (often due to wrong syntax). Undoing changes.'
		" undo the buffer overwrite because shfmt returns no data on error, so
		" we've erased the user's work!
		undo
	endif
	" Reset the cursor position if we moved 
	if l:cursor_position != getcurpos()
		call setpos('.', l:cursor_position)
	endif
endfunction
