class SearchesController < ApplicationController
  def search
  end

  def foursquare
  	begin
	    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
	      req.params['client_id'] = 'C2AEVHMI0EZPNZ1MOIS2X4ON1WWF2HGBMUD3G0PVYZRKO1AF'
	      req.params['client_secret'] = '3CFUBXKDN4GWAD1Z0O4N5V4W1DSBLBW5W1EP13T5NN4V2RK5'
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
