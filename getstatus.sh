#!/bin/bash

status=$(cat status)

# Runs when machine was last reported being up.
if [[ $status -eq 1 ]]; then
	result=$(timeout 1 ping -c 1 192.168.1.43 | grep "received" | awk {'print $1'})
	# If true machine is still up.
	if [[ $result -eq 1 ]]; then
		echo "VM is up and running."
	# Machine is down.
	else
		echo "VM is down. Updating status..."
		$(echo 0 > status)
	fi
fi

if [[ $status = "0" ]]; then
        result=$(timeout 1 ping -c 1 192.168.1.43 | grep "received" | awk {'print $1'})
        # If true machine is still up.
        if [[ $result -eq 1 ]]; then
                echo "VM is up and running."
                $(echo 1 > status)
        # Machine is down.
        else
                echo "VM is down. Updating status..."
        fi
fi


