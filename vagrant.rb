Vagrant.configure('2') do |config|
  config.omnibus.chef_version = '12.5.1'
  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
    config.cache.enable :generic, 'chef' => { cache_dir: '/tmp/kitchen/cache' }
    config.vm.provision 'shell', inline: 'chown -R vagrant:vagrant /tmp/kitchen'
  end
end
