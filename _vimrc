""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 先决设置 {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 实现Windows 风格功能(可以根据mswin.vim的内容设置)
" set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
behave mswin

" 设置路径(可以把vimrc放在指定文件夹）
" _VIMRC文件所在的目录
" Gvim on windows 是用配置文件 _vimrc 代替了 .vimrc，用 vimfiles目录 代替 .vim目录 
let $VIM = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let $VIM_PARENT = fnamemodify($VIM, ':h')

" 将空格键设置为 <leader> 键,\会把<space>转义   let 用于操作变量（Variables）/set 用于操作选项（Options）
let mapleader = "\<space>"
" 设置 <leader> 键的延迟时间为 1000 毫秒
set timeoutlen=1000  

" 用于配置会话保存选项(缓冲区、标签页布局——窗口和缓冲区）
set sessionoptions=buffers,tabpages

" 语法高亮(hi高亮要放在其后面)
syntax on     

" 判断是终端还是gvim
if has("gui_running")
	let g:isGUI = 1
else
	let g:isGUI = 0
endif

" gvim
if (g:isGUI)

" vim内置的配色方案(desert,elflord,evening,industry,peachpuff,ron,shine,sorbet等)
  colo evening
" vim的第三方配置方案（插件）
 "colo solarized
 "colo onedark
" 高亮显示当前光标所在的行
	set cursorline
" 高亮显示当前光标所在的列
" set cursorcolumn
" 自定义当前行背景颜色,默认#666666(对高亮的定义要放在语法高亮的后面)
hi cursorline guibg=#525252

" gvim标题栏透明
" 绑定 F10 键来切换标题栏的透明状态
nnoremap <silent> <F10> :call ToggleTransparency()<CR>
" 定义一个变量来跟踪标题栏的透明状态
let g:caption_transparent = 0
" 定义切换标题栏透明状态的函数(g:作为作用域前缀用于定义全局作用域的变量)
function! ToggleTransparency()
    if g:caption_transparent
        " 不透明（Alpha 值为 255）
        call libcallnr("vimtweak64.dll", "SetAlpha", 255)
        let g:caption_transparent = 0
    else
        " 透明（Alpha 值为 200）
        call libcallnr("vimtweak64.dll", "SetAlpha", 200)
        let g:caption_transparent = 1
    endif
endfunction

" 启动gvim后自动去标题栏
au vimenter * call libcallnr("vimtweak64.dll","EnableCaption",0)
" 去标题栏快捷键
" 绑定 F11 键来切换标题栏的显示和隐藏
nnoremap <F11> :call ToggleCaption()
imap <F11> <c-o>:call ToggleCaption()
" 定义一个变量来手动跟踪标题栏的状态
let g:caption_enabled = 0
" 定义切换标题栏的函数
function! ToggleCaption()
    if g:caption_enabled
        call libcallnr("vimtweak64.dll", "EnableCaption", 0)
        let g:caption_enabled = 0
    else
        call libcallnr("vimtweak64.dll", "EnableCaption", 1)
        let g:caption_enabled = 1
    endif
endfunction
endif
 
" 终端
if (!g:isGUI)

" vim内置的配色方案
  colo evening "夜晚风格
" vim的第三方配置方案（插件）
 "colo solarized

" 高亮显示当前光标所在的行
	set cursorline
" 高亮显示当前光标所在的列
  "set cursorcolumn
"自定义当前行背景颜色
  " hi cursorline guibg=#333333
  " hi CursorColumn guibg=#333333

endif

" 设置普通模式下光标的颜色为浅蓝色（guibg——GUI;117——终端,浅蓝色编号 117）
hi Cursor guifg=NONE guibg=#ADD8E6 ctermfg=NONE ctermbg=117
" 设置插入模式下光标的颜色为橙色（橙色相近编号 208）
augroup InsertModeCursor
    autocmd!
    autocmd InsertEnter * hi Cursor guifg=NONE guibg=#FFA500 ctermfg=NONE ctermbg=208
    autocmd InsertLeave * hi Cursor guifg=NONE guibg=#ADD8E6 ctermfg=NONE ctermbg=117
augroup END
" 设置命令模式下光标的颜色为红色（红色编号 1）
augroup CmdlineModeCursor
    autocmd!
    autocmd CmdlineEnter * hi Cursor guifg=NONE guibg=Red ctermfg=NONE ctermbg=1
    autocmd CmdlineLeave * hi Cursor guifg=NONE guibg=#ADD8E6 ctermfg=NONE ctermbg=117
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 不同OS {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 判断操作系统
if (has("win32") || has("win64"))
	let g:isWin = 1
	let g:slash = '\'

" TC路径设置
	let g:COMMANDER_PATH = fnamemodify($VIM, ':h:h:h')
  let g:COMMANDER_EXE = g:COMMANDER_PATH . g:slash . 'TOTALCMD.EXE'
	" let g:COMMANDER_PATH = "d:/SoftDir/totalcmd_TheWhisperOfTheWind"
	" let g:COMMANDER_EXE = "d:/SoftDir/totalcmd_TheWhisperOfTheWind/TOTALCMD.EXE"

" 将终端编码设置为与当前编码相同,通常win下的encoding为cp936
	let &termencoding=&encoding

"set dir=.,c:\\temp    set dir=c:\\temp
" 在新标签页中打开 $VIMRUNTIME/_vimrc 文件
	map <silent> <leader>ee :tabe $VIMRUNTIME\_vimrc<cr>
" 重新加载 $VIMRUNTIME/_vimrc 配置文件
	map <silent> <leader>er :source $VIMRUNTIME\_vimrc<cr>
" 重新加载配置文件
	autocmd! bufwritepost .vimrc source $VIMRUNTIME\_vimrc

" 设置英文等宽nerd字体
  set guifont=JetBrainsMonoNL_NFM:cANSI:qDRAFT:h10
" 设置中文等宽nerd字体
  set guifontwide=LXGWWenKaiMono_Nerd_Font:cGB2312:qDRAFT:h10
" 在 GUI 中快速改变字体大小(设置字体把字号放在最后)
command! Bigger  :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)+1', '')
command! Biggerwide  :let &guifontwide = substitute(&guifontwide, '\d\+$', '\=submatch(0)+1', '')
command! Smaller :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)-1', '')
command! Smallerwide :let &guifontwide = substitute(&guifontwide, '\d\+$', '\=submatch(0)-1', '')
" 管道符 | 是用于分隔多个普通命令,对于自定义命令不会自动识别 | 作为分隔符
" 使用函数封装
function! IncreaseBothFontSizes()
    execute "Bigger"
    execute "Biggerwide"
endfunction

function! DecreaseBothFontSizes()
    execute "Smaller"
    execute "Smallerwide"
endfunction

command! BiggerAll call IncreaseBothFontSizes()
command! SmallerAll call DecreaseBothFontSizes()


"关闭vim时候自动保存打开文件的信息
	au VimLeave * mksession! $VIMRUNTIME\Session.vim
	au VimLeave * wviminfo! $VIMRUNTIME\_viminfo

" " 在启动vim时,如果没有指定文件且 $VIMRUNTIME/Session.vim 文件存在，则恢复上次的会话和信息。
  " autocmd! VimEnter * nested if argc() == 0 && filereadable($VIMRUNTIME . "/Session.vim") |
    " \ silent! execute "source " . $VIMRUNTIME . "/Session.vim"|
    " \ silent! execute "rviminfo " . $VIMRUNTIME . "/_viminfo"

" 打开浏览器
"map <leader>gf :update<CR>:silent !start c:\progra~1\intern~1\iexplore.exe file://%:p
" 使用 nircmd 工具打开文件或链接
	noremap <silent> <leader>gp :!start nircmd shexec open "%:p"<CR><CR><CR>
	noremap <leader>gi :!start nircmd shexec open "<cWORD>"<CR><CR>
	noremap <silent> <leader><cr> :!start nircmd shexec open "<cWORD>"<CR><CR>
	vnoremap <leader>gi "ry:!start nircmd shexec open "<C-R>r"<CR><CR>
" 启动 Total Commander 并定位到当前文件所在目录
	noremap <silent> <leader>gz :!start <C-R>=eval("g:COMMANDER_EXE")<CR> /A /T /O /S /L="%:p"<CR><CR>
" 打开 Windos 资源管理器并选中当前文件
	noremap <silent> <leader>ge :!start explorer /n,/e,/select,"%:p"<CR>
" 在当前文件所在目录打开命令提示符
	command! SHELL silent cd %:p:h|silent exe "!start cmd"|silent cd -

" 用来测试
"au GUIEnter * silent exe "!start nircmd infobox 12345"

" else
" " 当前系统不是 Windows
	" let g:isWin = 0
" " 用于表示非 Windows 系统的路径分隔符
	" let g:slash = '/'

" " 在新标签页中打开 $HOME/.vimrc 文件
	" map <silent> <leader>ee :tabe $HOME/.vimrc<cr>
" " 重新加载 ~/.vimrc 配置文件
	" map <silent> <leader>er :source ~/.vimrc<cr>
	" command! -nargs=? RW :w !sudo tee %
	" autocmd! bufwritepost .vimrc source ~/.vimrc

	" "set guifont=YaHeiConsolas\ 12
	" "set guifontwide=YaHeiConsolas\ 12
	" set guifont=DejaVu\ Sans\ Mono\ 12
	" set guifontwide=WenQuanYi\ Zenhei\ 12

" " 在退出 Vim 时，如果 $HOME/.vim 目录不存在则创建该目录，并保存当前会话信息到 $HOME/.vim/Session.vim 文件
	" autocmd VimLeave * nested if (!isdirectory($HOME . "/.vim")) |
		" \ call mkdir($HOME . "/.vim") |
		" \ endif |
		" \ execute "mksession! " . $HOME . "/.vim/Session.vim"
" " 在启动 Vim 时，如果没有指定文件且 $HOME/.vim/Session.vim 文件存在，则恢复上次的会话
	" autocmd VimEnter * nested if argc() == 0 && filereadable($HOME . "/.vim/Session.vim") |
		" \ execute "source " . $HOME . "/.vim/Session.vim"

" " 使用 Firefox 浏览器打开当前光标下的链接
	" map <leader>gi :!firefox <cWORD><CR><CR>
" " 在当前文件所在目录打开 GNOME 终端
	" command! SHELL silent cd %:p:h|silent exe '!setsid gnome-terminal'|silent cd -
