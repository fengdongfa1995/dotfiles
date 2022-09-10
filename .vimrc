" 自动安装插件管理器vim-plug
" 如果网络较好但下载速度较慢，可以考虑挂VPN后重新打开Vim
let need_to_install_plugins = 0
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  let need_to_install_plugins = 1
endif

" 列举需要安装的vim插件
call plug#begin()
Plug 'preservim/nerdtree'                           " 文件树
Plug 'jiangmiao/auto-pairs'                         " 自动闭合括号
Plug 'kien/rainbow_parentheses.vim'                 " 彩虹括号对
Plug 'mhinz/vim-startify'                           " 打开vim时显示最近打开文件
Plug 'preservim/nerdcommenter'                      " 快速注释代码
Plug 'SirVer/ultisnips'                             " 代码片段管理
Plug 'tomasr/molokai'                               " molokai配色方案
Plug 'tpope/vim-surround'                           " 处理标记对
Plug 'vim-airline/vim-airline'                      " 美化状态栏
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " 模糊补全查找文件

" 各种语言的支持型插件
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'lervag/vimtex'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' } 
call plug#end()

" 自动安装在上文当中罗列的各种插件
if need_to_install_plugins == 1
    echo "Installing plugins..."
    silent! PlugInstall
    echo "Done!"
    q
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 变更Vim自身提供的各种设置项                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                      " 关闭兼容模式

filetype plugin indent on             " 检测文本类型并以此控制缩进

set number                            " 显示行号
syntax on                             " 代码高亮

" 缩进相关设置
set autoindent                        " 自动缩进
set expandtab                         " 将<TAB>显示为空格
set tabstop=2                         " 一个<TAB>显示为2个空格
set shiftwidth=2                      " 缩进幅度
set softtabstop=2                     " 连续2个空格视为一个<TAB>

set backspace=2                       " 允许退格键删到上一行

" 配置vim自动生成的各种附属文件
set noswapfile                        " 取消swap文件
set nobackup                          " 取消备份文件
set noundofile                        " 取消undo文件

set wildmenu                          " 命令自动补全

" 搜索字符串相关设置
set hlsearch                          " 高亮搜索结果
set incsearch                         " 立即跳转至搜索结果处
set ignorecase                        " 大小写不敏感

" 状态栏相关设置
set laststatus=2                      " 总是显示状态栏   
set showcmd                           " 输入命令时显示

" 光标相关设置
set ruler                             " 显示光标位置 
set cursorline                        " 高亮光标所在行
set cursorcolumn                      " 高亮光标所在列

" 颜色主题相关设置，需安装对应主题
set background=dark                   " 黑色背景
colorscheme molokai                   " 使用molokai主题
set t_Co=256                          " 启用256色

" 代码折叠或折行相关设置
set nowrap                            " 禁止折行
set foldmethod=syntax                 " 基于语法折叠代码
set nofoldenable                      " 启动vim时关闭折叠代码

" 设置文件编码
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,gbk

" 文本编辑相关设置
set autoread                          " 文件被外部编辑器修改时发出提醒

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    插件NERDTree相关设置                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 按下Ctrl + e打开或关闭文件树
nnoremap <C-e> :NERDTreeToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    插件vimtex相关设置                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0          " 不直接显示编译错误信息
" WSL2可以直接运行windows二进制文件，将pdf查看软件设置为SumatraPDF
let g:vimtex_view_general_viewer='SumatraPDF.exe'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    插件python-mode相关设置                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:pymode_folding = 0              " 开启Python代码折叠

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    插件UltiSnips相关设置                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsJumpForwardTrigger='<tab>'     " 使用<TAB>跳转到下一处待填处
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'  " 使用<S-TAB>跳转到上一处

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"         插件rainbow_parentheses相关设置                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
" 永远打开彩虹括号对
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"            插件markdown-preview相关设置                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:mkdp_browser = 'msedge.exe'             " 将预览浏览器设置为Edge
let g:mkdp_refresh_slow = 1                   " 保存或退出插入模式时刷新
let g:mkdp_auto_start = 1                     " 进入markdown模式后自动预览
