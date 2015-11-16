# checkServer

## Description
- summary: a shell script to check whether the server is normal with its cpu or its memory, which will send emails to notify when it's not.
- license: MIT

<br />
<br />

## Mutt

- This script has used **mutt** server to send emails, so you must setup it first.

#### Ubuntu

##### Install Mutt

- The system name can be set any name as like as you are.

```bash
$ apt-get install mutt
```

##### Set Configuration

- set `.muttrc` in the `~` directory of root user.

```bash
$ sudo vim /root/.muttrc
```
or
```
$ sudo vim ~/.muttrc
```

```
# .mutttrc file
set envelope_from=yes
# the name of who sent the mail
set from=voicein@soundtooth.cn
# the real name of who send the mail
set realname="VoiceIn Website"
set use_from=yes
set rfc2047_parameters=yes
set charset="utf-8"
```

#### Fedora

```bash
$ yum -y install mutt
```