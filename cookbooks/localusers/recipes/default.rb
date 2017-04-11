#
# Cookbook Name:: localusers
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

search(:users, "*:*").each do |data| 
	user data["id"] do
		uid data["uid"]
		comment data["comments"]
		gid data["gid"]
		home data["home"]
		shell data["shell"]
		password data["password"]
	end
end

include_recipe "localusers::groups"