" " 打开 Nautilus 文件管理器并定位到当前文件所在目录
	" command! Nautilus silent !nautilus %:p:h
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 插件 {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设置Vundle插件管理( 在插件固定后可以把脚本放在不同文件夹下，不借助插件管理器 ) {{{2

" 去除VI一致性(必须);使用vim自己的键盘模式,而不是兼容vi的模式
set nocompatible      

" 关闭 Vim 的文件类型检测功能
filetype off                 

" 将 Vundle.vim 插件所在的目录添加到 Vim 的运行时路径（Runtime Path)
" rtp 代表运行时路径，这是 Vim 搜索插件、脚本、帮助文件等资源的目录列表。Vim 启动时会按照 rtp 里指定的目录顺序来查找所需资源。
" + 符号的作用是把后面指定的目录添加到现有的 rtp 列表里，而不会覆盖原有的目录
set rtp+=$VIM\Plugins\Vundle.vim

" 指定插件安装
call vundle#begin('$VIM\Plugins')

" 插件管理器
Plugin 'VundleVim/Vundle.vim'                
" 配色方案
" Plugin 'flazz/vim-colorschemes'
Plugin 'ghifarit53/tokyonight-vim'
Plugin 'joshdick/onedark.vim'
" 语法高亮
Plugin 'sheerun/vim-polyglot'
" 文件目录树
Plugin 'preservim/nerdtree'                       

" 目录查看器
Plugin 'justinmk/vim-dirvish'

" 美化底部插件
Plugin 'vim-airline/vim-airline'                 
" 主题插件
Plugin 'vim-airline/vim-airline-themes'    

" 彩虹括号插件
Plugin 'luochen1990/rainbow'

" 代码缩进线
Plugin 'Yggdroot/indentLine'

" 移动插件
Plugin 'easymotion/vim-easymotion'

" surround插件(添加环绕、修改环绕和删除环绕)
Plugin 'tpope/vim-surround'

" 基础控件UI
Plugin 'skywind3000/vim-quickui'

" 模糊查找
Plugin 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

" 注释插件
Plugin 'preservim/nerdcommenter'

" Markdown预览(要安装node.js和yarn,建议可以安装在插件目录下(为了保持尽可能开箱即用），并添加对应的环境变量）
Plugin 'iamcco/markdown-preview.nvim'

" 即时创建表
Plugin 'dhruvasagar/vim-table-mode'

" 对齐插件
Plugin 'junegunn/vim-easy-align'

" Markdown图像粘贴
Plugin 'img-paste-devs/img-paste.vim'

" Markdown目录生成插件
Plugin 'mzlogin/vim-markdown-toc'

" 用于文本过滤和对齐
Plugin 'godlygeek/tabular'
" Markdown Vim 模式
Plugin 'preservim/vim-markdown'

" Mark插件
Plugin 'kshenoy/vim-signature'
" 查看寄存器
Plugin 'junegunn/vim-peekaboo'

" git插件
Plugin 'tpope/vim-fugitive'

" coc.nvim 插件
Plugin 'neoclide/coc.nvim', {'branch': 'release'}

" 在弹出窗口中显示键绑定
Plugin 'liuchengxu/vim-which-key'

" vim笔记用到的插件
Plugin 'vimwiki/vimwiki'

" 日历插件
Plugin 'itchyny/calendar.vim'

" 在不同窗口/标签上显示 A/B/C 等编号，然后字母直接跳转
Plugin 't9md/vim-choosewin'

" 调整 vim 窗口
Plugin 'simeji/winresizer'

" 多游标插件
Plugin 'mg979/vim-visual-multi', {'branch': 'master'}

" grep插件(暂时不用，等熟练了其他功能来看）
Plugin 'mhinz/vim-grepper'

" ctags
Plugin 'vim-scripts/taglist.vim'

" 图标插件
call vundle#end()   " 结束
Plugin 'ryanoasis/vim-devicons'
" Vundle命令
" 安装插件————:PluginInstall
" 更新插件————:PluginUpdate
" 卸载插件————:PluginClean(删除Plugin行)
" 列出已安装插件————:PluginList

" 插件配置 {{{2
" nerdtree(书签、直观显示目录结构) {{{3
" 设置显示书签
let NERDTreeShowBookmarks=1

" 设置显示文件
let NERDTreeShowFiles=1

" 设置显示隐藏文件
let NERDTreeShowHidden=1

" " 设置显示行号
" let NERDTreeShowLineNumbers=1

" 改变文件夹的箭头图标
let NERDTreeDirArrowCollapsible="󰡄"
let NERDTreeDirArrowExpandable=""

" " 将选中的项移动到窗口的中央位置
let NERDTreeAutoCenter=1

" 定义 <leader>n 快捷键来打开或关闭 NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>

" 书签保存的文件
let NERDTreeBookmarksFile=$VIM.'/NerdBookmarks.txt'

"在tree窗口中才能执行
" 创建标签
nmap <C-f7> <esc>:Bookmark 
" 删除标签
nmap <C-F8> <esc> :ClearBookmarks 

" 当 NERDTree 窗口打开时，映射 Shift+字母 到对应盘符
autocmd FileType nerdtree nmap <buffer> <S-D> :call CustomNERDTreeFind('D:\\')<CR>
autocmd FileType nerdtree nmap <buffer> <S-C> :call CustomNERDTreeFind('C:\\')<CR>
autocmd FileType nerdtree nmap <buffer> <S-Z> :call CustomNERDTreeFind('Z:\\')<CR>

function! CustomNERDTreeFind(path)
    " 关闭当前的 NERDTree 窗口
    execute 'NERDTreeClose'
    " 重新打开 NERDTree 并定位到指定路径
    execute 'NERDTree ' . a:path
endfunction

" 快捷键
" x——收起该节点的父节点

" vim-dirvish(查找文件) {{{3
" 在 Vim 命令模式下输入 :Dirvish \正常模式下按下-,即可打开当前工作目录的文件浏览器,q退出文件浏览器
" 使用 :Dirvish /path/to/directory 命令可以打开指定目录的文件浏览器
" 将光标移动到目录上，按下回车键（Enter）即可进入该目录。按下 - 键可以返回上级目录
" 按下 o 键会在新窗口打开文件；{visual>A在垂直分割的新窗口打开文件；按下 s 键会在水平分割的新窗口打开文件
" 创建文件：按下 % 键，然后输入文件名，再按下回车键，即可在当前目录下创建新文件。
" 创建目录：按下 d 键，接着输入目录名，最后按下回车键，就能在当前目录下创建新目录。
" 将光标移动到要删除的文件或目录上，按下 D 键，然后确认删除操作
" 将光标移动到要重命名的文件或目录上，按下 R 键，输入新名称后按下回车键
" 复制：先使用 m 标记要复制的文件或目录，然后按下 yy 复制，接着移动光标到目标目录，按下 p 粘贴。
" 移动：同样先使用 m 标记，按下 dd 剪切，再移动到目标目录按下 p 粘贴。
" 单个标记：将光标移动到文件上，按下 m 标记该文件，再次按下 m 取消标记。
" 全选：按下 * 可以标记所有文件，再次按下 * 取消全选。
" 批量重命名 标记好要重命名的文件后，按下 R 进入批量重命名模式，此时会打开一个新的缓冲区，在这个缓冲区中可以对文件名进行编辑，编辑完成后保存退出，所有标记的文件会按照新的名称进行重命名。
" 批量删除 标记好要删除的文件后，按下 D 键，确认删除操作，所有标记的文件会被删除。
" 过滤与排序
" 过滤文件 可以使用 :Dirvish +filter:pattern 命令来过滤文件，只显示符合指定模式的文件。例如，:Dirvish +filter:.txt$ 只显示以 .txt 结尾的文件。
" 排序文件 使用 :Dirvish +sort:option 命令来对文件进行排序。常见的排序选项有： +sort:name：按文件名排序（默认）。 +sort:size：按文件大小排序。 +sort:time：按文件修改时间排序。


" airline {{{3
" 状态栏 {{{4
" 主题 参数：sol/papercolor/silver/base16/angr/jellybeans/lucius等
let g:airline_theme='lucius'   
" let g:airline_theme='onedark'
" 关闭状态显示空白符号计数
 let g:airline#extensions#whitespace#enabled = 0
 let g:airline#extensions#whitespace#symbol = '!'

" 加载 airline 插件
let g:airline#extensions#default#enabled = 1

" 决定buffer栏的格式是否使用powerline字符
let g:airline_powerline_fonts = 1
" powerline字符
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = '╱'
  " let g:airline_left_alt_sep = ''
  " let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = '╱'
  " let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.dirty='⚡'
  let g:airline_symbols.linenr = ' L:'
  let g:airline_symbols.maxlinenr = '☰'
  let g:airline_symbols.colnr = '  C:'



" buffer栏配色
" highlight airline_tabsel gui=bold guifg=#00ffff guibg=#000000
" highlight airline_tabsel gui=bold guifg=#00ffff guibg=#333333
" 右侧tab栏配色
" highlight airline_tabmod gui=bold guifg=#FFFFFF guibg=#333333

" highlight airline_tablabel_right gui=bold guifg=#000000 guibg=#FFFFFF


" 定义函数来获取文件大小
function! GetFileSize()
    if expand('%:p') != ''
        let size = getfsize(expand('%:p'))
        if size < 0
            return 'N/A'
        elseif size < 1024
            return size . 'B'
        elseif size < 1024 * 1024
            return printf('%.1fK', size / 1024.0)
        else
            return printf('%.1fM', size / (1024.0 * 1024))
        endif
    else
        return 'N/A'
    endif
endfunction

" 定义函数获取折叠方式
function! AirlineGetFoldMethod()
    return &foldmethod
endfunction

" %{&fo} formatoptions(页面格式)
" &fo 是 Vim 里一个可用于设置文本格式的选项，它控制着在插入模式下 Vim 对文本进行自动格式化的行为。通过设置不同的标志位到 &fo 选项中，可以让 Vim 在换行、插入标点符号等操作时按照特定的规则来处理文本
" a：自动格式化段落。当你输入文本时，Vim 会自动根据当前的文本宽度进行换行。
" t：使用 textwidth 选项进行自动换行。
" c：在注释中也进行自动换行。
" r：在插入模式下，按 Enter 键时自动插入注释符号。
" o：在插入模式下，按 o 或 O 键时自动插入注释符号
" q:含义：允许使用 gq 命令对注释进行格式化
" l:含义：对长行不进行自动换行


"输入和命令状态,&iminsert：插入模式下输入法的状态,0：表示在插入模式下使用英文输入法,其他非零值：可能对应不同的输入法状态;&imsearch：搜索模式下输入法的状态，和 iminsert 类似
function! IMInsertSearch() 
	return "i" . &iminsert . "s" . &imsearch
endfunction

" 使用 VimEnter 自动命令确保插件加载完成后再执行代码
autocmd VimEnter * call AddInfo()

function! AddInfo()
    " 获取原有的 airline_section_z 内容
    let original_section_z = g:airline_section_z
    " 自定义 airline 的配置，在原有内容(文件类型、编码、查找域、行数、列数)后添加(文件大小、字数、折叠方式、页面格式FO、输入法状态)
    let g:airline_section_z = original_section_z . ' /%{GetFileSize()} /%{AirlineGetFoldMethod()} /%{&fo} /%{IMInsertSearch()}'
endfunction

" airline——tabline(tab、buffer、window) {{{4
"buffer是缓存文件，window是用来显示buffer的窗口，tab则是当前widow的集合（布局），类似于平铺式窗口管理器,不同的tab代表着window的布局不同

" 打开tabline功能,方便查看Buffer和切换,省去了minibufexpl插件
let g:airline#extensions#tabline#enabled = 1   

" :t 表示只显示文件名而不显示路径，这样就能避免路径的缩写或截断显示
let g:airline#extensions#tabline#fnamemod = ':t'

" 调整 vim-airline 插件在 tabline 中显示缓冲区索引的方式
  let g:airline#extensions#tabline#buffer_idx_mode = 1

" tab number
let g:airline#extensions#tabline#tab_nr_type = 1 

" 显示 Tab 的编号
let g:airline#extensions#tabline#show_tab_nr = 1

" 显示缓冲区编号(随机排序，没什么用,还是得看索引）
let g:airline#extensions#tabline#buffer_nr_show = 1

" 显示缓冲区列表
let g:airline#extensions#tabline#show_buffers = 1

" 显示tab区列表
let g:airline#extensions#tabline#show_tabs = 1

" 显示 Tab 数量,设置为 1 时，会在 tabline 中显示当前打开的 Tab 数量；设置为 0 则不显示
let g:airline#extensions#tabline#show_tab_count = 2

" 设置为 1 时，会在 tabline 中为每个 Tab 显示关闭按钮；设置为 0 则不显示。
let g:airline#extensions#tabline#show_close_button = 1

" 用于控制文件名的截断长度，当文件名长度超过 10 个字符时，会将文件名截断显示
let g:airline#extensions#tabline#fnametruncate = 10

" 关闭空白符检测
let g:airline#extensions#whitespace#enabled = 0

" buffer相关快捷键
" 不同buffer切换
nnoremap <leader>1 <Plug>AirlineSelectTab1
nnoremap <leader>2 <Plug>AirlineSelectTab2
nnoremap <leader>3 <Plug>AirlineSelectTab3
nnoremap <leader>4 <Plug>AirlineSelectTab4
nnoremap <leader>5 <Plug>AirlineSelectTab5
nnoremap <leader>6 <Plug>AirlineSelectTab6
nnoremap <leader>7 <Plug>AirlineSelectTab7
nnoremap <leader>8 <Plug>AirlineSelectTab8
nnoremap <leader>9 <Plug>AirlineSelectTab9
nnoremap <leader>0 <Plug>AirlineSelectTab0
nnoremap <leader>- <Plug>AirlineSelectPrevTab
nnoremap <leader>+ <Plug>AirlineSelectNextTab
" Ctrl+T 新建 buffer
nnoremap <C-T> :enew<CR>
" Ctrl+W 关闭 buffer
nnoremap <C-W> :bd<CR>

" tab相关快捷键
" 映射 t + s 组合键来新建一个标签页
nnoremap <silent> ts :tabnew<CR>
" 映射 t + c 组合键来关闭当前标签页
nnoremap <silent> tc :tabclose<CR>
" 映射 t + h 组合键来切换到上一个标签页
nnoremap <silent> th :tabprev<CR>
" 映射 t + l 组合键来切换到下一个标签页
nnoremap <silent> tl :tabnext<CR>
" 映射 t + 数字 组合键跳转到对应的标签页
for i in range(1, 9)
    execute "nnoremap <silent> t".i " :tabn ".i."<CR>"
endfor

" rainbow {{{3
" 启动彩虹括号插件
let g:rainbow_active = 1 

" 命令
"RainbowToggle
"RainbowToggleOn
"RainbowToggleOff

" indentLine {{{3
" 启用 indentLine 插件
let g:indentLine_enabled = 1
 
" 指定缩进线所使用的字符
let g:indentLine_char = '|'
 
" 用于设置缩进线在终端模式下的颜色
let g:indentLine_color_term = 239
" GVim
let g:indentLine_color_gui = '#7eade5'

" vim-easymotion {{{3
" 启用默认快捷键
let g:EasyMotion_do_mapping = 0 

" 占用了重要的快捷键

" 全局搜索一个字符
noremap \\ <Plug>(easymotion-overwin-f)
" " 全局搜索两个字符
" nmap <leader>S <Plug>(easymotion-overwin-f2)

" " 向后搜索word
" nmap <Leader><Leader>w <Plug>(easymotion-w)
" " 向前搜索word
" nmap <Leader><Leader>b <Plug>(easymotion-b)

" " 上下行移动
" map <Leader><Leader>j <Plug>(easymotion-j)
" map <Leader><Leader>k <Plug>(easymotion-k)


" 此设置使 EasyMotion 的工作方式类似于 Vim 的 全局搜索
let g:EasyMotion_smartcase = 1

" 普通模式下\搜索跳转
map \<space> <Plug>(easymotion-sn)
" 在决策模式（输入了一个操作符（如 d 表示删除、y 表示复制等），但还未指定操作范围时所处的模式)下跳转
omap \<space> <Plug>(easymotion-tn)

" 插件扩展功能
" 起始键\一下
let g:EasyMotion_CN_leader_key = "\\"
let g:EasyMotion_CN_do_shade = 0
" 颜色设置
hi link EasyMotion_CNTarget ErrorMsg
hi link EasyMotion_CNShade  Comment
" " 如果定位英文，就\\两下再输入字母
" nnoremap <silent> \\ :call EasyMotion_CN#F('dir',0)<CR>
" nnoremap <silent> \? :call EasyMotion_CN#F('dir',1)<CR>
" nmap s <Plug>(easymotion-s2)
" nmap t <Plug>(easymotion-t2)
" map  n <Plug>(easymotion-next)
" map  N <Plug>(easymotion-prev)

"call EasyMotion#InitMappings({
"   'if' : { 'name': 'F'  , 'dir': 0 }              " f命令
" , 'iF' : { 'name': 'F'  , 'dir': 1 }
" , 'it' : { 'name': 'T'  , 'dir': 0 }              " t命令
" , 'iT' : { 'name': 'T'  , 'dir': 1 }
" , 'iw' : { 'name': 'WB' , 'dir': 0 }              " w命令
" , 'iW' : { 'name': 'WBW', 'dir': 0 }
" , 'ib' : { 'name': 'WB' , 'dir': 1 }              " b命令
" , 'iB' : { 'name': 'WBW', 'dir': 1 }
" , 'ie' : { 'name': 'E'  , 'dir': 0 }              " e命令
" , 'iE' : { 'name': 'EW' , 'dir': 0 }
" , 'ige': { 'name': 'E'  , 'dir': 1 }              " ge命令
" , 'igE': { 'name': 'EW' , 'dir': 1 }
" , 'ij' : { 'name': 'JK' , 'dir': 0 }               "下方向
" , 'ik' : { 'name': 'JK' , 'dir': 1 }               "上方向
" , 'in' : { 'name': 'Search' , 'dir': 0 }           " 搜索上次/的关键字
" , 'iN' : { 'name': 'Search' , 'dir': 1 }
" , 'vz' : { 'name': 'ZWBD' , 'dir': 0 }              "中文标点
" , 'vZ' : { 'name': 'ZWBD' , 'dir': 1 }
" , 'vj' : { 'name': 'ZWJH' , 'dir': 0 }              "中文句号
" , 'vJ' : { 'name': 'ZWJH' , 'dir': 1 }
" , 'vd' : { 'name': 'ZWDH' , 'dir': 0 }              "中文逗号
" , 'vD' : { 'name': 'ZWDH' , 'dir': 1 }
" , 'vy' : { 'name': 'ZWQY' , 'dir': 0 }              "引号，
" , 'vY' : { 'name': 'ZWQY' , 'dir': 1 }
" , 'vk' : { 'name': 'ZWKH' , 'dir': 0 }              "中文括号
" , 'vK' : { 'name': 'ZWKH' , 'dir': 1 }
" , 'vs' : { 'name': 'BJZF' , 'dir': 0 }              "不见字符
" , 'vS' : { 'name': 'BJZF' , 'dir': 1 }
"如果各种符号，就\一下然后输入上面i,v等组合命令
"如果定位中文，就\一下然后拼音字母
" , 'a' : { 'name': 'PYA' , 'dir': 0 }
" , 'A' : { 'name': 'PYA' , 'dir': 1 }
" , 'b' : { 'name': 'PYB' , 'dir': 0 }
" , 'B' : { 'name': 'PYB' , 'dir': 1 }
" , 'c' : { 'name': 'PYC' , 'dir': 0 }
" , 'C' : { 'name': 'PYC' , 'dir': 1 }
" , 'd' : { 'name': 'PYD' , 'dir': 0 }
" , 'D' : { 'name': 'PYD' , 'dir': 1 }
" , 'e' : { 'name': 'PYE' , 'dir': 0 }
" , 'E' : { 'name': 'PYE' , 'dir': 1 }
" , 'f' : { 'name': 'PYF' , 'dir': 0 }
" , 'F' : { 'name': 'PYF' , 'dir': 1 }
" , 'g' : { 'name': 'PYG' , 'dir': 0 }
" , 'G' : { 'name': 'PYG' , 'dir': 1 }
" , 'h' : { 'name': 'PYH' , 'dir': 0 }
" , 'H' : { 'name': 'PYH' , 'dir': 1 }
" , 'j' : { 'name': 'PYJ' , 'dir': 0 }
" , 'J' : { 'name': 'PYJ' , 'dir': 1 }
" , 'k' : { 'name': 'PYK' , 'dir': 0 }
" , 'K' : { 'name': 'PYK' , 'dir': 1 }
" , 'l' : { 'name': 'PYL' , 'dir': 0 }
" , 'L' : { 'name': 'PYL' , 'dir': 1 }
" , 'm' : { 'name': 'PYM' , 'dir': 0 }
" , 'M' : { 'name': 'PYM' , 'dir': 1 }
" , 'n' : { 'name': 'PYN' , 'dir': 0 }
" , 'N' : { 'name': 'PYN' , 'dir': 1 }
" , 'o' : { 'name': 'PYO' , 'dir': 0 }
" , 'O' : { 'name': 'PYO' , 'dir': 1 }
" , 'p' : { 'name': 'PYP' , 'dir': 0 }
" , 'P' : { 'name': 'PYP' , 'dir': 1 }
" , 'q' : { 'name': 'PYQ' , 'dir': 0 }
" , 'Q' : { 'name': 'PYQ' , 'dir': 1 }
" , 'r' : { 'name': 'PYR' , 'dir': 0 }
" , 'R' : { 'name': 'PYR' , 'dir': 1 }
" , 's' : { 'name': 'PYS' , 'dir': 0 }
" , 'S' : { 'name': 'PYS' , 'dir': 1 }
" , 't' : { 'name': 'PYT' , 'dir': 0 }
" , 'T' : { 'name': 'PYT' , 'dir': 1 }
" , 'w' : { 'name': 'PYW' , 'dir': 0 }
" , 'W' : { 'name': 'PYW' , 'dir': 1 }
" , 'x' : { 'name': 'PYX' , 'dir': 0 }
" , 'X' : { 'name': 'PYX' , 'dir': 1 }
" , 'y' : { 'name': 'PYY' , 'dir': 0 }
" , 'Y' : { 'name': 'PYY' , 'dir': 1 }
" , 'z' : { 'name': 'PYZ' , 'dir': 0 }
" , 'Z' : { 'name': 'PYZ' , 'dir': 1 }
"\ })

" surround {{{3
" 定义自定义映射，按下 <leader>[ 包裹当前单词
nnoremap <leader>[ viw<esc>bi[[<esc>ea]]<esc>
 
" 默认配置就很好用了
" 具体说明
" 1. 添加环绕（ys 操作符） {{{4
" 普通模式下添加： {{{5
" 在普通模式下，ys 是添加环绕的操作符，后面需要接一个动作（如 w 表示一个单词，s 表示一个句子，p 表示一个段落等）和环绕字符。
" before word      command     after word 
"   text            ysiw'         'text'
"   text            ySiw'           '  
"                                  text
"                                   '
" this is a test    yss(      (this is a test)

" 可视模式下添加： {{{5
" 先进入可视模式（如按 v 进入字符可视模式，V 进入行可视模式），选中要添加环绕的文本，然后按 S，接着输入环绕字符。
"   text       v选中后S<div>      <div>text</div>

" 2. 修改环绕（cs 操作符） {{{4
" 在普通模式下，cs 用于修改已有的环绕字符。它后面需要接两个参数：原环绕字符和新环绕字符。
" （"word"）      cs"'      （'word'）

" 3. 删除环绕（ds 操作符） {{{4
" 在普通模式下，ds 用于删除已有的环绕字符。它后面接要删除的环绕字符。
"  'word'        ds'          word               

"quickui {{{4

" 更改边框字符
let g:quickui_border_style = 2
  
" 更改配色方案
let g:quickui_color_scheme = 'papercol dark'

call quickui#menu#reset()

call quickui#menu#install("&File", [
			\ [ "&Open\t(:w)", 'call feedkeys(":tabe ")'],
			\ [ "&Save\t(:w)", 'write'],
			\ [ "--", ],
			\ [ "LeaderF &File", 'Leaderf file', 'Open file with leaderf'],
			\ [ "LeaderF &Mru", 'Leaderf mru --regexMode', 'Open recently accessed files'],
			\ [ "LeaderF &Buffer", 'Leaderf buffer', 'List current buffers in leaderf'],
			\ [ "--", ],
			\ [ "J&unk File", 'JunkFile', ''],
			\ [ "Junk L&ist", 'JunkList', ''],
			\ [ "--", ],
			\ [ "&Terminal Tab", 'OpenTerminal tab', 'Open internal terminal in a new tab'],
			\ [ "Terminal Spl&it", 'OpenTerminal right', 'Open internal terminal in a split'],
			\ [ "Browse &Git", 'BrowseGit', 'Browse code in github'],
			\ ])


if has('win32') || has('win64') || has('win16')
	call quickui#menu#install('&File', [
				\ [ "start &cmd", 'silent !start /b cmd /c c:\drivers\clink\clink.cmd' ],
				\ [ "start &powershell", 'silent !start powershell.exe' ],
				\ [ "open &explore", 'call show_explore()' ],
				\ ])
endif

call quickui#menu#install("&File", [
			\ [ "--", ],
			\ [ "e&xit", 'qa' ],
			\ ])


