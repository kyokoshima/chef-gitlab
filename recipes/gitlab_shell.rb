git "/home/git/gitlab-shell" do
	repository node["gitlab"]["gitlab-shell"]["repository"]
	revision node["gitlab"]["gitlab-shell"]["revision"]
	action :sync
	user "git"
	group "git"
	# notifies :run, "bash[configure_gitlab_shell_copy_config]"
end

execute "configure_gitlab_shell_copy_config" do
	cwd "/home/git/gitlab-shell"
	user "git"
	command "cp config.yml.example config.yml"	
	# _file = Chef::Util::FileEdit.new(path)
	# _file.search_file_replace_line('LANG=', node["gitlab"]["lang"])
	# command "./bin/install"
end

execute "configure_gitlab_shell_install" do
	cwd "/home/git/gitlab-shell"
	user "git"
	command "./bin/install"
end