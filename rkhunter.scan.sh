#!/bin/bash

# 获取当前主机名
HOSTNAME=$(hostname)

# 定义日志文件目录
LOG_DIR="/opt/sys_use/rkhunter"

# 创建日志文件目录（如果不存在）
mkdir -p "$LOG_DIR"

# 获取当前时间
CURRENT_TIME=$(date +"%Y%m%d%H%M%S")

# 定义日志文件路径
LOG_FILE="${LOG_DIR}/${HOSTNAME}_${CURRENT_TIME}.rkhunter.log"

# 执行rkhunter命令并将结果保存到日志文件中
/bin/rkhunter --skip-keypress --report-warnings-only --cronjob > "$LOG_FILE"

# 设置日志文件权限为644（所有者可读写，其他用户可读）
chmod 644 "$LOG_FILE"

# 输出日志文件位置
echo "Rkhunter output saved to: $LOG_FILE"

# 保留近30天的log文件，超过30天的日志内容追加到主机名.total.log并删除源文件
find "$LOG_DIR" -type f -name "${HOSTNAME}_*.rkhunter.log" -mtime +30 -exec sh -c 'cat "$1" >> "${LOG_DIR}/${HOSTNAME}.total.log" && rm "$1"' _ {} \;
