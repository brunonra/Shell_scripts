#!/bin/bash

for srv in `cat LIST_OF_SERVERS`
do
        echo $srv
        ssh $srv "echo NEW_PASSWORD | passwd --stdin USER"