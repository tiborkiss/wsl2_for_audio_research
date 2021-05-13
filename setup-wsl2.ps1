$wlsAppxFile = "Ubuntu-20.04.appx"
$rootfsDir = "rootfs"
$wslDestDir = "WSL"
$rootfsArchive = "install.tar.gz"
$rootfsFull = "$rootfsDir\$rootfsArchive"
$wslName = "MusicAI"

if (!(Test-Path $rootfsDir)) {
    mkdir $rootfsDir
}
if (!(Test-Path $wlsAppxFile) -and !(Test-Path $rootfsFull)) {
    Write-Host "Downloading $wlsAppxFile from https://aka.ms/wslubuntu2004 ..."
    Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile $wlsAppxFile -UseBasicParsing
}

if ((Test-Path $wlsAppxFile) -and !(Test-Path $rootfsFull)) {
    Write-Host "Unpacking $rootfsArchive from $wlsAppxFile into $rootfsDir ..."
    .\7z\7za.exe e -r "$wlsAppxFile" "$rootfsArchive" -o"$rootfsDir" 
}

if (!(Test-Path $wslDestDir)) {
    mkdir $wslDestDir
}

Write-Host "Importing rootfs from $rootfsFull and register $wslName instance ..."
wsl --import $wslName "$wslDestDir\$wslName" $rootfsFull

# we cannot make sure that the .sh files below will always be commited from linux,
# the windows end of line character is always replaced during injecting in bash

Write-Host "Initial ubuntu user setup ..."
wsl -d $wslName bash -c -i "tr '\r\n' '\n' < initial-ubuntu-user.sh | bash"

# restart the instance in order to make default user active
Write-Host "Restarting $wslName instance ..."
wsl --shutdown $wslName

# Check to see if WSLg is not yet installed
if ([System.Environment]::OSVersion.Version.Build -lt 21376) {
    Write-Host "Configuring pulseaudio client in ~/.bashrc ..."
    wsl -d $wslName bash -c -i "tr '\r\n' '\n' < configure_pulseaudio.sh | bash"
    
    Write-Host "Restarting $wslName instance ..."
    wsl --shutdown $wslName
}

# from here is the area for user specific environment setup
wsl -d $wslName
