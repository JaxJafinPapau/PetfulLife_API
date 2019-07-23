class ApplicationController < ActionController::API
  def user_exist?(id)
    begin
      User.find(id)
    rescue
      nil
    end
  end

  def pet_exist?(id)
    begin
      Pet.find(id)
    rescue
      nil
    end
  end

  def product_exist?(id)
    begin
      Product.find(id)
    rescue
      nil
    end
  end
end
