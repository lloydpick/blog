class Admin::CategoriesController < Admin::ApplicationController

  make_resourceful do
    actions :all
  end

  private

  def current_object
    @current_object ||= current_model.find_by_permalink(params[:id])
  end

  def current_objects
    @current_objects ||= current_model.all.paginate(:per_page => 20, :page => params[:page], :order => 'created_at DESC')
  end
  
end