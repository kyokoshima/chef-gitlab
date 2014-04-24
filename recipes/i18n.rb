node["gitlab"]["packages"]["i18n"].each do |pkg|
	# command 'yum groupinstall -y "Japanese Support"'
	package pkg
end

file '/etc/sysconfig/i18n' do
	_file = Chef::Util::FileEdit.new(path)
	_file.search_file_replace_line('LANG=', node["gitlab"]["lang"])
	# _file.insert_line_if_no_match('LANG="ja_JP.UTF-8"','LANG="ja_JP.UTF-8"')
	_file.write_file
	not_if { ENV['LANG'] == node["gitlab"]["lang"] }
end