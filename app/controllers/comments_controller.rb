class CommentsController < ApplicationController

  make_resourceful do
    actions :create
  end

end
