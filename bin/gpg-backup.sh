#!/usr/bin/env bash

BACKUP_PATH=/Volumes/GPG\ Backup

if [[ -d "$BACKUP_PATH" ]]; then
    cp -R ~/.gnupg "${BACKUP_PATH}/gnupg_$(date +%d-%m-%y)"
    cp -R ~/.dotfiles/gpg "${BACKUP_PATH}/gpg_$(date +%d-%m-%y)"
    cp -R ~/.dotfiles/.passwords.gpg "${BACKUP_PATH}/passwords_$(date +%d-%m-%y).gpg"
else 
    echo -e "\nBackup volume ${BACKUP_PATH}/ is missing!"
    echo -e "Please attach the volume and try again.\n"
fi