include_recipe "ntp"
execute "localtime change" do
	command "cp -f /usr/share/zoneinfo/Asia/Tokyo /etc/localtime"
	not_if "strings /etc/localtime | grep JST-9"
end