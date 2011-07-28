require 'redmine'

require 'open_flash_chart_object'
require 'open_flash_chart'
require 'bar_base'
require 'bar'
require 'bar_3d'
require 'bar_glass'
require 'bar_sketch'
require 'bar_stack'
require 'h_bar'
require 'line_base'
require 'line'
require 'line_dot'
require 'line_hollow'
require 'pie'
require 'scatter'
require 'title'
require 'x_axis_label'
require 'x_axis_labels'
require 'x_axis'
require 'x_legend'
require 'y_axis_base'
require 'y_axis'
require 'y_axis_right'
require 'y_legend'

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
    permission :show_burndown, :burndowns => [:show, :chart], :public => true
  end

  menu :project_menu, :burndown, { :controller => 'burndowns', :action => 'show' }, :param => :project_id, :before  => :activity
end
