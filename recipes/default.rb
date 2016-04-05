#
# Cookbook Name:: bootstrap_windows
# Recipe:: default
#
# Copyright (C) 2016 Levi Smith
#

include_recipe 'workstation::config'
include_recipe 'workstation::packages'
include_recipe 'workstation::atom'
