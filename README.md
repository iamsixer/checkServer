## checkServer

[![Pay](https://img.shields.io/badge/%24-free-%23a10000.svg)](#)  [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/soundtooth/checkServer/master/LICENSE)

**checkServer** a shell script to check whether the **Cpu** or **Memory** of a server is normal, which will send emails to notify when it's not. Before using it, you have to set up some tools before.

### 1. Mutt

- This script has used **Mutt** server to send emails, so you must setup it first.
- **Mutt**: mutt is an email client for linux in terminal, which supports *POP* and *IMAP*.

#### Ubuntu

##### Install Mutt

- The system name can be set any name as like as you are.

```bash
$ apt-get install mutt
```

##### Set Configuration

- set `.muttrc` in the `~` directory of root user.

```
# .mutttrc file
# sudo vi ~/.muttrc or /root/.muttrc
set envelope_from=yes
# the name of who sent the mail
set from=xxx@soundtooth.cn
# the real name of who send the mail
set realname="VoiceIn Website"
set use_from=yes
set rfc2047_parameters=yes
set charset="utf-8"
```

##### Send Emails
	
```bash
echo "Email Contents" | `which mutt` -s "Title" aleen42@vip.qq.com
```

#### Fedora/CentOS

##### more details in [http://www.wilf.cn/post/centos-mutt-msmtp-setup.html](http://www.wilf.cn/post/centos-mutt-msmtp-setup.html)

### 2. Crontab

- If you want to run the script at a fixed time, you can use **Crontab**.

#### Set tasks in crontab

```
# crontab -e
# if the terminal asks you to choose an editor, I recommend the third one, 'vim-baic'.
# Edit this file to introduce tasks to be run by cron.
# 
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
# 
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').# 
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
# 
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
# 
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
# 
# For more information see the manual pages of crontab(5) and cron(8)
# 
# m h  dom mon dow   command
# excute each 9pm every day to give general notification when set "true"
0 21 * * * sh /home/checkServer/checkServer.sh true
# excute each hour to give special notification like 'memory warning' when set "false"
0 * * * * sh /home/checkServer/checkServer.sh false
```

### 3. Shell

#### Parameters

- MAX_mem(%): the upper edge of physical memory warning.
- MAX_cpu(%): the upper edge of physical cpu warning.
- DELAY(s): update every [delay] seconds.
- COUNT: update [count] times.
- NORMAL_CHECK: to identify whether it's normal check each day.
- sh_command: point out where `sh` command is.
- top_command: point out where `top` command is.
- sar_command: point out where `sar` command is.
- iostat_command: point out where `iostat` command is.
- free_command: point out where `free` command is.

#### Methods

- checkServer(): generate system info and send emails to the specifical email address.

#### Extract Number

- get the row 3 and column 3 of `top` command:

	```bash
`free | sed -n "3, 1p" | awk '{print int($3)}'`
```

#### Attention

- sar command need to set `ENABLED` to be true in `/etc/default/sysstat`.

```
#
# Default settings for /etc/init.d/sysstat, /etc/cron.d/sysstat
# and /etc/cron.daily/sysstat files
#

# Should sadc collect system activity informations? Valid values
# are "true" and "false". Please do not put other values, they
# will be overwritten by debconf!
ENABLED="true"

# Additional options passed to sa1 by /etc/init.d/sysstat
# and /etc/cron.d/sysstat
# By default contains the `-S DISK' option responsible for
# generating disk statisitcs.
SA1_OPTIONS="-S DISK"

# Additional options passed to sa2 by /etc/cron.daily/sysstat.
SA2_OPTIONS=""
```
- if `ENABLED` is not true, you may get the following result when runing `sar`

```
root@xxx:/home/checkServer# sar
Cannot open /var/log/sysstat/sa16: No such file or directory
Please check if data collecting is enabled in /etc/default/sysstat
```

### 4. MySQL

This script also monitor the `mysql.log` whether there're some unexpected operations like **DELETE** and **DROP TABLE**. Before you run this script, you have to enable log of your MySQL by following the [tutorial](https://aleen42.gitbooks.io/personalwiki/content/qa/mysql_log.html). If there're some problems about `mysql.log`, you can check it on your server, or just check the email of operations item. `clearMySQLManually` is a shell script for cleanning `mysql.log` safely in manual.

### 5. How to use

#### Clone

```sh
git clone https://github.com/SoundTooth/checkServer.git
```

#### Check commands

```sh
mutt
```

```sh
sar
```

#### Excute

```sh
# options:
#	true: normal check
#	false: warning check
# email_addr: the email you want to receive infos of the server
sh ./checkServer/checkServer.sh <options: true> <email_addr: aleen42@vip.qq.com>
```

#### Check with crontab

```bash
# Normal Check at 9 pm.
0 21 * * * sh ~/checkServer/checkServer.sh true aleen42@vip.qq.com

# Clear MySQLLog automatically if there are not exceptions
0 21 * * * sh ~/checkServer/clearMySQLLog.sh

# Warning Check within each 10 minutes
*/10 * * * * sh ~/checkServer/checkServer.sh false aleen42@vip.qq.com
```

#### :fuelpump: How to contribute

Have an idea? Found a bug? See [how to contribute](https://aleen42.gitbooks.io/personalwiki/content/contribution.html).

#### :scroll: License

[MIT](https://aleen42.gitbooks.io/personalwiki/content/MIT.html) © aleen42
