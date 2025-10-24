#!/usr/bin/env bash

sudo apt install --no-install-recommends -y \
  git \
  ca-certificates \
  python3 \
  python3-pip \
  python3-venv

pip3 install --upgrade pip
python3 -m venv .venv
source .venv/bin/activate

pip install -r ./ansible/requirements.txt

ansible-playbook -i ./ansible/inventory ./ansible/site.yml --ask-become-pass
