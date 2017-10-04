class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'PEJPUA40W4VNUJUHNU14UALHI3JKYT1LNS5SKWMTBR4J3VXL'
      req.params['client_secret'] = 'VVP2PRW4GGWLQMWCK3E3LM22AOOZNAFW3FSGYK4PKCPPHDGN'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
   body = JSON.parse(@resp.body)
   if @resp.success?
     @venues = body["response"]["venues"]
   else
     @error = body["meta"]["errorDetail"]
   end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
