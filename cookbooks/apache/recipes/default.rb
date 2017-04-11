#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "httpd" do
	package_name node["apache"]["package"]
	Chef::Log.info node["apache"]["package"]
	Chef::Log.info "Package name =>" + package_name
end

node["apache"]["sites"].each do |sitename, data|

	document_root = "/content/sites/#{sitename}" 
	directory document_root	do
		mode "0755"
		recursive true
	end

	if node["platform"] == "ubuntu" 
		template_loc = "/etc/apache2/sites-enabled/#{sitename}.conf"
	elsif node["platform"] == "centos" 
		template_loc = "/etc/httpd/conf.d/#{sitename}.conf"
	end
	
	template template_loc do
		source "vhost.erb"
		mode "0644"
		variables(
			:document_root 	=> document_root,
			:port		=> data["port"],
			:domain		=> data["domain"]
		)
		notifies :restart, "service[httpd]"
	end

	template "/content/sites/#{sitename}/index.html" do
		source "index.html.erb"
		mode "0644"
		variables(
			:site_title => data["site_title"],
			:content    => "Coming Soon!",
			:author_name => node["author"]["name"]
		)			
	end
end

execute "rm /etc/httpd/conf.d/welcome.conf" do
	only_if do
		File.exist?"/etc/httpd/conf.d/welcome.conf"
	end
end

service "httpd" do
	service_name node["apache"]["package"]	
	Chef::Log.info node["apache"]["package"]
	Chef::Log.info "Service name =>" + service_name
	action [:enable, :start]
end

#include_recipe "php::default"
