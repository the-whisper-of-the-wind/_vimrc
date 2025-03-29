# _vimrc

适用于windows下的vim/gvim,纯粹的文本编辑器(可以自行扩展成IDE）

+ _vimrc带有详细的中文配置说明参考   
+ 对插件功能的深度配置  
+ 对中文编辑更好的支持,内置vim英文文档替换为中文  

## 使用

在vim官网下载windows的vim，把仓库文件放在vim下  
下载plug-vim放在autoload目录下,进入_virmc运行:PlugInstall  
相同文件夹请把仓库文件夹和默认文件夹合并，相同文件替换为仓库文件  
个别插件需要python,node.js等环境支持   

## 注意事项

bundles文件夹中为自行修改后的插件,不要通过vim-plug下载  
如果您不清楚文件/文件夹的功能，请参考各级目录下的descript.ion  

## TODO

主仓库为_vimrc单配置文件，计划在分支仓库按功能分成不同vim文件，提供统一的API以及使用文档
