

See  https://github.com/dgleba/gitportable-pacman.git



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
  cd bag

  git clone https://github.com/dgleba/gitportable-pacman.git

  cd  ~/bag/gitportable-pacman

  bash install-pacman-git-bash.sh 2>&1| tee -a /c/temp/pacmanlog$(date +"__%Y.%m.%d_%H.%M.%S").txt


Install rsync and ..

  pacman -Sy rsync
  pacman -Sy cygrunsrv


#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@  
#@  
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

