# _vimrc

适用于windows下的vim/gvim,纯粹的文本编辑器(可以自行扩展成IDE）

+ _vimrc带有详细的中文配置说明参考   
+ 对插件功能的深度配置  
+ 对中文编辑更好的支持,内置vim英文文档替换为中文  

希望给你在windows上带来一个好的vim编辑体验  

## 使用说明

+ 在vim官网下载windows的vim，把仓库文件放在vim目录下  
+ 相同文件夹请把仓库文件夹和默认文件夹合并，相同文件替换为仓库文件  
+ 下载plug-vim放在autoload目录下,进入_virmc运行:PlugInstall  
+ 个别插件需要python3,node.js等环境支持   
+ 如果需要开箱即用的vim,提供了realse,realse版本一般落后于仓库文件  

## 注意事项

bundles文件夹中为自行修改后的插件,不要通过vim-plug更新
如果您不清楚文件/文件夹的功能,请参考各级目录下的descript.ion  
_vimrc中有些调用外部程序的配置,如果影响使用/报错请删除/注释掉  

## TODO

1. 主仓库为_vimrc单配置文件,计划在分支仓库按功能分成不同vim文件，提供统一的API以及使用文档,使配置使用更容易  
2. 提供Linux版的vim配置  
3. 在分支仓库对vim进行IDE配置,支持不同语言  
