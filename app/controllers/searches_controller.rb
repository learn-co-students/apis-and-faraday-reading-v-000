class SearchesController < ApplicationController



  def search

  end
 def foursquare
    @resp =  Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '1MT5HVT1HSZF3BT31SLBZJXPQFZGSHZXY4GX01WUONSRYD5X'
      req.params['client_secret'] = 'AYFO3TLQO1PQZXMEBM1BTFHGHAWPO5T3AHVJOUUS2KUIW0QL'


      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

    body_hash = JSON.parse(@resp.body)
    if @resp.success?
    @venues = body_hash["response"]["venues"]
  else
    @error = body_hash["meta"]["errorDetail"]
  end

   rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end
 
    render 'search'
  end


end
