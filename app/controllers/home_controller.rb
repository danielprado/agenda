class HomeController < ApplicationController

def index
  redirect_to user_contacts_path(current_user)
end

end
