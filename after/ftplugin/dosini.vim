" written by the-whisper-of-the-wind

" ini文件（折叠）
" 如果当前行的第一个字符不是 [，则认为这一行是可折叠的。
setl foldexpr=getline(v:lnum)[0]!=\"\[\"
" expr 表示使用自定义的折叠表达式（即前面设置的 foldexpr）来决定如何折叠代码
setl fdm=expr
" 表示初始时所有折叠都是关闭的
setl fdl=0

" 自定义折叠文本显示函数
function! MyFoldText()
	let line = getline(v:foldstart)
	let line2 = getline(v:foldstart + 1)
	let sub = substitute(line . "|" . line2, '/\*\|\*/\|{{{\d\=', '', 'g')
	let ind = indent(v:foldstart)
	let lines = v:foldend-v:foldstart + 1
	let i = 0
	let spaces = ''
	while i < (ind - ind/4)
		let spaces .= ' '
		let i = i+1
	endwhile
	return spaces . sub . ' --------(' . lines . ' lines)'
endfunction
set foldtext=foldtext()
