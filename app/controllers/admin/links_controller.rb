class Admin::LinksController < Admin::ApplicationController

  make_resourceful do
    actions :all
  end

  private

  def current_objects
    @current_objects ||= current_model.paginate(:all, :per_page => 20, :page => params[:page], :order => 'created_at DESC')
  end

end