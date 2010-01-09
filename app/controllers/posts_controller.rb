class PostsController < ApplicationController

  make_resourceful do
    actions :index, :show

    before :show do
      set_title(@current_object.title)
    end

    response_for :index, :show do |format|
      format.html
      format.xml
      format.json
      format.atom { @current_objects = current_model.published.limit(20)}
    end
  end

  def archive
    @current_objects = Post.published.find_by_date(params)
    set_title("Posts created #{return_date_selection(params)}")

    respond_to do |format|
      format.html
      format.xml { render :xml => @current_objects }
      format.json { render :json => @current_objects }
    end
  end

  private

  def current_object
    @current_object ||= current_model.published.find_by_permalink(params[:id])
  end

  def current_objects
    @current_objects ||= current_model.published.paginate(:all, :per_page => 3, :page => params[:page])
  end

  protected

  def return_date_selection(params)
    if params[:month] && params[:year] && params[:day]
      "on #{params[:day].to_i.ordinalize} #{month_name_from_number(params[:month])} #{params[:year]}"
    elsif params[:month] && params[:year]
      "in #{month_name_from_number(params[:month])} #{params[:year]}"
    elsif params[:year]
      "in #{params[:year]}"
    end
  end

end
