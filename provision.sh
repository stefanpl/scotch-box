if [ ! -d /home/vagrant/.oh-my-zsh ]; then
	git clone https://github.com/stefanpl/oh-my-zsh .oh-my-zsh
	ln -s /home/vagrant/.oh-my-zsh/.zshrc /home/vagrant/.zshrc
	sudo apt-get install -y zsh
	sudo usermod -s /bin/zsh vagrant
	touch /home/vagrant/.bash_aliases_private
fi

if [ ! -d /home/vagrant/.vim ]; then
	git clone https://github.com/stefanpl/vim-config .vim
	cd /home/vagrant/.vim && git submodule update --init --recursive
	ln -s /home/vagrant/.vim/.vimrc /home/vagrant/.vimrc
fi

sudo apt-get update
sudo apt-get install -y php5-dev
sudo pecl install xdebug
echo 'zend_extension="/usr/lib/php5/20131226/xdebug.so"' | sudo tee -a /etc/php5/apache2/php.ini
