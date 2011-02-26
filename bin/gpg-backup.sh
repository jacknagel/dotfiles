#!/usr/bin/env bash

BACKUP_PATH=/Volumes/GPG\ Backup

if [[ -d "$BACKUP_PATH" ]]; then
    cp -R ~/.gnupg "${BACKUP_PATH}/gnupg/gnupg_$(date +%d-%m-%y)"
    cp -R ~/.dotfiles/gpg "${BACKUP_PATH}/gpg/gpg_$(date +%d-%m-%y)"
    cp -R ~/.dotfiles/.passwords.gpg "${BACKUP_PATH}/passwords/passwords_$(date +%d-%m-%y).gpg"
    cp -$ ~/.ssh "${BACKUP_PATH}/ssh/ssh_$(date +%d-%m-%y)"
else 
    echo -e "\nBackup volume ${BACKUP_PATH}/ is missing!"
    echo -e "Please attach the volume and try again.\n"
fi
