# set up zsh and .oh-my-zsh
if [ ! -d /home/vagrant/.oh-my-zsh ]; then
	git clone https://github.com/stefanpl/oh-my-zsh .oh-my-zsh
	ln -s /home/vagrant/.oh-my-zsh/.zshrc /home/vagrant/.zshrc
	sudo apt-get install -y zsh
	sudo usermod -s /bin/zsh vagrant
	touch /home/vagrant/.bash_aliases_private
fi

# setting up vim
if [ ! -d /home/vagrant/.vim ]; then
	git clone https://github.com/stefanpl/vim-config .vim
	cd /home/vagrant/.vim && git submodule update --init --recursive
	ln -s /home/vagrant/.vim/.vimrc /home/vagrant/.vimrc
fi

# installing xdebug
sudo apt-get update
sudo apt-get install -y php5-dev
sudo pecl install xdebug
# add xdebug to php.ini if necessary
zend_extension_string = 'zend_extension="/usr/lib/php5/20131226/xdebug.so"' 
result="$(cat /etc/php5/apache2/php.ini | egrep -i $zend_extension_string)"
if [ "$result" = "" ];
then
	echo $zend_extension_string | sudo tee -a /etc/php5/apache2/php.ini
	echo 'xdebug.remote_enable=1' | sudo tee -a /etc/php5/apache2/php.ini
	echo 'xdebug.remote_host=192.168.33.1' | sudo tee -a /etc/php5/apache2/php.ini
	echo 'xdebug.remote_handler=dbgp' | sudo tee -a /etc/php5/apache2/php.ini
	echo 'xdebug.remote_port=9000' | sudo tee -a /etc/php5/apache2/php.ini
	echo 'xdebug.remote_autostart=1' | sudo tee -a /etc/php5/apache2/php.ini
else 
	echo "empty"
fi
