
# Script to install pacman package management
# in Git for Windows Portable
# To be run from a git-bash session.

GITURL="https://github.com/git-for-windows/git-sdk-64.git"
RAWURL="https://github.com/git-for-windows/git-sdk-64/raw"

rm -rf   /c/Users/david/bag/gitportable-pacman/git-sdk-64
s=99 ; read  -rsp $"Wait $s seconds or press Escape-key or Arrow key to continue..." -t $s -d $'\e'; echo;echo;

# Clone tiny blobless shallow repo ( 2021-08-22 - was depth 20)
git clone \
	--depth 3 \
	--filter=blob:none \
	--no-checkout \
	$GITURL

cd  git-sdk-64
git pull

### Pre install minimal pacman bootstrap

echo ~~~doing...  Pre install minimal pacman bootstrap
d="var/lib/pacman/local"
pkgs=('pacman-6' 'pacman-mirrors-' 'msys2-keyring-')
for j in ${pkgs[@]} ; do
	#pacvers=$(basename $( git show main:$d|grep "$j" ))
	echo ~~~doing... pacvers=$( git show main:$d|grep "$j" )
	pacvers=$( git show main:$d|grep "$j" )
	echo $pacvers
	shfiles=$(curl -sSL $RAWURL/main/$d/$pacvers/files )	
	for f in $shfiles
	do 
	 if [[ $f = *"/"* ]] && [[ $f != *"/man/"* ]] && [[ $f != *"locale/"* ]] && [[ $f != *\/ ]]
	  then
	  		if [ ! -f "/$f" ]
				then
					mkdir -p /$(dirname "$f" ) 
					curl -sSL $RAWURL/main/$f -o /$f &
					[ $( jobs | wc -l ) -ge $( nproc ) ] && wait
			fi
	 fi  
	done
	wait
  s=10 ; read  -rsp $"Wait $s seconds or press Escape-key or Arrow key to continue..." -t $s -d $'\e'; echo;echo;
done
wait

mkdir -p /var/lib/pacman
pacman-key --init
pacman-key --populate msys2
curl -L https://raw.githubusercontent.com/git-for-windows/build-extra/HEAD/git-for-windows-keyring/git-for-windows.gpg |\
pacman-key --add - &&
pacman-key --lsign-key 3B6D86A1BA7701CD0F23AED888138B9E1A9F3986
echo ~~~doing... 1  pacman -Sy
pacman -Sy

################
# Restore Pacman metadata

echo ~~~doing... Restore Pacman metadata
d="var/lib/pacman/local"
for j in ${pkgs[@]} ; do
	pacvers=$(basename $( git show main:$d|grep "$j" ))
	for f in desc install files mtree; do
		git show main:$d/$pacvers/$f > /dev/null 2>%1
		if [ $? -eq 0 ]; then
		mkdir -p /$d/$pacvers
		[ ! -f "/$d/$pacvers/$f" ] && curl -sSL "$RAWURL/main/$d/$pacvers/$f" -o /$d/$pacvers/$f
		echo "$d/$pacvers/$f"
		fi
	done
done

#################
pac
echo ~~~doing... commits=$(git log --pretty=%h)
commits=$(git log --pretty=%h)


######## Packages metadata

spdup ()
{
	package=$1
	version=$2
  
  # I commented out some if statements. This helped, but I am not sure it is the correct solution.
	for cs in $commits ; do
    d=var/lib/pacman/local/$package-$version
		[ ! -d /$d ] && mkdir -p /$d
		git show $cs:$d >/dev/null 2>&1
		# if [ $? -eq 0 ]
		# then
      echo ~~~doing... in spdup
			echo -e "$cs\t$package $version"
			for f in desc files install mtree; do 
				git show $cs:$d/$f > /dev/null 2>&1
				# if [ $? -eq 0 ]
				# then
				 [ ! -f "/$d/$f" ] && curl -sSL "$RAWURL/$cs/$d/$f" -o /$d/$f 
				# fi
			done
      # this seems to stop it after the first commit in the list.
			break
		# fi
	done 
}


# =================================================

# I got errors 2021-08-23. I didn't get these previously. I have been trying to figure out a solution.
#
#  pacman -S zip
# 
#  error: could not open file /var/lib/pacman/local/expat-2.3.0-1/desc: No such file or directory
#  error: could not open file /var/lib/pacman/local/glib2-2.68.1-1/desc: No such file or directory
#  error: could not open file /var/lib/pacman/local/grep-3.1-1/desc: No such file or directory
#  error: could not open file /var/lib/pacman/local/less-581-1/desc: No such file or directory
#
#  it installs it even with the error present. 
#

echo ~~~doing...  cat /etc/package-versions.txt  ~ while read package version


# show verbose package metadata updates..
# set -vx

cat /etc/package-versions.txt |while read package version
do
	echo ~~~doing... spdup $package $version 
	spdup $package $version & 
	[ $( jobs | wc -l ) -ge $( nproc ) ] && wait
done
wait 


# =================================================


### Wrap up

echo ~~~doing... wrap-up - pacman -Sy
pacman -Sy


# pacman -S filesystem libxml2 liblzma icu gcc-libs bash-completion --noconfirm
# pacman -S filesystem  bash-completion --noconfirm

# pacman -S filesystem libxml2 liblzma icu gcc-libs bash-completion --noconfirm
# pacman -S  libxml2 --noconfirm
# pacman -S  liblzma --noconfirm
# pacman -S  icu --noconfirm
# pacman -S  gcc-libs --noconfirm
# pacman -S  bash-completion --noconfirm

