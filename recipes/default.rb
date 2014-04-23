#
# Cookbook Name:: chef-gitlab
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "ntp"

execute "localtime change" do
	command "cp -f /usr/share/zoneinfo/Asia/Tokyo /etc/localtime"
	not_if "strings /etc/localtime | grep JST-9"
end

execute "Japanese Support" do
	command 'yum groupinstall -y "Japanese Support"'
end
log :environment

file '/etc/sysconfig/i18n' do
	_file = Chef::Util::FileEdit.new(path)
	_file.search_file_replace_line('LANG="en_US.UTF-8"', '#LANG="en_US.UTF-8"')
	_file.insert_line_if_no_match('LANG="ja_JP.UTF-8"','LANG="ja_JP.UTF-8"')
	_file.write_file
	# not_if :environment[:LANG] == "ja_JP.UTF-8"
end

include_recipe "vim::source"

include_recipe "yum-epel"
include_recipe "build-essential"

if platform_family?("rhel", "suse", "fedora")
	%w[zlib-devel libyaml-devel openssl-devel
		gdbm-devel readline-devel
		ncurses-devel libffi-devel
		redis
		libxml2-devel libxslt-devel
		libicu-devel].each do|pkg|
		package pkg
	end
else 
	%w[zlib1g-dev libyaml-dev libssl-dev 
		libgdbm-dev libreadline-dev
		libncurses5-dev libffi-dev
		redis-server checkinstall 
		libxml2-dev libxslt-dev
		libcurl4-openssl-dev
		libicu-dev].each do|pkg|
		package pkg
	end
end

%w[ curl openssh-server logrotate].each do |pkg|
		package pkg
end

include_recipe "git::source"

include_recipe "ruby_build"
include_recipe "rbenv::system"
rbenv_ruby "2.1.1"