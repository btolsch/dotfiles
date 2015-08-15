#!/bin/bash
sudo bash -c ". /usr/lib/network/globals; . /usr/lib/network/wpa; wpa_supplicant_scan wlp3s0 3,5 | xargs cat | sort "
