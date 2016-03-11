class SearchesController < ApplicationController
  def search
  end

  def foursquare
   begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = "AXNW5D2MYJW40JNHFANVKOJY4IVWGATEJGR5LKENX25ZIKQX"
        req.params['client_secret'] = "F2OG0YNDO3EFEBBF3MKHBWUHTHZQ321YU03LS3CR3BPRA4RN"
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        # req.options.timeout = 0
      end
      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end
 
    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