call quickui#menu#install("&Git", [
			\ ["Git &Status\t(Fugitive)", 'Git'],
			\ ["Git P&ush\t(Fugitive)", 'Gpush'],
			\ ["Git Fe&tch\t(Fugitive)", 'Gfetch'],
			\ ["Git R&ead\t(Fugitive)", 'Gread'],
			\ ["Git &Flog\t(vim-flog)", 'Flog'],
			\ ])


if has('win32') || has('win64') || has('win16') || has('win95')
	call quickui#menu#install("&Git", [
				\ ['--',''],
				\ ["Project &Update\t(Tortoise)", 'call svnhelp#tp_update()', 'TortoiseGit / TortoiseSvn'],
				\ ["Project &Commit\t(Tortoise)", 'call svnhelp#tp_commit()', 'TortoiseGit / TortoiseSvn'],
				\ ["Project L&og\t(Tortoise)", 'call svnhelp#tp_log()',  'TortoiseGit / TortoiseSvn'],
				\ ["Project &Diff\t(Tortoise)", 'call svnhelp#tp_diff()', 'TortoiseGit / TortoiseSvn'],
				\ ["Project &Push\t(Tortoise)", 'call svnhelp#tp_push()', 'TortoiseGit'],
				\ ["Project S&ync\t(Tortoise)", 'call svnhelp#tp_sync()', 'TortoiseGit'],
				\ ['--',''],
				\ ["File &Add\t(Tortoise)", 'call svnhelp#tf_add()', 'TortoiseGit / TortoiseSvn'],
				\ ["File &Blame\t(Tortoise)", 'call svnhelp#tf_blame()', 'TortoiseGit / TortoiseSvn'],
				\ ["File Co&mmit\t(Tortoise)", 'call svnhelp#tf_commit()', 'TortoiseGit / TortoiseSvn'],
				\ ["File D&iff\t(Tortoise)", 'call svnhelp#tf_diff()', 'TortoiseGit / TortoiseSvn'],
				\ ["File &Revert\t(Tortoise)", 'call svnhelp#tf_revert()', 'TortoiseGit / TortoiseSvn'],
				\ ["File Lo&g\t(Tortoise)", 'call svnhelp#tf_log()', 'TortoiseGit / TortoiseSvn'],
				\ ])
endif

call quickui#menu#install('Help (&?)', [
			\ ["&Index", 'tab help index', ''],
			\ ['Ti&ps', 'tab help tips', ''],
			\ ['--',''],
			\ ["&Tutorial", 'tab help tutor', ''],
			\ ['&Quick Reference', 'tab help quickref', ''],
			\ ['&Summary', 'tab help summary', ''],
			\ ['--',''],
			\ ['&Vim Script', 'tab help eval', ''],
			\ ['&Function List', 'tab help function-list', ''],
			\ ['&Dash Help', 'call asclib#utils#dash_ft(&ft, expand("<cword>"))'],
			\ ], 10000)

" 双击<space>打开目录
noremap <space><space> :call quickui#menu#open()<cr>

" 模糊查找 {{{3

" 弹出窗口
let g:Lf_WindowPosition = 'popup'
" Show icons, icons are shown by default
let g:Lf_ShowDevIcons = 1

" 设置 LeaderF 文件查找快捷键
nnoremap <C-p> :Leaderf file<CR>
" 设置 LeaderF 缓冲区查找快捷键
nnoremap <leader>b :Leaderf buffer<CR>
" 定义快捷键 <Leader>m 来打开最近文件列表
nnoremap <A-r> :Leaderf mru<CR>

