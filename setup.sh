#!/bin/sh

chmod -R go= ./keys
ssh-keygen -R 192.168.99.99
ssh-keygen -R 192.168.99.98
