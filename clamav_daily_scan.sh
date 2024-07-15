#!/bin/bash

# 定义要扫描的目录列表
DIRECTORIES=("/usr" "/etc" "/home" "/opt" "/var" "/tmp" "/root" "/bin" "/sbin" "/lib" "/lib64" "/usr/local" "/srv" "/boot" "/dev" "/proc" "/sys")

# 获取当前主机名
HOSTNAME=$(hostname)

# 定义日志文件目录
LOG_DIR="/opt/sys_use/clamav_daily_scan"

# 创建日志文件目录（如果不存在）
mkdir -p "$LOG_DIR"

# 获取当前日期
CURRENT_DATE=$(date +"%Y%m%d")

# 定义日志文件路径
LOG_FILE="${LOG_DIR}/${HOSTNAME}.${CURRENT_DATE}.clamav_daily_scan.log"

# 执行clamscan命令并将结果保存到日志文件中
/bin/clamscan -r -i --remove "${DIRECTORIES[@]}" --log="$LOG_FILE"

# 设置日志文件权限为644（所有者可读写，其他用户可读）
chmod 644 "$LOG_FILE"

# 输出日志文件位置
echo "Scan complete. Log file saved to: $LOG_FILE"
