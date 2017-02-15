class UsersController < ApplicationController

def new
  @user = User.new
end

def settings
  @user = current_user
end

end
