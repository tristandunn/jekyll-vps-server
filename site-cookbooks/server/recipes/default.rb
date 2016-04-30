include_recipe "nginx::default"

directory "/var/www" do
  owner node[:user]
end

template "example" do
  path  "#{node[:nginx][:dir]}/sites-available/example"
  owner node[:user]

  # Use an SSL configuration file when the certificate is present.
  if File.exist?("/etc/ssl/example.com.crt")
    source "example.ssl.nginx"
  else
    source "example.nginx"
  end

  notifies :reload, "service[nginx]"
end

nginx_site "example" do
  enable true
end
