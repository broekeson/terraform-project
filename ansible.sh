#!/bin/bash

ansible-playbook -i ansible/ips.ini --user=admin --private-key ~/Downloads/starlight.pem ansible/main.yaml