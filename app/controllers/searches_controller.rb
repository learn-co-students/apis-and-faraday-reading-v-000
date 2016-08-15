class SearchesController < ApplicationController
  def search
  end

  def foursquare
  	@resp =Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'JWOF4PVNBP0SFC3Q2TYP4NYJ4NAFWLS5C0N22BFGWEXCIS3C'
      req.params['client_secret'] = 'PZY4CPO00R3RVQTIQEXMA3IPP0XZMKJJF2TTY1X3ETXTYC1N'
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

	  rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end

    render 'search'
  end
end
