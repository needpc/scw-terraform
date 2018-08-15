#!/bin/sh

# Init only if the stack is not initialized
if [ ! -d ".terraform" ]; then
    terraform init
fi

# Exec command
if [ -n $(echo -n $@ | wc -c) ]
then
    terraform $@
fi