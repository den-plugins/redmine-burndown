#--------------------ROUTE FOR HIGHER VERSIONS OF REDMINE 0.8----------------------------------------------
ActionController::Routing::Routes.draw do |map|
  map.latest_burndown 'projects/:project_id/burndown', :controller => 'burndowns', :action => 'show'
  map.show_burndown 'projects/:project_id/burndowns/:id', :controller => 'burndowns', :action => 'show'
  map.start_sprint_burndown 'projects/:project_id/start_sprint/:id', :controller => 'burndowns', :action => 'start_sprint'
end
