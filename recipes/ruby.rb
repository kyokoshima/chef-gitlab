include_recipe "ruby_build"
include_recipe "rbenv::system"
# node.default['rbenv']['user_installs'] = [
#   { 'user' => 'git', 
#   	'rubies'  => ['2.1.1'],
#     'global'  => '2.1.1'
# 	}
# ]
rbenv_ruby "2.1.1"
rbenv_global "2.1.1"

rbenv_gem "bundler" do
	rbenv_version "2.1.1"
	options "--no-ri --no-rdoc"
	action :install
end