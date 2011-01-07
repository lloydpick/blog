class CategoriesController < ApplicationController

  make_resourceful do
    actions :index, :show

    before :show do
      current_object
      current_objects
    end

    response_for :show do |format|
      format.html
      format.xml { render :xml => [current_object, current_objects] }
      format.json { render :json => [current_object, current_objects] }
      format.atom
    end
  end

  private

  def current_object
    @current_object ||= current_model.find_by_permalink(params[:id])
  end

  def current_objects
    @current_objects ||= current_object.posts.published.paginate(:per_page => 20, :page => params[:page], :order => 'created_at DESC')
  end

end
