#!/bin/sh

if [ ! -e "/var/local/db/security-manager" ]; then
	mkdir -p /var/local/db
	cp -ra /usr/dbspace/ /var/local/db/security-manager
fi
