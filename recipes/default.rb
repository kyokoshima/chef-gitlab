#
# Cookbook Name:: chef-gitlab
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "gitlab::ntp"
include_recipe "gitlab::i18n"

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

# gitインストール（最新版入れるためソースから）
include_recipe "git::source"

# gitユーザー作成
include_recipe "gitlab::user"

# rubyインストール
include_recipe "gitlab::ruby"



include_recipe "gitlab::gitlab_shell"
