#
# Cookbook Name:: windowsWorkstation
# Recipe:: packages
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'chocolatey'

%w{7zip atom google-chrome-x64 git ruby rubygems vlc dropbox virtualclonedrive steam jdk8}.each do |pack|
  chocolatey pack
end
