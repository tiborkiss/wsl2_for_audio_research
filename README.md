## Overview
This folder holds setup scripts and utilities for setting up Ubuntu-20.04-LTS 
using WSL2 dedicated for audio research.

For audio research most likely we need audio. 

Since WSLg, the audio subsystem is integrated using a pulseaudio server running
in the WSL System Distro and the User Distro can access without any further configuration.
Older version of WSL2, requires manually installing a pulseaudio server and
within the `.bashrc` has to be added a configuration in order to bind the audio.
This script also handles the older version of WSL2 environments and depending
on the Windows build number, adds a pulseaudio server pre-configured or skips.  

## The setup procedure
The WSL2 environment is hosted in Windows 10 and it is assumed that it is already installed.

For the installation phase, we must use Windows PowerShell script. 
```
setup-wsl2.ps1
```

If we have to call from a batch script, we need to call
 `Powershell.exe -executionpolicy remotesigned -File .\setup-wsl2.ps1`.

The setup procedure does the following:
 - pull down a fresh official Ubuntu-20.04 LTS image optimized for WSL2 environment.
 - register the downloaded image into WSL2, using the name `MusicAI`.
 - creates a user called `ai` into the running `MusicAI` instance
 - make it `ai` user will be the default user in `MusicAI` instance.
 - If WSL2 does not contains WSLg, then creates the audio routing setup
   between `MusicAI` instance and Windows host. 
   For that reason just adds a few lines to `~/.bashrc`.

## Using the installed softwares

```
run_wsl2.bat
```

The resulting WSL2 instance then it can be used as it would be a native Ubuntu-20.04 LTS.
