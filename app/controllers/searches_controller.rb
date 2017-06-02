class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req| #make request to API endpoint
        req.params['client_id'] = 'ES33SS4IDOPBXUXRBHIR0A1TLKEOKZX1TZAU3EUYTOD5MBGZ' #set params from Postman
        req.params['client_secret'] = 'RABWJ2SMUNZLPC4NTWLZY4NEZYET510320T5B5KUWAYXOD12'
        req.params['v'] = 20160201
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end
      body = JSON.parse(@resp.body) #get venues out of JSON and into
      if @resp.success? #akin to @resp.status == 200, abstraction & god code
        @venues = body['response']['venues'] #variable to use in Ruby
      else
        @error = body['meta']['errorDetail'] #handle error in application
      end
    rescue Faraday::TimeoutError
      @error = 'There is a timeout. Please try again.'
    end
    render 'search' #render search temp again with result
  end
end
