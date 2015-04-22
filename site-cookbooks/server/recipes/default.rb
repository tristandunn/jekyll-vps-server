include_recipe "nginx::default"

directory "/var/www" do
  owner node[:user]
end

template "example" do
  path   "#{node[:nginx][:dir]}/sites-available/example"
  owner  node[:user]
  source "example.nginx"

  notifies :reload, "service[nginx]"
end

nginx_site "example" do
  enable true
end
