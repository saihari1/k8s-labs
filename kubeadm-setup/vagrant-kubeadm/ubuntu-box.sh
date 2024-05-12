#goto https://app.vagrantup.com/boxes/search
cd c:\vagrant-box
vagrant box add ubuntu/trusty64
vagrant init ubuntu/trusty64
vagrant up

#connect to box
vargrant ssh

#if the above doesn't work, manually connect to the machine
vagrant ssh-config
ssh vagrant @127.0.0.1 -p 2222 -i <identityfile>
