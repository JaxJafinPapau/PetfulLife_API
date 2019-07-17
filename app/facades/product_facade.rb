class ProductFacade
    attr_reader :id,
                :name,
                :avg_price
                :upc

    def initialize(upc)
        @upc = upc
        @id = product[:id]
        @name = product[:name]
        @avg_price = product[:avg_price]
    end

    def product
        db_product = Product.find_by(upc: @upc)
        return db_product if db_product
        new_product = EbayService.new(@upc)
    end


end