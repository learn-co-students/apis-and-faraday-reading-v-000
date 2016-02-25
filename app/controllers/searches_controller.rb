class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params[:client_id] = 'id'
      req.params[:client_secret] = 'secret'
      req.params[:v] = '20160201'
      req.params[:near] = params[:zipcode]
      req.params[:query] = 'coffee shop'
      # req.options.timeout = 0
    end
    body_hash = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body_hash['response']['venues']
    else
      @error = body_hash['meta']['errorDetail']
    end

    render 'search'
  end
end
