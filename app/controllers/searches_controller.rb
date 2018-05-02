class SearchesController < ApplicationController
  def search
  end

  def foursquare
  	begin
  	@resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
  		req.params['client_id'] = 'VKF3LKANRXJXYGPJEG4FPJJPNLHPQJI0OCGYZSAMTKSB1BAS'
  		req.params['client_secret'] = 'RHKFYU0ZPC3OQ0Q1CFTV5NCEBYNIF1FSKP52GT4YOG5CZ2O2'
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

  rescue Faraday::ConnectionFailed
  	@error = "There was a timeout. Please try again."
  end		
  render 'search'
  end 
end
