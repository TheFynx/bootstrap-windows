#
# Cookbook Name:: bootstrap_windows
# Recipe:: atom
#
# Copyright (C) 2016 Levi Smith
#

chocolatey 'atom'

execute 'apm star install' do
  command "apm stars --user #{node['atom']['username']}"
  action :run
  only_if { node['atom']['star_package_install'] }
end

template 'C:\tmp\packagelist.txt' do
  source 'packagelist.txt.erb'
  owner node['user']
  only_if { node['atom']['install_package_list'] }
  mode 00774
end

execute 'apm package install' do
  command 'apm install --packages-file C:\tmp\packagelist.txt'
  action :run
  only_if { node['atom']['install_package_list'] }
end
