class SearchesController < ApplicationController
  def search
  end

  def foursquare
  	@resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
  		req.params['client_id'] = "WFO2GVKGNQMOQ5QJZ0G2BPEXVD1SKXNJKLG0H01ATUYOYJXO"
  		req.params['client_secret'] = "TBO4UA0NQUAORWZX4ADKKVLNAR0UCE4ZXA3BQL5P2FOXQKEI"
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

		# rescue Faraday::ConnectionFailed
		# 	@error = "There was a timeout. Please try again."
		# end
  	render 'search'
  end
end