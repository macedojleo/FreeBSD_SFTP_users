Vagrant.configure("2") do |config|
  config.vm.box = "bento/freebsd-11.2"
  config.hostmanager.enabled = true
  
  config.vm.define "host1", primary: true do |h|
    h.vm.network "private_network", ip: "192.168.0.10"
    h.vm.hostname = "host1"
    h.vm.synced_folder ".", "/vagrant", type: "nfs"
    h.vm.provision :shell, :inline => <<'EOF'
if [ ! -f "/home/vagrant/.ssh/id_rsa" ]; then
  ssh-keygen -t rsa -N "" -f /home/vagrant/.ssh/id_rsa
fi
cp /home/vagrant/.ssh/id_rsa.pub /vagrant/control.pub

cat << 'SSHEOF' > /home/vagrant/.ssh/config
Host *
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
SSHEOF

chown -R vagrant:vagrant /home/vagrant/.ssh/

EOF
  end

  config.vm.define "host2" do |h|
    h.vm.network "private_network", ip: "192.168.0.20"
    h.vm.hostname = "host2"
    h.vm.synced_folder ".", "/vagrant", type: "nfs"
    h.vm.provision :shell, inline: 'cat /vagrant/control.pub >> /home/vagrant/.ssh/authorized_keys'
  end
end