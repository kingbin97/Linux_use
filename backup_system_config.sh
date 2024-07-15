#!/bin/bash

# 备份基目录
BACKUP_BASE_DIR="/pub01/system_bak"

# 创建备份目录（如果不存在）
mkdir -p "$BACKUP_BASE_DIR"

# 获取当前日期和时间
DATE=$(date +'%Y-%m-%d_%H-%M-%S')

# 创建按日期命名的备份目录
BACKUP_DIR="$BACKUP_BASE_DIR/$DATE"
mkdir -p "$BACKUP_DIR"

# 定义需要备份的文件和目录
FILES_TO_BACKUP=(
    "/etc/passwd"
    "/etc/group"
    "/etc/shadow"
    "/etc/gshadow"
    "/etc/fstab"
    "/etc/hosts"
    "/etc/hostname"
    "/etc/network/interfaces"
    "/etc/netplan/"
    "/etc/ssh/"
    "/etc/sudoers"
    "/etc/crontab"
    "/var/spool/cron/crontabs/"
    "/etc/apache2/"
    "/etc/nginx/"
    "/etc/mysql/"
    "/etc/postgresql/"
    "/etc/systemd/"
    "/var/log/"
    "/var/lib/dpkg/"
    "/var/lib/rpm/"
    "/etc/apt/sources.list"
    "/etc/apt/sources.list.d/"
)

# 使用 rsync 备份文件和目录
for FILE in "${FILES_TO_BACKUP[@]}"; do
    rsync -aR "$FILE" "$BACKUP_DIR"
    echo "Backup completed: $FILE to $BACKUP_DIR"
done

# 删除超过90天的备份
find "$BACKUP_BASE_DIR" -type d -mtime +90 -exec rm -rf {} \;

# 输出清理结果
echo "Old backups deleted"

