#!/bin/bash

usermod -u $(USER_ID) -o -m $(USER)
groupmod -g $(GROUP_ID) $(USER)

top -b