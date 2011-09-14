# Redmine Burndowns

## Introduction

This plugin adds a 'Burndown' tab to your Project Menu for any Project with the 'Burndowns' module enabled (Settings>Modules). 

This tab will show the Burndown chart for the current Version, and also give a sidebar listing of all previous Versions to see their Burndown chart as well. 
The Burndown Chart shows the current work remaining in yellow and an ideal trend line in blue.

This version of Redmine Burndown is no longer using googlecharts gems by Matt Aimonetti instead, it is now using the jqplot plugins of JQuery for better representation of the graph and with more features. The old way of generating the actual data using percent done is now customised using remaining effort and the ideal data with the burned down estimated effort. A part of the chart can also be zoomed in by clicking and dragging on it, and double click to zoom out. This version also allows user to start an unstarted sprint. When a sprint is started, the start date will be the day it is started until it's specified effective date. If no effective date available, then automatically it will be set to a month from the start date. It is up to the user to specify the effective date at the Versions Tab of the Project Settings tab.

## Installation

Burndown plugin depends on redmine-custom plugin to work since we are basing the graph on estimated effort and remaining effort.

http://www.redmine.org/projects/redmine/wiki/Plugins

* Go to plugins directory:

   $ cd #{RAILS_ROOT}/vendor/plugins

* Download Burndown plugin:

   $ git clone git@github.com:den-plugins/redmine-burndown.git redmine_burndown
   
* Restart Redmine

   You should now be able to see the plugin list in Administration -> Plugins

   Update each Role and grant necessary permissions in Administration -> Roles and permissions


## Features

* When you are using scrum-task-board plugin a burndown chart for each task board version is available.


## Bug Fixes

## Testing

* Tested on Redmine version 0.8.0


Copyright (c) 2009 [Scrum Alliance](www.scrumalliance.org), released under the MIT license. 

Authored by:

* [Dan Hodos](mailto:danhodos[at]gmail[dot]com)
* [Doug Alcorn](mailto:dougalcorn[at]gmail[dot]com)

Customized by:
  Exist Software Labs, Inc.
