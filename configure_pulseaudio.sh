#!/bin/bash
# Only required for WSL2 without WSLg
tr '\r\n' '\n' < pulseaudio_client_template.txt >> /home/ai/.bashrc
