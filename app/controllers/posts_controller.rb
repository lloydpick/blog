class PostsController < ApplicationController

  make_resourceful do
    actions :index, :show, :edit, :update
  end


  private

  def current_object
    @current_object ||= current_model.published.find_by_permalink(params[:id])
  end

  def current_objects
    @current_objects ||= current_model.published.paginate(:all, :per_page => 20, :page => params[:page], :order => 'created_at DESC')
  end

end
