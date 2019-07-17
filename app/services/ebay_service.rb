class EbayService
    def initialize(upc)
        @upc = upc
    end

    def response
        response = conn.get
        JSON.parse(response.body)
    end

    private

        def conn
            Faraday.new("https://api.ebay.com/buy/browse/v1/item_summary/search?gtin=#{@upc}") do |f|
                f.headers['Content-Type'] = 'application/json'
                f.headers['X-EBAY-C-ENDUSERCTX'] = 'affiliateCampaignId=<ePNCampaignId>,affiliateReferenceId=<referenceId>'
                f.authorization :Bearer, ENV['EBAY_API_KEY']
                f.adapter Faraday.default_adapter
            end
        end
end