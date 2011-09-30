class SprintsController < VersionsController
  def edit
    if request.post? and @version.update_attributes(params[:version])
      flash[:notice] = l(:notice_successful_update)
      redirect_to show_burndown_path(@project, @version)
    end
  end
  
end
