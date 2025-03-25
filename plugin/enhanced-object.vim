" Author: Troy Daniel
" Date: 2020-03-26
" Know bugs:
" 1. the pair '' and "" ignores comment char, e.g.
" for the stirng "string \" with comment char" will gives 
" string \ 
" instead of 
"     string \"with comment char
onoremap <silent>a( :<C-u>cal <Sid>EnhanceTextObject(0, '[(（]', '[)）]')<CR>
onoremap <silent>i( :<C-u>cal <Sid>EnhanceTextObject(1, '[(（]', '[)）]')<CR>
vnoremap <silent>a( :<C-u>cal <Sid>EnhanceTextObject(0, '[(（]', '[)）]')<CR><Esc>gv
vnoremap <silent>i( :<C-u>cal <Sid>EnhanceTextObject(1, '[(（]', '[)）]')<CR><Esc>gv

onoremap <silent>a) :<C-u>cal <Sid>EnhanceTextObject(0, '[(（]', '[)）]')<CR>
onoremap <silent>i) :<C-u>cal <Sid>EnhanceTextObject(1, '[(（]', '[)）]')<CR>
vnoremap <silent>a) :<C-u>cal <Sid>EnhanceTextObject(0, '[(（]', '[)）]')<CR><Esc>gv
vnoremap <silent>i) :<C-u>cal <Sid>EnhanceTextObject(1, '[(（]', '[)）]')<CR><Esc>gv

onoremap <silent>a[ :<C-u>cal <Sid>EnhanceTextObject(0, '[[【「〔『〖]', '[]】」〕』〗]')<CR>
onoremap <silent>i[ :<C-u>cal <Sid>EnhanceTextObject(1, '[[【「〔『〖]', '[]】」〕』〗]')<CR>
vnoremap <silent>a[ :<C-u>cal <Sid>EnhanceTextObject(0, '[[【「〔『〖]', '[]】」〕』〗]')<CR><Esc>gv
vnoremap <silent>i[ :<C-u>cal <Sid>EnhanceTextObject(1, '[[【「〔『〖]', '[]】」〕』〗]')<CR><Esc>gv


onoremap <silent>a] :<C-u>cal <Sid>EnhanceTextObject(0, '[[【「〔『〖]', '[]】」〕』〗]')<CR>
onoremap <silent>i] :<C-u>cal <Sid>EnhanceTextObject(1, '[[【「〔『〖]', '[]】」〕』〗]')<CR>
vnoremap <silent>a] :<C-u>cal <Sid>EnhanceTextObject(0, '[[【「〔『〖]', '[]】」〕』〗]')<CR><Esc>gv
vnoremap <silent>i] :<C-u>cal <Sid>EnhanceTextObject(1, '[[【「〔『〖]', '[]】」〕』〗]')<CR><Esc>gv

onoremap <silent>a" :<C-u>cal <Sid>EnhanceTextObject(0, '["“]', '["”]')<CR>
onoremap <silent>i" :<C-u>cal <Sid>EnhanceTextObject(1, '["“]', '["”]')<CR>
vnoremap <silent>a" :<C-u>cal <Sid>EnhanceTextObject(0, '["“]', '["”]')<CR><Esc>gv
vnoremap <silent>i" :<C-u>cal <Sid>EnhanceTextObject(1, '["“]', '["”]')<CR><Esc>gv

onoremap <silent>a' :<C-u>cal <Sid>EnhanceTextObject(0, "['‘`]", "['’`]")<CR>
onoremap <silent>i' :<C-u>cal <Sid>EnhanceTextObject(1, "['‘`]", "['’`]")<CR>
vnoremap <silent>a' :<C-u>cal <Sid>EnhanceTextObject(0, "['‘`]", "['’`]")<CR><Esc>gv
vnoremap <silent>i' :<C-u>cal <Sid>EnhanceTextObject(1, "['‘`]", "['’`]")<CR><Esc>gv

function! <Sid>GetCharUnderCursor()
	return nr2char(strgetchar(getline('.')[col('.') - 1:], 0))
endfunction

function! <Sid>EnhanceTextObject(inner, pat_left, pat_right)

	" Record the current state of the visual region.
	let vismode = "v"

	
	" get char under cursor
	" let ch=nr2char(strgetchar(getline('.')[col('.') - 1:], 0))
	let ch=<sid>GetCharUnderCursor()
	
	let start = searchpairpos(a:pat_left, "", a:pat_right, 'bnW'.(ch =~ a:pat_left ? 'c': ''))
	let end   = searchpairpos(a:pat_left, "", a:pat_right, 'nW'.(ch =~ a:pat_right ? 'c': ''))

	" if the pair is different, previous statements work perfectly, however,
	" it'll fail when the pair is the same
	let startchar = nr2char(strgetchar(getline(start[0])[start[1]-1:], 0))
	let endchar = nr2char(strgetchar(getline(end[0])[end[1]-1:], 0))
	if(startchar =~ "['\"`]" || endchar =~ "['\"`]" )
		let start = searchpos(a:pat_left, 'bncW')
		let end   = searchpos(a:pat_right, 'nW')
	endif
	
	call cursor(start)
	if(a:inner)
		exe "normal! l"
	endif
	exe "normal! " . vismode
	" normal vismode
	call cursor(end)
	if(!a:inner)
		exe "normal! l"
	endif
endfunction
