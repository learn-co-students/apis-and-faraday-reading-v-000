class SearchesController < ApplicationController
  def search
  	# binding.pry	
  end

  def foursquare
  	begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '0ZSPDFCXHQDEQTAFCOPJYB33MORUV3EIZXALQAD4WSTBIG0M'
        req.params['client_secret'] = 'BZLJBRZ2DPCGFH4HAOXJTW3YTICWW3VGKLPIOYZDB2QAWMHN'
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
	  render 'search'

	rescue Faraday::ConnectionFailed
        @error = "There was a timeout. Please try again."
    end
  end
end