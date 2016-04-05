#
# Cookbook Name:: bootstrap_windows
# Recipe:: atom
#
# Copyright (C) 2016 Levi Smith
#

chocolatey atom

if node['atom']['star_package_install']
  execute 'apm star install' do
    command "apm stars --user #{node['atom']['username']}"
    action :run
  end
end

if node['atom']['install_package_list']
  template 'C:\tmp\packagelist.txt' do
    source 'packagelist.txt.erb'
    owner node['user']
    mode 00774
  end
  execute 'apm package install' do
    command 'apm install --packages-file C:\tmp\packagelist.txt'
    action :run
  end
end
