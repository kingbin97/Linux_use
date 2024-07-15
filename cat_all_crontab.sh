#!/bin/bash

# 获取主机名
hostname=$(hostname)

# 目标目录和文件名
target_dir="/opt/sys_use/cat_all_crontab"
target_file="${hostname}.cat_all_crontab.log"

# 确保目标目录存在
mkdir -p "$target_dir"

# 目标文件的完整路径
target_path="${target_dir}/${target_file}"

# 重定向输出到目标文件
{
    echo "System-wide crontab file:"
    cat /etc/crontab

    echo -e "\nSystem-wide cron jobs in /etc/cron.d:"
    for file in /etc/cron.d/*; do
        echo -e "\n$file:"
        cat "$file"
    done

    echo -e "\nUser-specific crontab files in /var/spool/cron:"
    for user in /var/spool/cron/*; do
        echo -e "\n$user:"
        cat "$user"
    done

    echo -e "\nHourly cron jobs:"
    ls /etc/cron.hourly

    echo -e "\nDaily cron jobs:"
    ls /etc/cron.daily

    echo -e "\nWeekly cron jobs:"
    ls /etc/cron.weekly

    echo -e "\nMonthly cron jobs:"
    ls /etc/cron.monthly
} > "$target_path"

echo "Crontab details saved to $target_path"
