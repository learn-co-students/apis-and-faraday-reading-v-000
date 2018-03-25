class SearchesController < ApplicationController
  def search
  end

 def foursquare
    #make request to API endpoint
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      #Faraday allows us to pass block to get method and add any parameters via a hash of params
      req.params['client_id'] = ''
      req.params['client_secret'] = ''
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    #obtain venues from JSON object

    body_hash = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body_hash["response"]["venues"]
    else
      @error = body_hash["meta"]["errorDetail"]
    end
    render 'search'
  end

end


