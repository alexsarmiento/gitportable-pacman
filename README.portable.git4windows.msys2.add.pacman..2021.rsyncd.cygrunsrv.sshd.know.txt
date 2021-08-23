

Contents:

11.
download.. from.. https://github.com/git-for-windows/git/releases/tag/v2.32.0.windows.2
PortableGit-2.32.0.2-64-bit.7z.exe

31.
https://github.com/dgleba/gitportable-pacman.git
  pacman -Sy rsync
  pacman -Sy cygrunsrv

61. 
rsycd

91.
sshd setup.


#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@  
#@  
#@  
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   2021-08-07[Aug-Sat]20-24PM 

11.

c:
md c:\temp
cd c:\temp

download..

from..
https://github.com/git-for-windows/git/releases/tag/v2.32.0.windows.2

PortableGit-2.32.0.2-64-bit.7z.exe

_____________

21.

Install 
PortableGit-2.32.0.2-64-bit.7z.exe
into folder
C:\prg\PortableGit\


_____________



=================================================

notes.

https://github.com/downloads/user/repository/filename

curl  https://github.com/downloads/git-for-windows/git/releases/download/
v2.32.0.windows.2/PortableGit-2.32.0.2-64-bit.7z.exe

https://raw.githubusercontent.com/user/repository/branch/filename

https://raw.githubusercontent.com/git-for-windows/git/


=================================================


31.


Now add pacman package manager..


open git-bash terminal
   `C:\prg\PortableGit\git-bash.exe`


cd
mkdir bag
cd bag


  git clone https://github.com/dgleba/gitportable-pacman.git

  cd  ~/bag/gitportable-pacman

  bash install-pacman-git-bash.sh 2>&1| tee -a /c/temp/pacmanlog$(date +"__%Y.%m.%d_%H.%M.%S").txt


Install rsync and ..

  pacman -Sy rsync
  pacman -Sy cygrunsrv


#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@  
#@  https://github.com/dgleba/gitportable-pacman.git
#@  
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   2021-08-07[Aug-Sat]20-11PM 

changes I made..


+rm -rf   /c/Users/david/bag/gitportable-pacman/git-sdk-64^M
+s=99 ; read  -rsp $"Wait $s seconds or press Escape-key or Arrow key to continue..." -t $s -d $'\e'; echo;echo;^M
+^M
 # Clone tiny blobless shallow repo
 git clone \
        --depth 20 \
@@ -18,9 +21,10 @@ git pull

 ### Pre install minimal pacman bootstrap
 d="var/lib/pacman/local"
-pkgs=('pacman-5' 'pacman-mirrors-' 'msys2-keyring-')
+pkgs=('pacman-6' 'pacman-mirrors-' 'msys2-keyring-')^M
 for j in ${pkgs[@]} ; do
-       pacvers=$(basename $( git show main:$d|grep "$j" ))
+       #pacvers=$(basename $( git show main:$d|grep "$j" ))^M
+       pacvers=$( git show main:$d|grep "$j" )^M
        echo $pacvers
        shfiles=$(curl -sSL $RAWURL/main/$d/$pacvers/files )
        for f in $shfiles
@@ -36,8 +40,9 @@ for j in ${pkgs[@]} ; do
         fi
        done
        wait
+  s=10 ; read  -rsp $"Wait $s seconds or press Escape-key or Arrow key to continue..." -t $s -d $'\e'; echo;echo;^M
 done
-wait
+wait^M

mkdir -p /var/lib/pacman


_____________


+++ git show main:var/lib/pacman/local| grep pacman-5


=================================================


>61.


rsyncd..
  
:: get these two files from here: https://sourceforge.net/projects/backuppc/files/cygwin-rsyncd/3.1.2.1/

::read rsync.conf to ensure the settings and paths make sense.
-edit users
-edit paths


ref: C:\n\Dropbox\csd\0-csd\rsync,service,cygwin\rsyncd.secrets  

:: edit   rsyncd.conf
:: edit   secrets  -- rsyncd.secrets  
    
    
copy rsyncd.conf and rsyncd.secrets  to C:\prg\PortableGit\rsync

  
===
  
In a admin cmd prompt:
  
  
set cygdg=C:\prg\PortableGit
set PATH=%cygdg%\usr\bin;%PATH%
::
cygrunsrv --remove  "rsyncd" 
::
mkdir c:\temp
mkdir "%cygdg%\tmp"
cygrunsrv -I "rsyncd" -c "%cygdg%\tmp" -p "%cygdg%\usr\bin\rsync.exe" -a "--config %cygdg%\rsync\rsyncd.conf --daemon --no-detach" -o -t auto -e "CYGWIN=nontsec binmode" -1 "%cygdg%\tmp\rsyncd-stdin.log" -2 "%cygdg%\tmp\rsyncd-stderr.log" -y "tcpip" -f "Rsync utility file transfer msys2"


:: net stop rsyncd
net start rsyncd


_____________ 


open firewall for rsync.exe

  netsh advfirewall firewall add rule name="rsync.exe" dir=in action=allow program="C:\prg\PortableGit\usr\bin\rsync.exe"



test
  from another machine..

works..

passwd=x
user=david
srv=192.168.88.43
mkdir -p ~/.ssh
# set password..
pf=~/.ssh/pwf99
echo $passwd>$pf
chmod 700 $pf
rsync  -avvz -i --progress  --password-file=$pf $user@$srv::cDrive/Windows/regedit.exe  ~/tmp2/


=================================================


#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@  
#@  >91. sshd
#@  
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   2021-08-18[Aug-Wed]12-22PM 

https://www.msys2.org/wiki/Setting-up-SSHd/

pacman -S mingw-w64-x86_64-editrights

open **admin** git-bash terminal..