" 注释插件 {{{3

" 默认情况下，在注释符后面添加空格 
let g:NERDSpaceDelims = 1

" 先设置系统全局默认变量
set commentstring=//%s "cms(缺省在未知或者没有扩展名的时候为 "/*%s*/")

" 给文件类型规定格式
let g:NERDCustomDelimiters = {
    \ 'vim': { 'left': '"' },
    \ }

" h NERDCommenter
" Normal模式下，几乎所有命令前面都可以指定行数
" Visual模式下执行命令，会对选中的特定区块进行注释/反注释
" <leader>c<空格> 如果被选区域有部分被注释，则对被选区域执行取消注释操作，其它情况执行反转注释操作,如果最上面的选定行已注释，则所有选定行都未注释，反之亦然。
" <leader>cs 添加性感的注释，代码开头介绍部分通常使用该注释
" <leader>cm 对被选区域用一对注释符进行注释，前面的注释对每一行都会添加注释
" <leader>ca normal模式中执行，在可选的注释方式之间切换，比如C/C++ 的块注释/* */和行注释//
" <leader>ci 执行反转注释操作，选中区域注释部分取消注释，非注释部分添加注释
" <leader>cc 注释当前行和选中行
" <leader>cA 在当前行尾添加注释符，并进入Insert模式
" <leader>c$ 注释当前光标到改行结尾的内容
" <leader>cn 没有发现和\cc有区别,注释掉在可视模式下选择的当前行或文本,与 cc 相同，但强制嵌套。
" <leader>cy 添加注释，并复制被添加注释的部分
" <leader>cl \cb 左对齐和左右对其，左右对其主要针对/**/
" <leader>cu 取消注释

" Normal模式下，几乎所有命令前面都可以指定行数
" Visual模式下执行命令，会对选中的特定区块进行注释/反注

" Markdown预览 {{{3

" 在md文件中预览开关
autocmd FileType markdown nnoremap <buffer> <leader><leader>p <Plug>MarkdownPreviewToggle

" Markdown图像粘贴 {{{3

" 在md文件中快捷键进行图像粘贴
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>

" 默认剪贴板图片保存目录和命名
let g:mdip_imgdir = 'image'
let g:mdip_imgname = 'image'

" 即时生成表插件 {{{3

" 特定类型文件快捷键启用
" autocmd FileType markdown TableModeEnable

" 设置快捷键来启动表格模式
nmap <leader>tm :TableModeToggle<CR>

" 在完成的表格上方或者下方键入补充边框线
let g:table_mode_corner='|'

" easy-align {{{3
" 快捷键定义
nnoremap <Leader>ga :EasyAlign
xnoremap <Leader>ga :EasyAlign

" 在对齐时，忽略注释（Comment）和字符串（String）中的内容，避免对齐操作破坏注释或字符串的格式
let g:easy_align_ignore_groups = ['Comment', 'String']

" 使用预定义的对齐规则
"   :EasyAlign[!] [N-th] DELIMITER_KEY [OPTIONS]
":EasyAlign :
":EasyAlign =
":EasyAlign *=
":EasyAlign 3\
" 使用正则表达式作为对齐的分隔符
"   :EasyAlign[!] [N-th] /REGEXP/ [OPTIONS]
":EasyAlign /[:;]\+/
":EasyAlign 2/[:;]\+/
":EasyAlign */[:;]\+/
":EasyAlign **/[:;]\+/
" 左对齐到第一个分隔符的位置出现
":EasyAlign =
" Left-alignment around the SECOND occurrences of delimiters
":EasyAlign 2=
" Left-alignment around the LAST occurrences of delimiters
":EasyAlign -=
" Left-alignment around ALL occurrences of delimiters
":EasyAlign *=
" Left-right ALTERNATING alignment around all occurrences of delimiters
":EasyAlign **=
" Right-left ALTERNATING alignment around all occurrences of delimiters
":EasyAlign! **=


" Markdown目录生成 {{{3

" 自动更新目录
" autocmd BufWritePost *.md :GenTocGFM

" 在md文件中添加目录(根据不同需求选择)
" 方式：GenTocGFM(此命令适用于 GitHub 存储库中的 Markdown 文件，如 和 GitBook 的 Markdown 文件)
"       GenTocRedcarpet(此命令适用于 Jekyll 或其他任何使用 Redcarpet 作为其 Markdown 解析器的地方)
"       GenTocGitLab(此命令适用于 GitLab 仓库和 wiki)
"       GenTocMarked(为 iamcco/markdown-preview.vim 生成目录，该目录使用 Marked markdown 解析器)
autocmd FileType markdown nnoremap <buffer> <leader>gt :GenTocGFM<CR>

" 在md文件中删除目录
autocmd FileType markdown nnoremap <buffer> <leader>rt :RemoveToc<CR>


" vim-signature(Mark标记） {{{3

" 定义标记的颜色  GUI 模式下文本颜色为红色 终端模式下文本颜色为红色
highlight SignatureMarkText guifg=red ctermfg=1
" 设置标记符号的颜色 GUI 模式下符号颜色为绿色 终端模式下符号颜色为绿色
highlight SignatureMarkSigns guifg=green ctermfg=2
" 设置快捷键,现示当前缓冲区的标记列表
nnoremap <leader>mk :SignatureListBufferMarks<CR>

  " mx           Toggle mark 'x' and display it in the leftmost column
  " dmx          Remove mark 'x' where x is a-zA-Z

  " m,           Place the next available mark
  " m.           If no mark on line, place the next available mark. Otherwise, remove (first) existing mark.
  " m-           Delete all marks from the current line
  " m<Space>     Delete all marks from the current buffer
  " ]`           Jump to next mark
  " [`           Jump to prev mark
  " ]'           Jump to start of next line containing a mark
  " ['           Jump to start of prev line containing a mark
  " `]           Jump by alphabetical order to next mark
  " `[           Jump by alphabetical order to prev mark
  " ']           Jump by alphabetical order to start of next line having a mark
  " '[           Jump by alphabetical order to start of prev line having a mark
  " m/           Open location list and display marks from current buffer

  " m[0-9]       Toggle the corresponding marker !@#$%^&*()
  " m<S-[0-9]>   Remove all markers of the same type
  " ]-           Jump to next line having a marker of the same type
  " [-           Jump to prev line having a marker of the same type
  " ]=           Jump to next line having a marker of any type
  " [=           Jump to prev line having a marker of any type
  " m?           Open location list and display markers from current buffer
  " m<BS>        Remove all markers

" g'：与 ' 命令类似，用于跳转到标记处，但 g' 会精确跳转到标记所在的行和列位置，而 ' 只跳转到标记所在行的行首


" vim-fugitive(git插件) {{{3


" coc.nvim插件 {{{3

" <C-n> 正向遍历其列表项，<C-p> 对其进行反向遍历
" " 启用 coc.nvim 的命令行补全
inoremap <silent><expr> <C-Space> coc#refresh()

" " 当在命令行输入时触发补全
function! s:check_back_space() abort
   let col = col('.') - 1
   return !col || getline('.')[col - 1]  =~# '\s'
endfunction




" 高亮选中关键字 开关 toggle highlight  {{{3
" z\以切换高亮显示开/关。当空闲时 高亮显示光标下的所有单饲。在学习奇怪的源 代码时非常有用。
nnoremap z\ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
" 切换自动高亮功能的开启和关闭状态
function! AutoHighlightToggle()
	let @/ = ''
	if exists('#auto_highlight')
	au! auto_highlight
	augroup! auto_highlight
	setl updatetime=4000
	echo 'Highlight current word: off'
	return 0
	else
	augroup auto_highlight
		au!
		au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
	augroup end
	setl updatetime=500
	echo 'Highlight current word: ON'
	return 1
	endif
endfunction



" fencview plugin {{{3
"在.vimrc中加入上面安装的fencview插件指令,复制到iconv.dll到windows的path目录之中
"打开文件时自动识别编码
let g:fencview_autodetect=0        
"扩展名
let g:fencview_auto_patterns='*'        
"检查前后10行来判断编码
let g:fencview_checklines = 10        
":FencAutoDetect 自动识别文件编码
":FencView 打开一个编码列表窗口，用户选择编码reload文件
":FencManualEncoding coding 手动设置文件编码，用你想使用的编码代替coding
map <silent> <leader>fa :FencAutoDetect<cr><cr>
map <silent> <leader>fv :FencView<cr>



