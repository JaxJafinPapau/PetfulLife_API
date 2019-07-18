class UpcItemDbService
    def initialize(upc)
        @upc = upc
    end

    def response
        response = conn
        JSON.parse(response.body)
    end

    private

        def conn
            Faraday.get("https://api.upcitemdb.com/prod/trial/lookup?upc=#{@upc}")
        end
end