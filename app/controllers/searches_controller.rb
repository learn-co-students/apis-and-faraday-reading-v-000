class SearchesController < ApplicationController
  def search
  end

  def foursquare
    
    # Note : Make call to API
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'D04PG4S005F25WR1YZKT5AIEIO0WMERHV4QEVUS3LDX41HBW'
      req.params['client_secret'] = '12PNYETGP2UIY5WWVUFTLGXF3KYHS4ZUXWWPFFE5V4FTBLVQ'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
      
      # NOTE : Below used to force a request timeout (for checking)
      # req.options.timeout = 0
    end
    
    # Note : Pull data from API response -> Change from JSON to Ruby Hash
    body_hash = JSON.parse(@resp.body)
    # NOTE : No error validation ==> venues = body_hash["response"]["venues"]
    
    # NOTE : With error validation (could use "@resp.status == 200" as well)
    if @resp.success? 
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end

    # NOTE : Used to "rescue" timeout errors
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end

    render 'search'
  end

end