" 中英文标点符号(输入法设置中文状态下使用英文,对于中文符号的处理一律 {{{3
" 定义英文标点符号到中文标点符号的映射
let g:ywpunc = {
			\'''' : ['‘', '’'],
			\'"' : ['“', '”'],
			\'...' : '……',
      \'^' : '……',
			\'!' : '！',
			\',' : '，',
			\'.' : '。',
			\"`" : '～',
			\':' : '：',
			\'(' : '（',
			\')' : '）',
			\'[' : '［',
			\']' : '］',
			\'<' : '《',
			\'>' : '》',
			\'-' : '－',
			\'*' : '×',
			\'/' : '、',
			\'+' : '＋',
			\';' : '；',
			\'?' : '？',
			\'%' : '％',
			\' ' : '　',
			\'{' : '｛',
			\'}' : '｝',
			\'1' : '１',
			\'2' : '２',
			\'3' : '３',
			\'4' : '４',
			\'5' : '５',
			\'6' : '６',
			\'7' : '７',
			\'8' : '８',
			\'9' : '９',
			\'0' : '０',
			\'a' : 'ａ',
			\'b' : 'ｂ',
			\'c' : 'ｃ',
			\'d' : 'ｄ',
			\'e' : 'ｅ',
			\'f' : 'ｆ',
			\'g' : 'ｇ',
			\'h' : 'ｈ',
			\'i' : 'ｉ',
			\'j' : 'ｊ',
			\'k' : 'ｋ',
			\'l' : 'ｌ',
			\'m' : 'ｍ',
			\'n' : 'ｎ',
			\'o' : 'ｏ',
			\'p' : 'ｐ',
			\'q' : 'ｑ',
			\'r' : 'ｒ',
			\'s' : 'ｓ',
			\'t' : 'ｔ',
			\'u' : 'ｕ',
			\'v' : 'ｖ',
			\'w' : 'ｗ',
			\'x' : 'ｘ',
			\'y' : 'ｙ',
			\'z' : 'ｚ',
			\'A' : 'Ａ',
			\'B' : 'Ｂ',
			\'C' : 'Ｃ',
			\'D' : 'Ｄ',
			\'E' : 'Ｅ',
			\'F' : 'Ｆ',
			\'G' : 'Ｇ',
			\'H' : 'Ｈ',
			\'I' : 'Ｉ',
			\'J' : 'Ｊ',
			\'K' : 'Ｋ',
			\'L' : 'Ｌ',
			\'M' : 'Ｍ',
			\'N' : 'Ｎ',
			\'O' : 'Ｏ',
			\'P' : 'Ｐ',
			\'Q' : 'Ｑ',
			\'R' : 'Ｒ',
			\'S' : 'Ｓ',
			\'T' : 'Ｔ',
			\'U' : 'Ｕ',
			\'V' : 'Ｖ',
			\'W' : 'Ｗ',
			\'X' : 'Ｘ',
			\'Y' : 'Ｙ',
			\'Z' : 'Ｚ',
			\}
" 成对标点配对控制
let g:ywpair = 1
" 在普通模式和可视模式下按下 <Leader>rzf，触发标点符号转换 
vmap <Leader>rzf s<C-R>=Yw_strzhpunc2enpunc(@", '')<CR><ESC>
nmap <Leader>rzf s<C-R>=Yw_strzhpunc2enpunc(@", '')<CR><ESC>
" vnoremap <Leader>rzf s<C-R>=Yw_strzhpunc2enpunc(@", '')
" nnoremap <Leader>rzf s<C-R>=Yw_strzhpunc2enpunc(@", '')

if !exists("g:ywpair")
	let s:ywpair = 0
else
	let s:ywpair = g:ywpair
endif
" {{{ 标点中英互换
function! Yw_strzhpunc2enpunc(str, m) 
	if !exists("g:ywpunc") || a:str == ''
		return ''
	endif
	let strlst = split(a:str, '\zs')
	let transtr = ''
	for i in range(len(strlst))
		let tran = <SID>Yw_zhpunc2enpunc(strlst[i], a:m)
		if type(tran) == type([])
			if s:ywpair == 1
				let pairchar0 = tran[0]
				let pairchar1 = tran[1]
				let pairidx0 = match(transtr, '[^' . pairchar0 . ']*$')
				let pairidx1 = match(transtr, '[^' . pairchar1 . ']*$')
				let tranchar = (pairidx0 <= pairidx1 ? pairchar0 : pairchar1)
			else
				let tranchar = tran[0]
			endif
		else
			let tranchar = tran
		endif
		unlet tran
		let transtr .= tranchar
	endfor
	return transtr
endfunction 
" }}}

" {{{ 标点中英互换
function! s:Yw_zhpunc2enpunc(c, m) 
	let escapetranchar = '\V' . escape(a:c, '\')
	let keyidx = match(keys(g:ywpunc), escapetranchar)
	let validx = match(values(g:ywpunc), escapetranchar)
	if (keyidx != -1) && (a:m == "" || a:m == 'l2r')
		let tranchar = values(g:ywpunc)[keyidx]
	elseif (validx != -1) && (a:m == "" || a:m == 'r2l')
		let tranchar = keys(g:ywpunc)[validx]
	else
		let tranchar = a:c
	endif
	return tranchar
endfunction 
" }}}

" vim笔记配置 {{{3
" vimwiki {{{4
let $VIM_PARENT = fnamemodify($VIM, ':h')
let g:vimwiki_list = [{'path': $VIM_PARENT. g:slash .'vimwiki', 'syntax': 'markdown', 'ext': 'md','filetype': 'markdown' }]

" 后设置 .md 文件的文件类型为 markdown（覆盖 Vimwiki 的默认行为）
autocmd BufEnter *.md if &filetype !=# 'markdown' | set filetype=markdown | endif

" calendar {{{4

" vim-which-key {{{4
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

  " vim-choosewin(对于多tab窗口跳转很有用） {{{3
  " 使用 <leader>- 来选择窗口
nmap  <leader>-  <Plug>(choosewin)

  " winresizer(调整window大小) {{{3
" 调整内部window
let g:winresizer_start_key = '<C-e>'
" 调整GUI大小
let g:winresizer_gui_enable = 1
" let g:winresizer_gui_start_key='<C-m>'

" vim-visual-multi {{{3

" vim-grepper {{{3


""""""""""""""""""""""""""""""
" 代码 {{{1
""""""""""""""""""""""""""""""
" ctags {{{2
" “-R”表示递归创建，也就包括源代码根目录（当前目录）下的所有子目录。“*”表示所有文件。这条命令会在当前目录下产生一个“tags”文件， 当用户在当前目录中运行vi时，会自动载入此tags文件
if (g:isWin)
	map <silent> <leader>st :!ctags.exe -R *<CR>
endif
set previewheight=12
"和ctags配合使用。用ctags创建了tags文件后，在你要查看定义的函数或变量上按
"nmap '' :ptag <C-R><C-W><cr><C-w><C-w>
" 在上方打开查看函数的文件
nmap '' :ptag <C-R><C-W><cr>
" 关闭查看函数的文件
nmap 'c :pclose<cr>
"用于cscope，当用cscope创建了tags后，在你光标所在的函数上
"按ctrl-] ctrl-[会跳转到该函数的调用处
"map <C-]><C-[> :cs f 2 <cword><cr>


" Tag list (ctags) {{{2
if g:isWin == 1
	let Tlist_Ctags_Cmd = 'ctags'
else
	let Tlist_Ctags_Cmd = '/usr/bin/ctags'
endif
let Tlist_Use_Right_Window = 1         "在右侧窗口中显示taglist窗口
"let Tlist_Use_Left_Window=0

let Tlist_Auto_Open=0 "启动VIM后，自动打开taglist窗口
let Tlist_Auto_Update=1
let Tlist_Hightlight_Tag_On_BufEnter=1
let Tlist_Display_Prototype=0
let Tlist_Compact_Format=1             "不显示F1帮助
let Tlist_Show_One_File = 1            "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_WinWidth = 30

"Tlist_Exit_OnlyWindow "最后一个窗口时退出VIM
"Tlist_Show_Menu "显示taglist菜单
"Tlist_Max_Submenu_Items和Tlist_Max_Tag_Length;菜单条目数和所显示tag名字的长度；
"Tlist_Use_SingleClick "单击tag就跳转
"Tlist_Close_On_Select "选择了tag后自动关闭taglist窗口
"Tlist_File_Fold_Auto_Close "只显示当前文件tag，其它文件的tag都被折叠起来。
"Tlist_GainFocus_On_ToggleOpen "希望输入焦点在taglist窗口中
"Tlist_Process_File_Always "taglist始终解析文件中的tag，不管taglist窗口有没有打开
"Tlist_WinHeight和Tlist_WinWidth可以设置taglist窗口的高度和宽度。
"Tlist_Use_Horiz_Window为１设置taglist窗口横向显示；
map <silent> <leader>tl :TlistOpen<cr>
nmap <F8> <ESC>:TlistToggle<CR>
"在taglist窗口中，可以使用下面的快捷键：
"<CR> 跳到光标下tag所定义的位置，用鼠标双击此tag功能也一样
"o 在一个新打开的窗口中显示光标下tag
"<Space> 显示光标下tag的原型定义
"u 更新taglist窗口中的tag
"s 更改排序方式，在按名字排序和按出现顺序排序间切换
"x taglist窗口放大和缩小，方便查看较长的tag
"+ 打开一个折叠，同zo
"- 将tag折叠起来，同zc
"* 打开所有的折叠，同zR
"= 将所有tag折叠起来，同zM
"[[ 跳到前一个文件
"]] 跳到后一个文件
"q 关闭taglist窗口
"<F1> 显示帮助

"ctrl+] 查找光标下的标签（可查看函数定义）
"ctrl+t 返回跳转到标签的前一次位置（即上一个标签）
"ctrl+o 返回源文件

"ctags for windows
"http://ctags.sourceforge.net
"cscope for windows
"http://sourceforge.net/projects/mslk/files/Cscope/

" 用来更新目标窗口内容及更新目标文件名的函数。
" 当双击或者输入CTRL-]时调用这个函数。
function! SToc(tag)
  " 高亮标题
  exe 'match Todo /\%' . line(".") . 'l/'
  " 获取目标窗口当前的编号
	let nr=bufwinnr(bufname(g:xbn))
  " 跳到目标窗口
	exe nr."wincmd w"
  " 在目标窗口中打开tag
	silent! exe "tag " . a:tag
  " 更新目标窗口中的文件名（全局变量）
	let g:xbn=bufname('%')
endfunction

" 负责初始化的函数
function! IToc()
  " 如果当前编辑区无文件，则打开一个临时窗口
  if bufname('%')=="" | view _blah_  | endif
  " 初始化全局变量，这个变量用来跟踪当前编辑区的文件名
	let g:xbn=bufname('%')
  " 打开一个窗口并做导航
  vsp __目录__
  " 不需要实体文件
  setlocal buftype=nofile
  " 简单的语法高亮
  syn match Comment "[^-]"
  " 从tags读取信息并转换成“用户友好”的格式显示
  call append(line('$'),
    \map(taglist("^"),
    \'substitute(printf("%-30s%s",v:val["name"],' .
    \'(has_key(v:val,"author")?v:val["author"]:""))," ","-","g")'
    \))
  " 定义导航键
  map <2-LeftMouse> :call SToc('/'.expand("<cword>"))<CR>zt
  nmap <C-]> <2-LeftMouse>
endfunction

" 定义打开导航窗口的命令
command! -nargs=0 Toc call IToc()


" cscope 注意和Surround快捷键冲突 {{{2

"(1) 我们假设我们要阅读的代码放在D:\src\myproject下。然后打开命令行，进入源代码所在的目录，为cscope建立搜索文件列表。在命令行中执行以下命令：
"D:\src>dir /s /b *.c *.cpp *.java *.h > cscope.files
"
"(linux 中用  find /my/project/dir -name '*.c' -o -name '*.h' > /foo/cscope.files )
"D:\src>cscope -Rbkq
"执行结束后你可以在当前目录下发现cscope.out文件，这就是cscope建立的符号数据库。上面这个命令中，-b参数使得cscope不启动自带的用户界面，而仅仅建立符号数据库

if has("cscope") && executable("cscope")
  set csto=1
  set cst
	set cscopequickfix=c-,d-,e-,g-,i-,s-,t-
	if (g:isWin)
		map <silent> <leader>os :!dir /s /b *.c *.cpp *.java *.h > cscope.files & cscope -Rbkq<CR>
	endif

  " add any database in current directory
  " (cscope.out默认编码解析不了中文)
  function! CscopeAdd()
    set nocsverb
    if filereadable(expand('%:h:p') . "/cscope.out")
      exe 'cs add ' . expand('%:h:p') . '/cscope.out'
    elseif filereadable(expand('%:h:p') . "/../cscope.out")
      exe 'cs add ' . expand('%:h:p') . '/../cscope.out'
    elseif filereadable("cscope.out")
      cs add cscope.out
    endif
    set csverb
  endfunction

  autocmd BufRead *.c,*.cpp,*.h call CscopeAdd()


	" 映射 [[[2
	" 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
	nmap oss :cs find s <C-R>=expand("<cword>")<CR><CR>
	" 查找函数、宏、枚举等定义的位置，类似ctags所提供的功能
	nmap osg :cs find g <C-R>=expand("<cword>")<CR><CR>
	" 查找本函数调用的函数
	nmap osd :cs find d <C-R>=expand("<cword>")<CR><CR>
	" 查找调用本函数的函数
	nmap osc :cs find c <C-R>=expand("<cword>")<CR><CR>
	" 查找指定的字符串
	nmap ost :cs find t <C-R>=expand("<cword>")<CR><CR>
	" 查找egrep模式，相当于egrep功能，但查找速度快多了
	nmap ose :cs find e <C-R>=expand("<cword>")<CR><CR>
	" 查找并打开文件，类似vim的find功能
	nmap osf :cs find f <C-R>=expand("<cfile>")<CR><CR>
	" 查找包含本文件的文件
	nmap osi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	" 生成新的数据库
	nmap osn :lcd %:p:h<CR>:!my_cscope<CR>
	" 自己来输入命令
	nmap os<Space> :cs find
	" 建立连接
	nmap osa :call CscopeAdd()<CR>

	nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	" scs分隔在当前，vert放在右边nmap <C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>s :scs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>g :scs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>d :scs find d <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>c :scs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>t :scs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>e :scs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-_>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 配色方案 {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if  g:colors_name ==# 'evening'
        " 当使用 sevening 配色方案时
  " buffer配色
        highlight airline_tabsel gui=bold guifg=#00ffff guibg=#333333
    " 文件更改后/右侧tab配色
        highlight airline_tabmod gui=bold guifg=#FFFFFF guibg=#333333
    " 右侧buffers
        highlight airline_tablabel_right gui=bold guifg=#4C0099 guibg=#E0E0E0

    " elseif &background ==# 'onedark'
        " " 当使用 onedark 配色方案时
        " highlight airline_tablabel_right gui=bold guifg=#000000 guibg=#FFFFFF
    endif


" 高亮搜索
highlight Search guibg=#FABD2F guifg=black ctermbg=3 ctermfg=0
highlight CurSearch guibg=#FF8000 guifg=black ctermbg=3 ctermfg=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" mswin {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 重新映射 Ctrl+Q 为 Ctrl+V 的功能
" insert,command模式下<C-v>用来插入字符;normal模式下快区域选中
noremap <C-Q> <C-V>

" 允许退格键删除缩进、换行符和行首内容,
set backspace=indent,eol,start 
" 允许方向键在行首和行尾时换行
set whichwrap+=<,>,[,]

" 在可视模式下,退格键可以删除
vnoremap <BS> d

" 映射 Ctrl+X 和 Shift+Del 为剪切操作
vnoremap <C-X> "+x
vnoremap <S-Del> "+x

" 映射 Alt+A 和 Alt+X 为数字加减
nnoremap <A-a> <C-a>
nnoremap <A-x> <C-x>

" 在可视模式下，Ctrl+C 和 Ctrl+Insert 会将选中的内容复制到系统剪贴板
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y

" 将 Ctrl + V 和 Shift + Insert 这两个按键组合映射为粘贴操作
map <C-V> "+gP
map <S-Insert> "+gP

" 在命令行模式下，将 <C-V> 和 <S-Insert> 映射为从系统剪贴板插入文本的操作
cmap <C-V> <C-R>+
cmap <S-Insert> <C-R>+

" 将 Alt + V 和 Alt + C 在命令行模式（cmap）和插入模式（inoremap）下映射为插入默认寄存器内容的操作
cmap <A-v> <C-R>"
inoremap <A-v> <C-R>"
cmap <A-c> <C-R>"
inoremap <A-c> <C-R>"

" 在插入模式下，将 Ctrl + Backspace 映射为删除前一个单词的操作
inoremap <C-BS> <C-W>

" 优化在插入模式和可视模式下的粘贴功能，尤其是处理块选择和行选择的粘贴情况
exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

imap <S-Insert> <C-V>
vmap <S-Insert> <C-V>

" 方便在不同模式下使用 Ctrl + S 来保存文件
noremap <C-s> :update<CR>
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" 在非 Unix 系统上，为了让 Ctrl + V 正常工作，关闭自动选择功能
if !has("unix")
	set guioptions-=a
endif

" 在普通模式下，Ctrl + Z 直接映射为 u 命令进行撤销操作
noremap <C-Z> u
" 在插入模式下，使用 <C-O> 临时切换到普通模式执行 u 命令
inoremap <C-Z> <C-O>u

" 在普通模式下，Ctrl + Y 映射为 <C-R> 命令进行重做操作
noremap <C-Y> <C-R>
" 在插入模式下，同样使用 <C-O> 临时切换到普通模式执行 <C-R> 命令
inoremap <C-Y> <C-O><C-R>

" 将 Ctrl + A 映射为全选操作
noremap <C-A> ggVG
inoremap <C-A> <C-C>ggVG
cnoremap <C-A> <C-C>ggVG
onoremap <C-A> <C-C>ggVG
snoremap <C-A> <C-C>ggVG
xnoremap <C-A> <C-C>ggVG

" 在普通模式下，F4 直接映射为 <C-W>c 命令关闭当前窗口
noremap <F4> <C-W>c
" 在插入模式下，使用 <C-O> 临时切换到普通模式执行 <C-W>c 命令
inoremap <F4> <C-O><C-W>c

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 通用设置 {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设置 Vim 菜单的语言
set langmenu=zh_CN.UTF-8
" 设置 Vim 提示信息的语言
language message zh_CN.UTF-8

"默认编码部分
set encoding=utf-8
"终端和win下的Console 窗口的编码,用于设置 Vim 与终端之间通信所使用的字符编码
set termencoding=utf-8
"指定 Vim 在打开文件时尝试检测的字符编码列表
set fileencodings=utf-8,ucs-bom,chinese,gb18030,cp936,gbk,big5,euc-jp,euc-kr,latin1

" 文件类型插件,当 filetype plugin on 被执行时，Vim 会根据当前打开文件的类型，自动加载相应的文件类型插件。
filetype plugin on  

" 启用文件类型相关的缩进规则
filetype indent on

" 设置 Vim 在处理文件时支持的换行符格式及其优先级顺序,ffs（fileformats 的缩写）
set ffs=dos,unix,mac 

"终端开启256色支持
set t_Co=256

"无菜单、工具栏 go=e显示标签栏
set go=           

" 显示行号number nu nonumber nonu
set nu            
" 相对行号 relativenumber rnu
set rnu           
" 修改行号为浅灰色，默认主题的黄色行号很难看，换主题可以仿照修改
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
" 修改当前行号颜色
highlight CursorLineNr guifg=#FAA93F

" 去掉 sign column 的白色背景
hi! SignColumn guifg=NONE guibg=NONE ctermbg=NONE

" 修正补全目录的色彩：默认太难看
hi! Pmenu guibg=gray guifg=black ctermbg=gray ctermfg=black
hi! PmenuSel guibg=gray guifg=brown ctermbg=brown ctermfg=gray


" 显示命令(右下角）
set showcmd       

" 可以在没有保存的情况下切换buffer
set hid           

" eol：允许退格键删除行尾的换行符（即跨行删除）
" start：允许退格键删除插入模式开始前的字符（即删除插入模式启动前的输入）
" indent：允许退格键删除自动缩进的空格
set backspace=eol,start,indent

" 退格键和方向键可以换行
set whichwrap+=<,>,h,l 

" 增量式搜索,在执行查找前预览第一处匹配
set incsearch     

" hls,hlsearch 高亮搜索,noh临时关闭，nohls关闭
set hls
" 执行重新绘制，并且取消通过 / 和 ? 匹配字符的高亮，修复代码高亮问题,刷新「比较模式」的代码高亮
" nnoremap <Tab> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>
" vim中<C-i>和<Tab>的键码相同,把 <Tab> 键映射成了其他功能，那么也将会改变 <C-i> 命令的缺省行为
nnoremap <C-l> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>
nnoremap <C-i> <C-i>
" <C-i>,<C-o>向前向后遍历列表 :jumps
" g; 和 g, 命令反向或正向遍历改变列表 :changes
" 标识上次修改方位的位置标记
" 跳转到光标下的文件
" Vim 会为编辑会话中的每个单独缓冲区维护一个改变列表，而与之不同的是，每个窗口都会创建一个单独的跳转列表


" ignorecase
" 搜索时忽略大小写/(通过元字符\c让查找模式忽略大小写,\C强制区分大小写——元字符可以出现在任何位置)
set ic            
" 启用更具智能的大小写敏感性设置,只要输入一个大写字母区分大小写
set smartcase
" Vim 进行正则表达式搜索与替换操作时,把部分特殊字符视为具有特殊含义的元字符
set magic
" 用 very magic 搜索模式查找十六进制颜色代码,可以利用 \v 模式开关来统一所有特殊符号的规则。
" 按原义查找文本时，使用 \V 原义开关

" 界定单词的边界
" 零宽度元字符:本身不匹配任何字符，仅表示单词与围绕此单词的空白字符（或标点符号）之间的边界
" <与> 符号表示单词定界符

" 界定匹配的边界
" Vim 中的元字符 \zs 与 \ze 可以帮助我们对匹配进行裁剪

" 转义问题字符(含有'/' '\' '?')
" 正向查找时要转义 / 字符( 每次都要转义符号 \ )
nnoremap <silent> <leader>\ /\V<C-r>=escape(@", getcmdtype().'/\')
" 反向查找时要转义?号( 每次都要转义符号 \ )
nnoremap <silent> <leader>? ?\V<C-r>=escape(@", getcmdtype().'?\')

" 显示匹配的括号,()[]{} (可用%跳转，默认不包括<>)
set showmatch     
" 指定需要匹配的字符对(中英文所有的字符对)
set showmatch matchpairs=(:),[:],{:},<:>,（:）,【:】,｛:｝,《:》
" 添加软件包,在配对的关键字间跳转
packadd! matchit

" 设置自动补全的来源
set complete=.,w,b,u,t,i,d 
" 用于插入模式的补全,设置自动补全的选项
set completeopt=longest,menuone,noinsert,noselect
" 命令行补全选项设置
if has('patch-8.2.4500')
  " 使命令行补全支持弹出菜单和模糊匹配
  set wildoptions+=pum,fuzzy
  " 表示先显示最长匹配项，再显示所有匹配项
  set wildmode=longest,full
  " 用于映射 <cr>（回车）和 <esc>（退出）键，当弹出菜单可见时执行相应操作
  " 动态补全撤销<C-e>  确认<C-y>
endif

" nobackup 关闭备份 backup
set nobackup      

"默认自动换行 set nowrap
set wrap

" 关闭 Vim 的备份文件功能
set nowb
" 示关闭 Vim 的自动保存功能
set noaw          
"swapfile noswapfile 不使用swp文件，注意，错误退出后无法恢复
set noswapfile    

" 用于控制不可见字符的显示
" set list
" tab:.：将制表符显示为 .;trail:-：将行尾的空白字符显示为 -; eol:$：将行尾符显示为 $。 space:.：将普通空格显示为 .
set listchars=space:.,tab:..,trail:-,eol:$
" SpecialKey 高亮组主要用于高亮显示特殊键字符，像不可见字符（如空格、制表符等）
highlight SpecialKey guifg=#808080

"换行,折行 set lbr 在breakat字符处而不是最后一个字符处断行, 应该把默认的breakat中去掉空格
set nolbr

"解决显示汉字半个字符的问题(要关闭,各种UI的外框都是由———组成的，开启后会类似于破折号,UI框图会错误显示)
" set ambiwidth=double 

"在所有模式下都允许使用鼠标，还可以是n,v,i,c等
set mouse=a
" 允许鼠标右键弹出菜单
set mousemodel=popup    

"Vim默认最多只能打开10个标签页
set tabpagemax=15 

" win系统剪贴板与无名寄存器同步 linux之中"+y复制到系统剪贴板
set clipboard+=unnamed  

" 设置 Vim 帮助文档所使用的语言
set helplang=cn

"h fo-table 正确地处理中文字符的折行和拼接行尾不要空格 set fo+=M,向 formatoptions 选项中添加新的标志，而不影响已有的标志
set formatoptions+=mM   
"不要自动加上注释,从 formatoptions 选项中移除指定的标志
set formatoptions-=cro  

"上下边界始终保留行数,当光标移动到距离屏幕顶部或底部只有 2 行时，Vim 会自动滚动屏幕，以确保光标上下至少各有 2 行可见内容
set scrolloff=2    

"命令行一开始不用中文，按Ctrl+<space>可切换
set noimc    

" useopen 表示优先使用已经打开的窗口来编辑该文件
" usetab 表示如果文件在其他标签页中打开，则切换到该标签页；
" newtab 表示如果以上两种情况都不满足，则在新标签页中打开文件
set switchbuf=useopen,usetab,newtab

" 置行与行之间的额外间距。设置为 1 表示在每行文本之间增加 1 个单位的间距
" 一般不超过2,否则airline的powerline字符会明显错位
set linespace=3

"用空格替代tab
set expandtab 
set smarttab
" 缩进空格数量
set shiftwidth=2
" tab转化为2个字符
set tabstop=2

" vim记住的历史操作的数量，默认的是20
set history=1000  
" 设置 Vim 的撤销级别数量
set undolevels=1000

" 不让vim发出讨厌的滴滴声和闪烁
set noeb vb t_vb=
if (g:isGUI)
	au GUIEnter * set vb t_vb=
endif

" 控制 Vim 显示消息的方式
set shortmess=tI

" 进入任何一个缓冲区时，Vim 的当前工作目录会自动切换到该文件所在的目录
" 排除 filetype 为 fugitive 的情况
autocmd BufEnter * if &filetype !=# 'fugitive' | :cd %:p:h | endif
autocmd BufEnter * if &filetype !=# 'fugitive' | :lcd %:p:h | endif
autocmd BufEnter * if &filetype !=# 'fugitive' | :syntax sync fromstart | endif
" 文件写入后，若 filetype 不为 fugitive，将当前工作目录切换到文件所在目录
autocmd BufWritePost * if &filetype !=# 'fugitive' | :lcd %:p:h | endif

"打开文件 光标定位到上次编辑的地方
if has("autocmd")
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
endif

" 恢复上次文件打开位置
"set viminfo='10,\"100,:20,%,n~/.viminfo
set viminfo='10,\"100,:20,%,n$VIMRUNTIME/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif


"继续搜索光标下文字
nmap <leader>/ /<C-R>=expand("<cWORD>")<CR>
"vmap <Leader>/ "ry/<C-R>r 原来的没有处理回车
vmap <leader>/ "ry/<c-r>=substitute(escape('<c-r>r', '\^$~/.[]'),'\r','\\n','ge')<CR>

"选中后进行查找替换
" substitute 命令 
nmap <Leader>r :%s/<C-R>=expand("<cWORD>")<CR>
vmap <Leader>r "ry:%s/<c-r>=substitute(escape('<c-r>r', '\^$~/.[]'),'\r','\\n','ge')<CR>

" global命令
nmap <Leader>g :g/<C-R>=expand("<cWORD>")<CR>/d
vmap <Leader>g "ry:g/<c-r>=substitute(escape('<c-r>r', '\^$~/.[]'),'\r','\\n','ge')<CR>/d

" 快速删除当前文件中不包含当前选中内容的所有行
nmap <Leader>v :v/<C-R>=expand("<cWORD>")<CR>/d
vmap <Leader>v "ry:v/<c-r>=substitute(escape('<c-r>r', '\^$~/.[]'),'\r','\\n','ge')<CR>/d

"在搜索中只需要这个就够了
inoremap <M-/> <C-r>=substitute(@/,'\v^\\[<V]\|\\\>$','','g')<CR>


"先查询出来,不足是必须要保存为文件才行，但lv出来的可以跳转
nmap <Leader>c :exec 'lv /' . input('/', expand('<cword>')) . '/gj % <bar> lw'<CR>
vmap <Leader>c "ry:lv /<C-R>r/gj % <bar> lw<CR>
"然后再
"将当前文件的全部内容复制到一个新的标签页中，然后在新标签页里删除每行末尾的竖线 | 及其前面的所有内容
nmap <Leader>p ggVGy:exec 'tabnew'<CR>P:exec '%s/.*\|//g'<CR>



" 删除buffer时不关闭窗口
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
	let l:currentBufNum = bufnr("%")
	let l:alternateBufNum = bufnr("#")

	if buflisted(l:alternateBufNum)
		buffer #
	else
		bnext
		"bprevious
	endif

	if bufnr("%") == l:currentBufNum
		new
	endif

	if buflisted(l:currentBufNum)
		execute("bdelete! ".l:currentBufNum)
	endif
endfunction



" vim自带的补全
" 1.关键字补全（<C-n> 向下查找匹配的关键字和 <C-p>向上查找）
" 2.路径补全（<C-x><C-f>）在插入模式下，输入部分文件路径后，按下 <C-x><C-f> 可以触发路径补全。Vim 会根据当前目录下的文件和文件夹名称进行补全。
" 3.行补全（<C-x><C-l>）在插入模式下，按下 <C-x><C-l> 可以进行行补全。Vim 会查找当前文件中与你已输入内容匹配的整行文本并进行补全。
" 4.拼写建议补全（<C-x><C-k>）当你输入一个可能拼写错误的单词时，按下 <C-x><C-k>，Vim 会根据拼写字典提供可能的正确拼写建议。你需要先设置好拼写检查功能（set spell）。
" 5.标签补全（<C-x><C-]>）如果你使用 ctags 工具为项目生成了标签文件（通常是 tags 文件），在插入模式下输入部分标签名后按下 <C-x><C-]>，Vim 会根据标签文件进行补全。
" 6.vim命令补全（<C-x><C-v>）

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 快捷键 {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 保存<C-s>
" 退出
nnoremap <leader>q :q<CR>

" 快速移动
nnoremap <C-u> 10k
vnoremap <C-u> 10k
nnoremap <C-d> 10j
vnoremap <C-d> 10j

"翻页
map <C-j> <C-f>
map <C-k> <C-b>
imap <C-j> <C-o><PageDown>
imap <C-k> <C-o><PageUp>
vmap <C-j> <S-PageDown>
vmap <C-k> <S-PageUp>

",.符号相关
onoremap , iw
onoremap . aW
vnoremap , iw
vnoremap . aW
nnoremap ,, viw
nnoremap ,. vaW
"恢复上一次的选择
nnoremap <A-BS> `<v`>

" 映射 sh 组合键进行上下分屏
nnoremap <silent> sh :split<CR>
" 映射 sv 组合键进行左右分屏
nnoremap <silent> sv :vsplit<CR>
" 映射 sc 组合键关闭当前屏幕
nnoremap <silent> sc :close<CR>
" 映射 so 组合键关闭其他屏幕
nnoremap <silent> so :only<CR>

" 设置window分割线及边缘颜色
set fillchars+=vert:│
highlight VertSplit gui=NONE term=NONE guibg=NONE guifg=NONE ctermbg=NONE ctermfg=NONE

" 窗口跳转配置
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k

" 切换语法高亮开关
map <silent> <leader>ss :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>

"当前窗口随着其它的窗口(同样置位此选项的窗口)一起滚动( 多个窗口都开启了 scrollbind 状态后 )
"set scb(scrollbind 同步滚屏滚动)
map <silent> <leader>sb :set scb! scb?<CR>

" visual模式下,上下移动选中文本
vnoremap J :move '>+1<CR>gv-gv
vnoremap K :move '<-2<CR>gv-gv
" visual模式下防止行水平滑动的时候失去选择,选中部分的单独左右移动由 vim-peekaboo 插件提供
xnoremap <  <gv
xnoremap >  >gv

" 可以跨行（用gj、gk）也可以
noremap j gj
noremap k gk

" 历史命令
cnoremap <c-n> <down>
cnoremap <c-p> <up>

" insert和command模式下,<C-w>删除至上个单词的开头,<C-u>删除至上个单词的行首
inoremap <C-d> <C-w>

" 输入状态下移动
inoremap <Up> <C-o>k
inoremap <Down> <C-o>j
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o><right>
inoremap <C-b> <C-o>b
inoremap <C-w> <C-o>w

" 将 Ctrl + F1 组合键映射为一系列操作
imap <C-F1> <c-o>:reg<cr>
noremap <C-F1> :reg<cr>

"重复执行上一次的命令
noremap <Leader>, @:
" 执行存储在 q 寄存器中的宏
noremap <Leader>. @q

"复制当前行不带回车(V复制当前行后p粘贴会粘贴到下一行)
noremap <Leader>Y 0y$
"复制全文并不移动光标
noremap <Leader>G :%y<cr>
"上下两行互换
noremap <Leader>D ddpj

" 在文件名上按,gt时，在新的tab中打开
nmap <leader>gt :tabnew <cfile><cr>
nmap <leader>gf :tabe <c-r>=getline('.')<CR><CR>
nmap gf :tabe <c-r>=getline('.')<CR><CR>
vmap gf y:tabe "<CR>
noremap gz :!start <C-R>=eval("g:COMMANDER_EXE")<CR> /A /T /O /S /L="<c-r>=getline('.')<CR>"<CR><CR>
vmap gz y:!start <C-R>=eval("g:COMMANDER_EXE")<CR> /A /T /O /S /L="""<CR><CR>

" 动态地添加或移除 colorcolumn（颜色列）
function! SetColorColumn()
	let col_num = virtcol(".")
	let cc_list = split(&cc, ',')
	if count(cc_list, string(col_num)) <= 0
		execute "set cc+=".col_num
	else
		execute "set cc-=".col_num
	endif
endfunction
map <silent> <leader>ch :call SetColorColumn()<CR>

"编码相关 
map <silent> <leader>ffd :set ff=dos<cr>
map <silent> <leader>ffu :set ff=unix<cr>
map <silent> <leader>fcc :set fenc=cp936<cr>
map <silent> <leader>fcu :set fenc=utf-8<cr>

"高亮相关filetype
map <silent> <leader>ftk :set ft=<cr>
map <silent> <leader>ftt :set ft=txt<cr>
map <silent> <leader>fth :set ft=html<cr>
map <silent> <leader>ftp :set ft=python<cr>
map <silent> <leader>ftj :set ft=javascript<cr>
map <silent> <leader>fta :set ft=autohotkey<cr>

"Switch to current dir
map <leader>cd :cd %:p:h<cr>
map <silent> <M-d> :cd %:p:h<cr>

" 行设置
"将所有行都空一行
nmap <silent> <leader>vk :%s/\(\s*\n\)\+/\r\r/<cr>:noh<cr>
vmap <silent> <leader>vk :s/\(\s*\n\)\+/\r\r/<cr>:noh<cr>

"remove blink lines 去掉多余的空行
nmap <silent> <leader>vr :%g/^\s*$/d<cr>:noh<cr>
vmap <silent> <leader>vr :g/^\s*$/d<cr>:noh<cr>

"more blink lines to one line 多余的空行换成一行(要选中空行)
nmap <silent> <leader>vR :%s/\(^\s*\n\)\{2,}/\r/<cr>:noh<cr>
vmap <silent> <leader>vR :s/\(^\s*\n\)\{2,}/\r/<cr>:noh<cr>

"zap duplicate lines to one line 去掉重复行
nmap <silent> <leader>vd :%s/^\(.*\)\(\n\1\)\+$/\1/<cr>:noh<cr>
vmap <silent> <leader>vd :s/^\(.*\)\(\n\1\)\+$/\1/<cr>:noh<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 输入法相关(status栏显示） {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"默认在非中文状态
" 用于控制在插入模式下输入法的初始状态。iminsert = 0 表示在进入插入模式时，输入法默认处于英文输入状态
set iminsert=0
" 控制在搜索模式下输入法的状态。imsearch = 2 通常意味着在搜索时，输入法保持上次搜索结束时的状态。
set imsearch=2
"在输入模式中自动切换,当退出插入模式时，将输入法状态设置为英文输入状态
autocmd InsertLeave  * :set iminsert=0
" 当进入插入模式时,输入法状态设置为保持上次插入结束时的状态
autocmd InsertEnter  * :set iminsert=2
" 在插入模式下文本发生变化时触发该命令,输入法状态设置为保持上次插入结束时的状态
autocmd InsertChange * :set iminsert=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 文件类型相关 {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown {{{2
" Markdown 文件中的代码块和链接设置成特定的颜色显示
" highlight mkdCode guibg=#666666 guifg=#33CC33 guisp=#839496
" highlight mkdURL guibg=#778899 guifg=#073642 guisp=#839496

" 当打开或创建 Markdown 文件（扩展名为 .md）时，会调用 InitMarkdownShortcut() 函数。
autocmd BufRead,BufNewFile *.md call InitMarkdownShortcut()
function! InitMarkdownShortcut()
noremap <buffer> ]1 <esc>I# <esc>
noremap <buffer> ]2 <esc>I## <esc>
noremap <buffer> ]3 <esc>I### <esc>
noremap <buffer> ]4 <esc>I#### <esc>
noremap <buffer> ]5 <esc>I##### <esc>
inoremap <buffer> ]1 <esc>I# <esc>
inoremap <buffer> ]2 <esc>I## <esc>
inoremap <buffer> ]3 <esc>I### <esc>
inoremap <buffer> ]4 <esc>I#### <esc>
inoremap <buffer> ]5 <esc>I##### <esc>
endfunction

" ini文件（折叠） {{{2
" 如果当前行的第一个字符不是 [，则认为这一行是可折叠的。
autocmd FileType dosini setl foldexpr=getline(v:lnum)[0]!=\"\[\"
" expr 表示使用自定义的折叠表达式（即前面设置的 foldexpr）来决定如何折叠代码
autocmd FileType dosini setl fdm=expr
" 表示初始时所有折叠都是关闭的
autocmd FileType dosini setl fdl=0

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 折叠相关 {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"foldmethod(fdm)的方式，有 indent,syntax等语法
" manual  手工定义折叠
" indent  更多的缩进表示更高级别的折叠
" expr    用表达式来定义折叠
" syntax  用语法高亮来定义折叠
" diff    对没有更改的文本进行折叠
" marker  对文中的标志折叠

set noai          " autoindent 自动缩进
set nosi          " no smartindent 智能缩进
set nocindent     " cindent C/C++风格缩进

" 允许下方显示目录,在系统支持 wildmenu 特性启用文本模式的菜单
set wildmenu      

"fdc行前显示多长折叠符号
set foldcolumn=5 
"折叠到第几层，默认为0
set fdl=5        
" 开启 Vim 的折叠功能
set fen           

" 开启了 Vim 的折叠功能
set foldenable
" 控制当前的折叠级别,foldlevel = 0 意味着所有的折叠区域都会被关闭
set foldlevel=0
" 规定了一个区域要成为可折叠区域所需的最少行数,设置为 0 时，表示即使只有一行内容也可以被折叠
set foldminlines=0

" 针对 Vim 脚本文件设置折叠和缩进
augroup vimscript_folding
  autocmd!
  " 设置文件类型为 vim 时的折叠方式为 marker
  autocmd FileType vim set foldmethod=marker
  " 自定义折叠标记（默认是 {{{ 和 }}}，此处显式声明）
  autocmd FileType vim set foldmarker={{{,}}}
augroup END

" 折叠模式设置映射
map <silent> <leader>fdm :set fdm=marker<cr>
map <silent> <leader>fdi :set fdm=indent<cr>
map <silent> <leader>fds :set fdm=syntax<cr>
nmap [1 <esc>$a {{{1<esc>
nmap [2 <esc>$a {{{2<esc>
nmap [3 <esc>$a {{{3<esc>
nmap [4 <esc>$a {{{4<esc>
nmap [5 <esc>$a {{{5<esc>
nmap [6 <esc>$a {{{6<esc>
nmap [7 <esc>$a {{{7<esc>
nmap [8 <esc>$a {{{8<esc>
nmap [9 <esc>$a {{{9<esc>
" 删除最后的word—{{{数字
nmap [0 <esc>$F d$
imap [1 <esc>$a {{{1<esc>
imap [2 <esc>$a {{{2<esc>
imap [3 <esc>$a {{{3<esc>
imap [4 <esc>$a {{{4<esc>
imap [5 <esc>$a {{{5<esc>
imap [6 <esc>$a {{{6<esc>
imap [7 <esc>$a {{{7<esc>
imap [8 <esc>$a {{{8<esc>
imap [9 <esc>$a {{{9<esc>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"行合并 {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" JoinLine多行内容合并，分隔符引号
" 将指定范围内的多行内容合并为一行，并使用指定的分隔符和引号
function! JoinLine(line1, line2, ljfyh)
    " 引号
    let yh = ""
    let ljf = ","
    if strlen(a:ljfyh) == 0
        let ljf = ";"
    elseif strlen(a:ljfyh) == 1
        let ljf = a:ljfyh
        if ljf == "t"
            let ljf = "\t"
        elseif ljf == "&"
            let ljf = "\\&"
        endif
    else
        let ljf = strpart(a:ljfyh, 0, 1)
        let yh = strpart(a:ljfyh, 1)
    endif

    " 保存当前行
    let saved_line = getline(a:line1, a:line2)
    " 合并行
    let joined = join(map(saved_line, 'trim(v:val)'), ljf)
    " 添加引号
    if strlen(yh) > 0
        let joined = substitute(joined, '\v([^' . escape(ljf, '[]') . ']+)', yh . '\1' . yh, 'g')
    endif
    " 替换当前行
    call setline(a:line1, joined)
    " 删除多余行
    if a:line2 > a:line1
        call deletebufline(bufnr('%'), a:line1 + 1, a:line2)
    endif
endfunction

"-range=% 可以按照行号，-nargs=?可以变化参数，silent! exe可以不记录历史
":JL t 合并为tab分隔，适合到excel
command! -range=% -nargs=? JL call JoinLine(<line1>,<line2>,<f-args>)
nnoremap <Leader>j, :JL ,<cr>
vnoremap <Leader>j, :JL ,<cr>
nnoremap <Leader>j" :JL ,"<cr>
vnoremap <Leader>j" :JL ,"<cr>
nnoremap <Leader>j' :JL ,'<cr>
vnoremap <Leader>j' :JL ,'<cr>
nnoremap <Leader>j+ :JL +<cr>
vnoremap <Leader>j+ :JL +<cr>
nnoremap <Leader>jt :JL t<cr>
vnoremap <Leader>jt :JL t<cr>
nnoremap <Leader>j& :JL &<cr>
vnoremap <Leader>j& :JL &<cr>

"合并行尾(合并后不加空格)
nmap <leader>vj :%s#\n#<cr>
vmap <leader>vj :s#\n#<cr>

" M：在拼接两行时（重新格式化或者是手工使用J命令），如果前一行的结尾或后一行的开头是多字节字符，则不插入空格，适合中文
map <silent> <leader>sj :exec match(&formatoptions,'\CM$')>0 ? 'set fo-=M' : 'set fo+=M'<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 缩写(abbreviations) {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab idate <c-r>=strftime("%Y-%m-%d")<CR>
iab itime <c-r>=strftime("%H:%M")<CR>
iab ifile <c-r>=expand("%:t")<CR>
iab ipath <c-r>=expand("%:p:h")<CR>
iab imail 2807476305@qq.com
imap <C-T><C-D> <c-r>=strftime("%Y-%m-%d")<CR>
imap <C-T><C-T> <c-r>=strftime("%H:%M:%S")<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"diff相关 {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"diff直接跳到对应的字符
" 跳转到前一个差异文本的位置
function! Jump2PrevDiffText()
	let line=line(".")
	let idx=col(".")-1
	if synIDattr(diff_hlID(line, idx), "name")=="DiffChange" || synIDattr(diff_hlID(line, idx), "name")=="DiffText"
		while idx>0
			if synIDattr(diff_hlID(line, idx), "name")=="DiffText" && synIDattr(diff_hlID(line, idx-1), "name")!="DiffText"
				call setpos(".", [0,line,idx])
				break
			elseif idx==1
				let line=line(".")
				let cols=col(".")
				exec "normal [c"
				if line==line(".") && cols==col(".")
					return
				elseif synIDattr(diff_hlID(".", 1), "name")=="DiffChange" || synIDattr(diff_hlID(".", 1), "name")=="DiffText"
					call setpos(".", [0,line("."),col("$")-1])
					call Jump2PrevDiffText()
				endif
				break
			else
				let idx = idx-1
			endif
		endwhile
	else
		let line=line(".")
		let cols=col(".")
		exec "normal [c"
		if line==line(".") && cols==col(".")
			return
		elseif synIDattr(diff_hlID(".", 1), "name")=="DiffChange" || synIDattr(diff_hlID(".", 1), "name")=="DiffText"
			call setpos(".", [0,line("."),col("$")-1])
			call Jump2PrevDiffText()
		endif
	endif
endfunction

" 跳转到下一个差异文本的位置
function! Jump2NextDiffText()
	if synIDattr(diff_hlID(".", col(".")), "name")=="DiffChange" || synIDattr(diff_hlID(".", col(".")), "name")=="DiffText"
		let line=line(".")
		let cols=col("$")-1
		let idx=col(".")+1
		while idx<=cols
			if synIDattr(diff_hlID(line, idx), "name")=="DiffText" && synIDattr(diff_hlID(line,idx-1), "name")!="DiffText"
				call setpos(".", [0,line,idx])
				"echo line.",".idx.",".cols
				break
			elseif idx==cols
				let line=line(".")
				let cols=col(".")
				exec "normal ]c"
				if line==line(".") && cols==col(".")
					return
				elseif synIDattr(diff_hlID(".", 1), "name")=="DiffChange" || synIDattr(diff_hlID(".", 1), "name")=="DiffText"
					"echoerr "inner"
					call Jump2NextDiffText()
				endif
				break
			else
				let idx = idx+1
			endif
		endwhile
	else
		let line=line(".")
		let cols=col(".")
		exec "normal ]c"
		if line==line(".") && cols==col(".")
			return
		elseif synIDattr(diff_hlID(".", 1), "name")=="DiffChange" || synIDattr(diff_hlID(".", 1), "name")=="DiffText"
			call Jump2NextDiffText()
		endif
	endif
endfunction

" 将 tv 命令映射为垂直分割窗口并打开剪贴板中的内容进行 diff 比较
map tv :vert diffsplit <C-R>+<CR>

" 启用 diff 模式（:diffthis）
map td :diffthis<cr>

function! SetupDiffMappings()
	if &diff
		"比较相关
    " 获取另一个文件的差异内容（:diffget）
    map tg :diffget<cr>
    " 推送当前文件的差异内容到另一个文件（:diffput）
    map tp :diffput<cr>
    " 刷新 diff 显示（:diffupdate）
    map tu :diffupdate<cr>
    " 调用 Jump2PrevDiffText() 函数，跳转到上一个差异文本
    map tm :call Jump2PrevDiffText()<cr>
    " 调用 Jump2NextDiffText() 函数，跳转到下一个差异文本
    map tn :call Jump2NextDiffText()<cr>
    " 跳转到下一个差异块（]c）
    map tj ]c
    " 跳转到上一个差异块（[c）
    map tk [c
	endif
endfunction
"每次打开diff模式需要重新执行定义按键
autocmd BufEnter * if &diff | call SetupDiffMappings() | endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 统计相关 {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 统计相关配置
" 1. 统计当前字符之前的所有字节数
command! -nargs=0 CountBytesBack :normal mxvgg"ay`x:echo strlen(@a)<CR>

" 2. 统计当前字符之后的所有字节数
command! -nargs=0 CountBytesForward :normal mxv$G"ay`x:echo strlen(@a)<CR>

" 3. 统计当前文件所有字节数
command! -nargs=0 CountBytesAll :normal mxggVG"ay`x:echo strlen(@a)<CR>

" 4. 统计当前文件所有字符数
command! -nargs=0 CountCharsAll :%s/./&/gn|noh

" 5. 统计当前文件所有单词数
command! -nargs=0 CountWordsAll :%s/\i\+/&/gn|noh

" 6. 映射快捷键统计选中文本
nmap <leader>gc g<C-g>

" 其他统计命令示例
" :%s/./&/gn		字符数
" :%s/\i\+/&/gn		单词数
" :%s/^//n		行数
" :%s/the/&/gn		任何地方出现的 "the"
" :%s/\<the\>/&/gn	作为单词出现的 "the"



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Session {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 定义一个名为 Session 的函数，用于处理会话的保存和加载
function! Session(...)
    if a:0 == 0
        return
    endif

" 设置会话文件路径
    if g:isWin == 1
        let spath = $VIMRUNTIME . g:slash . "session"
    else
        let spath = $HOME . "/.vim/session"
    endif

    let method = a:1
    if method == "SAVE"
        let useage = "SessionSave, path error, try again . Useage: SS or SS name or SS filename"
    elseif method == "LOAD"
        let useage = "SessionLoad, path error, try again . Useage: SL or SL name or SL filename"
    endif

    "z:\a bc\c中文 ba\aaa.vim
    "ss abc.vim
    "z:\aaa.vim
    "SS z:\ AK
    "SS z:\aa AK\s
    "SS z:\aaAK\s
    "SS z:\aaAK\s.vim
    "SS z:\aaAK\s\yu\kk.vim
    "SS z:\aaAK\s\yu\k k.vim
    "SS z:\Internet 临时文件\yu\kk.vim
    "SS z:\aaAK\s\y 中 u\k k.vim

" 处理会话文件名
    if a:0 == 1
        let sname = spath . g:slash . "-.vim"
    elseif a:0 == 2
        if g:isWin == 1
            if match(a:2,'\.vim$') == -1
                let sname = a:2 . ".vim"
            else
                let sname = a:2
            endif
            if match(sname,'^\S\:\\[^\\]\+\.vim$') > -1
            elseif match(sname,'^\S\:\\\([^\\]\+\\\)\+[^\\]\+\.vim$') > -1
                let spath = matchlist(sname,'\(^\S\:\\\([^\\]\+\\\)\+\)[^\\]\+\.vim$')[1]
                let spath = strpart(spath , 0 , strlen(spath)-1)
            else
                let sname = spath . g:slash . sname
            endif
        else
            if match(a:2,'^[\/,~].\+\.vim$') > -1
                let sname = a:2
                let spath = matchlist(a:2,'\(^[\/,~].\+\)\(\/.\+\.vim$\)')[1]
            elseif match(a:2,'\/') > -1
                echo useage
                return
            else
                let sname = spath . g:slash . a:2 . ".vim"
            endif
        endif
    else
        echo useage
        return
    endif

" 保存会话
    if method == "SAVE"
        if (!isdirectory(spath))
            call mkdir(spath,"p") "创建中文目录会有问题
        endif
        execute "mksession! ".sname
        execute "wviminfo! ".sname."info"
        execute "echo \"Session Save Success\: ".escape(sname,g:slash)."\""

" 加载会话
    elseif method == "LOAD"
        execute "source ".sname
        execute "rviminfo! ".sname."info"
        "如果加上这个提示，会要多按一个回车
        "execute "echo \"Session Load Success\: ".escape(sname,g:slash)."\""
    endif
endfunction

" 调用 Session 函数保存会话
command! -nargs=? SS call Session("SAVE",<f-args>)
" 调用 Session 函数加载会话
command! -nargs=? SL call Session("LOAD",<f-args>)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 打开文件相关 {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <silent> <leader>ez :tabe d:\02_LearningResources\1_Software\Regular Expression\Regular Expression.md<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 笔记 {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 模式(mode) {{{2
"
" 操作符待决模式（Operator-Pending mode） {{{3

" 插入-普通模式(<C-o>) {{{3


" 插入模式 {{{3
" <C-r>{register}   不离开插入模式，粘贴寄存器中的文本
" 表达式寄存器(=)做一些运算
" Vim 可以用字符编码（Character Code）插入任意字符。使用此功能可以很方便地输入键盘上找不到的符号
" 如果你想知道文档中任意字符的编码，只需把光标移到它上面并按 ga 命令,如果想知道文档中不存在的字符的编码，该命令就无能为力了。在这种情况下，你或许得去查一下 unicode 表
" 插入模式中输入 <C-v>{code}   <C-v>映射为<C-q>
" 插入一个编码超过 3 位数的字符,可以用 4 位十六进制编码来输入这些字符，即输入 <C-v>u{code}
" 如果 <C-v>(<C-q>) 命令后面跟一个非数字键，它会插入这个按键本身所代表的字符
" 用 :h digraph-table查看列表(二和字母 不同进制)

" 可视模式 {{{3
" v      激活面向字符的可视模式
" V      激活面向行的可视模式
" <C-v>  激活面向列块的可视模式
" gv     重选上次的高亮选区
" o        切换高亮选区的活动端

" 命令模式(★★★★★) {{{3

" 用行号作为地址  符号 % 也有特殊含义，它代表当前文件中的所有行
"   符号   地址
"   1      文件的第一行
"   $      文件的最后一行
"   0      虚拟行，位于文件第一行上方
"   .      光标所在行
"   'm     包含位置标记 m 的行
"   '<     高亮选区的起始行
"   '>     高亮选区的结束行
"   %      整个文件（:1,$ 的简写形式）

" 使用‘:t’和‘:m’命令复制和移动行
" :copy 命令（及其简写形式 :t）  :t不会使用寄存器

" 命令       用途
" :6t.       把第 6 行复制到当前行下方
" :t6        把当前行复制到第 6 行下方
" :t.        为当前行创建一个副本（类似于普通模式下的 yyp）
" :t$        把当前行复制到文本结尾
" :'<,'>t0   把高亮选中的行复制到文件开

" 用 ‘:m’ 命令移动行

" 在指定范围上执行普通模式命令(:normal)
" 可以执行.命令和宏命令

" 把当前单词插入到命令行
" 在 Vim 的命令行下， <C-r><C-w> 映射项会复制光标下的单词并把它插入到命 令行中
" <C-r><C-a>插入光标下的字串
" 
" 回溯历史命令
" 把历史 中的两条记录合并成一条;  输入 q:，先结识一下命令行窗口_参见 :h cmdwin
" 命令行窗口的好处在于它允许我们使用 Vim 完整的、区分模式的编辑能力来修 改历史命令。我们可以用任何习以为常的动作命令进行移动，也可以在高亮选区上操 作，或是切换到插入模式中。我们甚至还能对命令行窗口中的内容执行 Ex 命令。
" 当处于命令行模式下时，我们可以用 <C-f> 映射项切换 到命令行窗口,此前已经输入到命令行上的内容仍然会得以保留中
"命令       动作
"q/         打开查找命令历史的命令行窗口
"q:         打开 Ex 命令历史的命令行窗口
"<Ctrl-f>   从命令行模式切换到命令行窗口

" 运行 Shell 命令
" 在 Vim 的命令行模式中，给命令加一个叹号前缀（参见 :h :! ）就可以调用 外部程序

" 选择模式(很少用mswin) {{{3
" 按 <C-g> 可以在可视模式及选择模式间切换
" 有一处地方会用到选择模式。有一个模拟 TextMate 的 snippet 功能的插件，它会用选择模式来高亮当前的占位符

" 模式(patterns) {{{2
" 替换 {{{3
 " substitute 命令
" substitute 命令允许先查找一段文本，再用另一段文本将其替换掉
" :[range]s[ubstitute]/{pattern}/{string}/[flags]
" 利用标志位调整 substitute 命令的行为   :h s_flags
" 标志位 g 使得 subsititute 命令可在全局范围内执行，即可以修改一行内的所有匹配，而不仅仅是第一处匹配。
" 标志位 c 让我们有机会可以确认或拒绝每一处修改。
" 标志位 n 会抑制正常的替换行为，即让 Vim 不执行替换操作，而只是报告本次substitute 命令匹配的个数。
" 标志位 & 仅仅用于指示 Vim 重用上一次 substitute 命令所用过的标志位。
" ……
" 用寄存器的内容替换

" global命令 {{{3

" :[range] global[!] /{pattern}/ [cmd]


" 工具 {{{2
















