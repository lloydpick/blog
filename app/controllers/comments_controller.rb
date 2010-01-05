class CommentsController < ApplicationController

  has_rakismet :only => :create

  make_resourceful do
    actions :create
  end

end
