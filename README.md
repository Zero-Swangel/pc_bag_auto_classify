# 点云包半自动分类脚本
> 不太会写md，看的懂就好  
## 环境
- 大部分shell应该都可以，zsh和bash经测试没问题
- 若run.sh无法运行，使用 `sudo chmod +x ./script/run.sh` 添加运行权限

## 使用
> 将run.sh与rviz.rviz放在 `./script` 目录下  
新建 `./bags` 目录，将待分类点云包全扔进去  
```
roscore  
rosrun rviz rviz -d ./script/rviz.rviz   取消run.sh内的相应注释可跳过这两步，但可能会有bug

./script/run.sh
``` 
脚本会自动播放 `./bags` 目录下的点云包并在rviz内播放  
确定分类后按 `crtl-C` 结束rosbag命令，输入分类[line/eight/track/err]  

如果这个包不包含点云会自动分类到 `./bags/no_clouds` ，  
rviz无法正常播放且结束rosbag后没被自动分类，输入 `err` 以分类到 `./bags/broken`

