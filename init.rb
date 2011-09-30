require 'redmine'

require 'burndown_listener'
require 'scrum_alliance/redmine/current_version_extension'

require 'dispatcher'
Dispatcher.to_prepare do
  Project.class_eval { include ScrumAlliance::Redmine::CurrentVersionExtension }
end

Redmine::Plugin.register :burndown do
  name 'Redmine Burndown plugin'
  author 'Dan Hodos'
  description 'Generates a simple Burndown chart for using Redmine in Scrum environments'
  version '1.1.3'

  project_module :burndowns do  
    permission :show_burndown, :burndowns => [:show, :chart, :start_sprint], :public => true
  end

  menu :project_menu, :burndown, { :controller => 'burndowns', :action => 'show' }, :param => :project_id, :after  => :scrums
end
