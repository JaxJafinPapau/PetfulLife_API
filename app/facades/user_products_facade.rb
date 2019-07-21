class UserProductsFacade
    attr_reader :products

    def initialize(user, products)
        @user = user
        @products = products
    end

    def id
        @user.id
    end

    def email
        @user.email
    end

    def username
        @user.username
    end
end