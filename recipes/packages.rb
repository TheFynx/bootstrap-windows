#
# Cookbook Name:: bootstrap_windows
# Recipe:: packages
#
# Copyright (C) 2016 Levi Smith
#

include_recipe 'chocolatey'

# Frameworks && Codebases
%w{git ruby rubygems jdk8 powershell python dotnet3.5 dontnet4.5.2}.each do |pack|
  chocolatey pack
end

# Web Tools
%w{google-chrome dropbox lastpass transgui}.each do |pack|
  chocolatey pack
end

# System Tools
%w{7zip vlc virtualclonedrive virtualbox virtualbox.extensionpack vboxguestadditions.install}.each do |pack|
  chocolatey pack
end

# Entertainment
%w{steam}.each do |pack|
  chocolatey pack
end
