class SearchesController < ApplicationController
  def search
  end

  def foursquare
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = LQV1LSWA3CEHULYZ1SL5J5DFS2XEDT0V0W2Z0DNG15Y2D4OM
      req.params['client_secret'] = GEC51G4VMG0J4LNNHXEZJ1SBOT0LP03P12T5NZCKM5QZKLCL
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
