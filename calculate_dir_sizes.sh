#!/bin/bash

# 要统计的目录
BASE_DIR_MJU="/pub2/mju"
BASE_DIR_PROJECT="/pub/project"
OUTPUT_FILE="/var/log/dir_sizes.txt"

# 清空输出文件
> $OUTPUT_FILE

echo "Calculating sizes for $BASE_DIR_MJU..." >> $OUTPUT_FILE
# 遍历 BASE_DIR_MJU 下的每个次级目录
for group_dir in "$BASE_DIR_MJU"/*; do
    if [ -d "$group_dir" ]; then
        GROUP=$(basename "$group_dir")
        TOTAL_SIZE=0

        # 遍历次级目录中的每个用户目录
        for user_dir in "$group_dir"/*; do
            if [ -d "$user_dir" ]; then
                USER=$(basename "$user_dir")
                USER_SIZE=$(du -sk "$user_dir" | awk '{print $1}')
                TOTAL_SIZE=$((TOTAL_SIZE + USER_SIZE))

                # 记录单个用户目录的大小
                echo "$USER: $(du -sh "$user_dir" | awk '{print $1}')" >> $OUTPUT_FILE
            fi
        done

        # 将次级目录中所有用户目录的总大小记录到输出文件
        echo "$GROUP total size: $(numfmt --to=iec --suffix=B $((TOTAL_SIZE * 1024)))" >> $OUTPUT_FILE
        echo "-----------------------------------" >> $OUTPUT_FILE
    fi
done

echo "Calculating sizes for $BASE_DIR_PROJECT..." >> $OUTPUT_FILE
# 遍历 BASE_DIR_PROJECT 下的每个目录
for project_dir in "$BASE_DIR_PROJECT"/*; do
    if [ -d "$project_dir" ]; then
        PROJECT=$(basename "$project_dir")
        PROJECT_SIZE=$(du -sh "$project_dir" | awk '{print $1}')
        
        # 记录项目目录的大小
        echo "$PROJECT: $PROJECT_SIZE" >> $OUTPUT_FILE
    fi
done

