sysv_settings =
  case node['platform']
  when 'debian' then 'default'
  else 'sysconfig'
  end

template "/etc/#{sysv_settings}/docker" do
  source "docker.#{sysv_settings}.erb"
  mode '0644'
  owner 'root'
  group 'root'
  notifies :restart, 'service[docker]', :immediately
end

service 'docker' do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end
