# checkServer

## Description
- summary: a shell script to check whether the server is normal with its cpu or its memory, which will send emails to notify when it's not.
- license: MIT

<br />
<br />

## 1. Mutt

- This script has used **Mutt** server to send emails, so you must setup it first.
- **Mutt**: mutt is an email client for linux in terminal, which supports *POP* and *IMAP*.

<br />

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

<br />

#### Fedora/CentOS

##### more details in [http://www.wilf.cn/post/centos-mutt-msmtp-setup.html](http://www.wilf.cn/post/centos-mutt-msmtp-setup.html)


<br />
<br />

## 2. Crontab

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
# excute each hour to give special notification like 'cpu warning' or 'memory warning' when set "false"
0 * * * * sh /home/checkServer/checkServer.sh false
```