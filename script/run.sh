#!/bin/bash
if [ ! -d "../bags/line_syn" ];then
    mkdir ../bags/line_syn
fi
if [ ! -d "../bags/line_pure_cloud" ];then
    mkdir ../bags/line_pure_cloud
fi
if [ ! -d "../bags/eight_syn" ];then
    mkdir ../bags/eight_syn
fi
if [ ! -d "../bags/eight_pure_cloud" ];then
    mkdir ../bags/eight_pure_cloud
fi
if [ ! -d "../bags/track_syn" ];then
    mkdir ../bags/track_syn
fi
if [ ! -d "../bags/track_pure_cloud" ];then
    mkdir ../bags/track_pure_cloud
fi
if [ ! -d "../bags/no_cloud" ];then
    mkdir ../bags/no_cloud
fi
if [ ! -d "../bags/broken" ];then
    mkdir ../bags/broken
fi

# 自动开启ros master与rviz，容易出bug，建议自己开两个终端
# roscore &
# rosrun rviz rviz -d rviz.rviz &

for file in ../bags/*
do {
    if [ ! -d ${file} ];then
        echo -e "playing ${file}, \npress ctrl-C to continue..."
        rosbag play -l ${file} 1> /dev/null 
        string=`rosbag info ${file} | grep "msgs    :"`
        if [[ "${string}" == *"PointCloud"* ]];then
            echo -e "${file} \n[line/eight/track/err]:  \c"
            read folder
            if [[ "${string}" == *"Float64MultiArray"* ]];then
                if [[ "${folder}" == "err" ]];then
                    mv ${file} ../bags/broken/
                    echo "moved to broken"
                else
                    mv ${file} ../bags/${folder}_syn/
                    echo "moved to ${folder}_syn"
                fi
            else
                if [[ "${folder}" == "err" ]];then
                    mv ${file} ../bags/broken/
                    echo "moved to broken"
                else
                    mv ${file} ../bags/${folder}_pure_cloud/
                    echo "moved to ${folder}_pure_cloud"
                fi
            fi
        else
            mv ${file} ../bags/no_cloud/
            echo "moved to no_cloud"
        fi

        echo -e "\n"
    fi
}
done
