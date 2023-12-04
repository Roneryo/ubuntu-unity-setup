#!/bin/sh
install_git() {
	sudo apt install git -y
}
install_vscode() {
	sudo apt update
	sudo apt install software-properties-common apt-transport-https wget -y
	wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
	sudo apt install code

}
prerequisits_docker() {
	# Add Docker's official GPG key:
	sudo apt-get update
	sudo apt-get install ca-certificates curl gnupg -y
	sudo install -m 0755 -d /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	sudo chmod a+r /etc/apt/keyrings/docker.gpg

	# Add the repository to Apt sources:
	echo \
		"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
		sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
	sudo apt-get update
}

install_google_chrome() {
	sudo apt-get install libxss1 libappindicator1 libindicator7
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	echo ">Step 1<"
	#Solamente se ejecuta si corres el script como administrador
	sudo echo 'APT::Sandbox::User "root";' >/etc/apt/apt.conf.d/10sandbox
	#
	echo ">Step 2<"
	sudo apt install ./google-chrome*.deb
	sudo rm -rf google-chrome*.deb
}
install_nvm() {
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
	export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
	nvm install node
	nvm use node
	npm install -g pnpm
	echo "alias pn=pnpm" | cat >> ~/.bashrc 
	echo "alias pnx='pnpm dlx'" | cat >> ~/.bashrc 
	source ~/.bashrc 
}
install_docker() {
	prerequisits_docker
	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	sudo sudo usermod -aG docker roner
	sudo chmod 666 /var/run/docker.sock

	# Estos docker-desktop depende de estos paquetes
	sudo apt install qemu-system-x86 pass uidmap
	curl "https://desktop.docker.com/linux/main/amd64/docker-desktop-4.25.2-amd64.deb?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64&_gl=1*18u1nt8*_ga*MTE5MTg5NTc4NS4xNzAxMzE0OTU5*_ga_XJWPQMJYHQ*MTcwMTMxNzg5Mi4yLjEuMTcwMTMxNzk5NS42MC4wLjA." >docker-desktop-4.25.2-amd64.deb
	dpkg -i docker-desktop-4.25.2-amd64.deb
	rm docker-desktop-4.25.2-amd64.deb
}
install_obsidian(){
	wget "https://github.com/obsidianmd/obsidian-releases/releases/download/v1.4.16/obsidian_1.4.16_amd64.deb" 
	dpkg -i obsidian*.deb
	rm obsidian*.deb
}
install_unityhub(){
	# sudo apt install libgconf-2-4
	wget unityhub://2023.2.1f1/a6dd9a634651
}
install_and_update_discord(){
	sudo apt purge discord -y
	curl -0 -L -o discord.deb https://discord.com/api/download?platform=linux&format=deb & wait
	dpkg -i discord.deb
	rm discord.deb
}
# install_vscode
# install_git
# install_google_chrome
# prerequisits_docker
# install_docker
# install_nvm
# install_obsidian
# install_unityhub

# install_and_update_discord

