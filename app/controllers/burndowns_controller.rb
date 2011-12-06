class BurndownsController < ApplicationController
  unloadable
  menu_item :burndown

  before_filter :find_version_and_project, :authorize, :only => [:show, :chart, :start_sprint]

  def show
    @versions = @project.versions.all(:select => 'id, effective_date, name', :order => 'effective_date IS NULL, effective_date DESC')
  end

  def chart
    unless @chart.nil?
      render :partial => 'chart', :locals => {:for_external => true}
    else
      render :partial => "no_sprint", :locals => {:project => @project, :version => @version}
    end
  end

  def start_sprint
#    @version.sprint_start_date = Time.now
    @version.update_attributes(:sprint_start_date => Time.now)
    redirect_to show_burndown_path(@project, @version)
  end

private
  def find_version_and_project
    @project = Project.find(params[:project_id])
    @version = params[:id] ? @project.versions.find(params[:id]) : @project.current_version
    @chart = (@version and BurndownChart.sprint_has_started(@version.id))? BurndownChart.new(@version, params[:issue_filter]) : nil
  end
end
