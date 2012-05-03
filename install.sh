path="/usr/bin/prefixr" # The path where Prefixr-CL will be installed.

cancel_installation() {
   echo 'Cancelling installation.'
   exit
}

echo 'Starting installation.'

if ! eval "ping -c 1 4.2.2.1 > /dev/null 2>&1" ; then # Is there an active internet connection?
   echo 'You need to have an internet connection to install Prefixr-CL.'
   cancel_installation
fi

if [ ! -w /usr/bin ]; then # Enough permissions to install?
   echo "It seems like you are missing permissions. Try running the installation script as root."
   cancel_installation
fi

if [ -e "$path" ]; then # Is prefixr already installed?
   echo 'Prefixr-CL is already installed. It will be deleted and reinstalled.'
   echo 'Deleting Prefixr-CL.'
   rm -rf /usr/bin/prefixr > /dev/null 2>&1
fi

echo 'Downloading Prefixr-CL.'
curl -s https://raw.github.com/js-coder/Prefixr-CL/master/prefixr.rb > "$path"
chmod +x "$path"

echo 'Installing Prefixr-CL.'

rm -rf install.sh

echo 'Prefixr-CL was installed succesfully.'