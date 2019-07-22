class ApplicationController < ActionController::API
    def user_exist?(id)
    begin
      User.find(id)
    rescue
      nil
    end
  end
end
