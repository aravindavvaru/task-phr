Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-22.04"
  config.vm.provider "virtualbox" do |vb|
    # Hide the VirtualBox GUI when booting the machine
    vb.gui = false
    # Customize the amount of memory on the VM
    vb.memory = "4096"
    vb.cpus = 2
  end
  config.vm.network "private_network", ip: "192.168.56.60"
  config.vm.network "public_network"
  # Copy over your public SSH key
  config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/me.pub"
  # Add it to `authorized_keys` for hassle-free login
  config.vm.provision "shell", inline: "cat ~vagrant/.ssh/me.pub >> ~vagrant/.ssh/authorized_keys"

  # Map Vagrant's ports to different host's ports to avoid local conflicts
  config.vm.network "forwarded_port", guest: 22, host: 2222
  config.vm.network "forwarded_port", guest: 80, host: 5000
end