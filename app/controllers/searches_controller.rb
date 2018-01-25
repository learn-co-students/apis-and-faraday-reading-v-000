class SearchesController < ApplicationController
  def search

  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '5O1QL5LCGCHXXF5QKRMG04VSIUQS1SYE1U5EXR101IC1LGR3'
        req.params['client_secret'] = '2IFPIDOA3GJ1XDFLQMZGR3GOR11UIDT0P2ITQHFM3YYLP03J'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        req.options.timeout = 0
      end
      body_hash = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body_hash["response"]["venues"]
      else
        @error = body_hash["meta"]["errorDetail"]
      end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    
    render 'search'
  end
end
