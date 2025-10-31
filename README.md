# _vimrc

终端vim/neovim在类Unix和MacOs系统下有着非常优秀的表现，如果有足够的耐心和时间你可以通过不同的终端工具、vim/neovim插件和配置来打造属于自己的vim/neovim;即使你没有那么多的时间和精力,也有很多开箱即用的优秀配置可以直接通过命令行安装使用.   
但是Windows作为使用人数最多的操作系统，终端vim/neovim在其上的表现并没有类Unix和MacOs系统那么优秀，如果非要使用会带来很多不便,因此gvim(GUI vim)便成了Windows系统下的首选，比起neovide等neovim的GUI版本，gvim在兼容性、细节上的表现更好，可以最大程度还原终端vim的使用体验.  
因此这是一个windows下针对中文用户的gvim配置,纯粹的文本编辑器(可以自行扩展成IDE）,希望给你在windows上带来一个好的vim编辑体验.  

## 特点

+ _vimrc带有详细的中文配置说明参考   
+ 对插件功能的深度配置  
+ 对中文编辑更好的支持,包括内置vim英文文档替换为中文;解决英文、中文输入切换,中文搜索的问题
+ 提供了丰富的vim学习资料(help document),从基础入门到viml脚本编写


## 使用说明

+ 注意：如果需要开箱即用的vim,提供了release,release版本一般落后于仓库文件  
+ 在vim官网下载windows系统的vim，把仓库文件放在vim目录下  
+ 相同文件夹请把仓库文件夹和默认文件夹合并，相同文件替换为仓库文件  
+ 下载plug-vim放在autoload目录下,进入_virmc运行  :PlugInstall  
+ 个别插件需要python3,node.js等环境支持   

## 注意事项

仓库中的bundles文件夹中为自行修改后的插件,这几个自己修改的插件不要通过vim-plug更新
如果您不清楚文件/文件夹的功能,请参考各级目录下的descript.ion  
_vimrc中有些调用外部程序的配置,如果影响使用/报错请删除/注释掉  

## TODO

1. 提供Linux版的vim配置  
2. 在分支仓库对vim进行IDE配置,支持不同语言  
