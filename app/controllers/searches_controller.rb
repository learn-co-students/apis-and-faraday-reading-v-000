class SearchesController < ApplicationController
  def search
  end

   def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '3BL5P4PQNVWBJPJ53BHQMHW2HSO53ZHSMXLZB50BEJ0TJL0V'
      req.params['client_secret'] = 'U4F4BCXEXDOVQTZUD5OTZZJ4XDGSV5YQZIB3FZTMBR51Q25V'
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

