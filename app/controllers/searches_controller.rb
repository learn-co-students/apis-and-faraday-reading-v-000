class SearchesController < ApplicationController
  def search
  end

  def foursquare
  begin
  	@resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
  		req.params['client_id'] = "P0MTEJYPSZFGOV2YD3LD11CMLKTUJ2IF3UHK3ITVFOSP2YIY"
  		req.params['client_secret'] = "H2S1SUYRXZAPKMYTJJE5USCTOPARBTOCA2JDLMZ3EQFSEKAE"
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

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end
  	render 'search'
  end

end
