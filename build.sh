#!/usr/bin/env bash
if [ -f ./VERSION ] && [ -f ./LICENSE ];
then 
	echo "Removing old gem.."
	gem uninstall -x gottabeafraid
	echo "Building gem.."
	rake build
	echo "Installing gem.." 
	gem install pkg/gottabeafraid-`ruby -e 'require "./lib/gottabeafraid/version.rb"; print Gottabeafraid::VERSION'`.gem 
	git status
	echo "Validating gem.."
	gem list --local |grep gottabeafraid
else
	echo "not in root gem directory, existing."
fi
	
