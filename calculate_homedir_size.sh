#!/bin/bash

# 输出文件
OUTPUT_FILE="/var/log/homedir_sizes.txt"
BASE_DIRS=("/home/students" "/home/teachers" "/home/corporator")

# 清空输出文件
> $OUTPUT_FILE

# 定义函数来计算并记录目录大小
function calculate_and_record_size() {
    local dir=$1
    if [ -d "$dir" ]; then
        local DIRSIZE=$(du -sh "$dir" | awk '{print $1}')
        echo "$dir: $DIRSIZE" >> $OUTPUT_FILE
    fi
}

# 遍历 BASE_DIRS 列表中的每个目录
for base_dir in "${BASE_DIRS[@]}"; do
    if [ -d "$base_dir" ]; then
        echo "Calculating sizes for $base_dir..." >> $OUTPUT_FILE
        for subdir in "$base_dir"/*; do
            calculate_and_record_size "$subdir"
        done
        echo "-----------------------------------" >> $OUTPUT_FILE
    fi
done

# 直接计算并记录 /home 下的特定目录的大小
for dir in "/home/biouser" "/home/dudu" "/home/fzhyjyy" "/home/linkinbin" "/home/test" "/home/tutu" "/home/www"; do
    calculate_and_record_size "$dir"
done