works!

bash /c/n/sfile/computer/msys2-git4win-pacman-rsync/msys2-sshd-setup2.sh

login in with windows user david and it's password.

https://gist.github.com/samhocevar/00eec26d9e9988d080ac


net stop msys2_sshd


_____________

this didn;t work.
bash /c/n/sfile/computer/msys2-git4win-pacman-rsync/msys2-sshd-setup.sh

error:
Connection to 192.168.88.43 closed by remote host.
Connection closed by remote host.

ggl..
msys2 ssh server Connection closed by remote host.


=================================================





#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@  
#@  XPS  error
#@  
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   2021-08-22[Aug-Sun]12-10PM 


errors on xps.

( 2021-08-23 I modified the install pacman .sh script to attempt to address it )


error: could not open file /var/lib/pacman/local/expat-2.2.10-1/desc: No such file or directory
error: could not open file /var/lib/pacman/local/file-5.39-2/desc: No such file or directory
error: could not open file /var/lib/pacman/local/findutils-4.7.0-1/desc: No such file or directory


drwxr-xr-x 1 dgleba 1049089 0 Aug 19 22:50 expat-2.2.10-1/
drwxr-xr-x 1 dgleba 1049089 0 Aug 19 22:50 file-5.39-2/
drwxr-xr-x 1 dgleba 1049089 0 Aug 19 22:59 filesystem-2021.03-5/
drwxr-xr-x 1 dgleba 1049089 0 Aug 19 22:50 findutils-4.7.0-1/


msys2 pacman error: failed to prepare transaction (invalid or corrupted package)
 
pacman -Scc

pacman -Syyu

warning: could not fully load metadata for package filesystem-2021.03-5
error: failed to prepare transaction (invalid or corrupted package)

pacman -S pacman-mirrors

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@  
#@  
#@  
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   2021-08-22[Aug-Sun]12-20PM 

$ pacman -S -h
usage:  pacman {-S --sync} [options] [package(s)]
options:
  -b, --dbpath <path>  set an alternate database location
  -c, --clean          remove old packages from cache directory (-cc for all)
  -d, --nodeps         skip dependency version checks (-dd to skip all checks)
  -g, --groups         view all members of a package group
                       (-gg to view all groups and members)
  -i, --info           view package information (-ii for extended information)
  -l, --list <repo>    view a list of packages in a repo
  -p, --print          print the targets instead of performing the operation
  -q, --quiet          show less information for query and search
  -r, --root <path>    set an alternate installation root
  -s, --search <regex> search remote repositories for matching strings
  -u, --sysupgrade     upgrade installed packages (-uu enables downgrades)
  -v, --verbose        be verbose
  -w, --downloadonly   download packages but do not install/upgrade anything
  -y, --refresh        download fresh package databases from the server
                       (-yy to force a refresh even if up to date)
      --arch <arch>    set an alternate architecture
      --asdeps         install packages as non-explicitly installed
      --asexplicit     install packages as explicitly installed
      --assume-installed <package=version>
                       add a virtual package to satisfy dependencies
      --cachedir <dir> set an alternate package cache location
      --color <when>   colorize the output
      --config <path>  set an alternate configuration file
      --confirm        always ask for confirmation
      --dbonly         only modify database entries, not package files
      --debug          display debug messages
      --disable-download-timeout
                       use relaxed timeouts for download
      --gpgdir <path>  set an alternate home directory for GnuPG
      --hookdir <dir>  set an alternate hook location
      --ignore <pkg>   ignore a package upgrade (can be used more than once)
      --ignoregroup <grp>
                       ignore a group upgrade (can be used more than once)
      --logfile <path> set an alternate log file
      --needed         do not reinstall up to date packages
      --noconfirm      do not ask for any confirmation
      --noprogressbar  do not show a progress bar when downloading files
      --noscriptlet    do not execute the install scriptlet if one exists
      --overwrite <glob>
                       overwrite conflicting files (can be used more than once)
      --print-format <string>
                       specify how the targets should be printed
      --sysroot        operate on a mounted guest system (root-only)

dgleba@SICS-GZPJL13 MINGW64 ~/bag/gitportable-pacman (master)
$

 

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@  
#@  
#@  
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   2021-08-22[Aug-Sun]12-32PM 


 pacman -S filesystem libxml2 liblzma icu gcc-libs bash-completion --noconfirm
 
 pacman -S  libxml2 --noconfirm
 pacman -S  liblzma --noconfirm
 pacman -S  icu --noconfirm
 pacman -S  gcc-libs --noconfirm
 pacman -S  bash-completion --noconfirm


=================================================


error: failed to commit transaction (conflicting files)

libxml2: /usr/share/licenses/libxml2/COPYING exists in filesystem

Errors occurred, no packages were upgraded.


rm /usr/share/licenses/libxml2/COPYING


C:\prg\PortableGit\usr\share\licenses\libxml2

_____________

david@redyo7 MINGW64 ~/bag/gitportable-pacman (master)

$  pacman -S  libxml2 --noconfirm
resolving dependencies...
looking for conflicting packages...

Packages (1) libxml2-2.9.12-1

Total Installed Size:  1.33 MiB

:: Proceed with installation? [Y/n]
(1/1) checking keys in keyring                                                           [###################################################] 100%
(1/1) checking package integrity                                                         [###################################################] 100%
(1/1) loading package files                                                              [###################################################] 100%
(1/1) checking for file conflicts                                                        [###################################################] 100%
(1/1) checking available disk space                                                      [###################################################] 100%
:: Processing package changes...


error: could not create temp directory


(1/1) upgrading libxml2                                                                  [###################################################] 100%



msys2 pacman -S libxml2-2.9.12-1  git for windows error: could not create temp directory



_____________



