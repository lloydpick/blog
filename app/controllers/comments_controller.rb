class CommentsController < ApplicationController

  make_resourceful do
    actions :create

    before :create do
      current_object.user_ip = request.remote_ip
      current_object.user_agent = request.user_agent
      current_object.referrer = request.referrer
      current_object.spam = current_object.spam?
    end

    response_for :create do |format|
      format.html { redirect_to current_object.post }
    end
  end

end
