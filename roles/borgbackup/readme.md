# Borgbackup Role

This role will install borgbackup and configure some helper scripts.

## Helper Scripts

The helper scripts with preconfigured backup paths and ssh key will be added to `/usr/local/sbin`.

Make sure to call the scripts as root or with sudo to avoid permission issues.

## borg-restore-latest

Ansible will also call `borg-restore-latest`.
This script will extract the last available backup if the backup target folder is empty.

## Cron Jobs

There will be cron jobs created, that call `borg-backup` and `borg-prune` nightly.
