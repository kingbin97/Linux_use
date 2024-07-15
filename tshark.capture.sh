#!/bin/bash

# 获取当前主机名
HOSTNAME=$(hostname)

# 定义日志文件目录
LOG_DIR="/opt/sys_use/tshark"

# 创建日志文件目录（如果不存在）
mkdir -p "$LOG_DIR"

# 获取开始时间
START_TIME=$(date +"%Y%m%d%H%M%S")

# 定义临时日志文件路径
TEMP_LOG_FILE="${LOG_DIR}/${HOSTNAME}.${START_TIME}.tshark.temp.log"

# 执行tshark命令并将结果保存到临时日志文件中
/sbin/tshark -i any -a duration:100 > "$TEMP_LOG_FILE" 2>&1

# 获取结束时间
END_TIME=$(date +"%Y%m%d%H%M%S")

# 定义最终日志文件路径
FINAL_LOG_FILE="${LOG_DIR}/${HOSTNAME}.${START_TIME}-${END_TIME}.tshark.log"

# 重命名临时日志文件为最终日志文件
mv "$TEMP_LOG_FILE" "$FINAL_LOG_FILE"

# 设置日志文件权限为644（所有者可读写，其他用户可读）
chmod 644 "$FINAL_LOG_FILE"

# 输出日志文件位置
echo "Tshark output saved to: $FINAL_LOG_FILE"

# 保留近30天的log文件，超过30天的日志内容追加到total.log并删除源文件
find "$LOG_DIR" -type f -name "*.tshark.log" -mtime +7 -exec sh -c 'cat "$1" >> "$LOG_DIR/${HOSTNAME}.total.log" && rm "$1"' _ {} \;
