class ProductFacade
    attr_reader :id,
                :name,
                :avg_price,
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
        new_product
    end

    private

        def new_product
            return { id: nil, name: nil, avg_price: nil } if raw_product == nil
            product = Product.create(name: raw_product['title'],
                           upc: @upc,
                           avg_price: average_price(lowest_product_price, highest_product_price)
            )
            product
        end

        def raw_product
            if get_product_by_upc.response['items'].first.present?
                @_raw_product ||= get_product_by_upc.response['items'][0]
            else
                nil
            end
        end

        def get_product_by_upc
            @_product_by_upc ||= UpcItemDbService.new(@upc)
        end

        def highest_product_price
            raw_product['highest_recorded_price']
        end

        def lowest_product_price
            raw_product['lowest_recorded_price']
        end

        def average_price(low_price, high_price)
            ((low_price + high_price) / 2).to_f
        end
end