#
# Cookbook Name:: bootstrap_windows
# Recipe:: config
#
# Copyright (C) 2016 Levi Smith
#

%w(public private gists).each do |dir|
  directory "#{node['home']}/git/github/#{dir}" do
    owner node['user']
    mode 00755
    recursive true
    only_if { node['config']['github'] }
    action :create
  end
end

%w(public private gists).each do |dir|
  directory "#{node['home']}/git/gitbucket/#{dir}" do
    owner node['user']
    mode 00755
    recursive true
    only_if { node['config']['gitbucket'] }
    action :create
  end
end
