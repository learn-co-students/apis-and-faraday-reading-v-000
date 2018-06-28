class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @res = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'id'
      req.params['client_secret'] = 'secret'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@res.body)
    if @res.success?
      @venues = body_hash['response']['venues']
    else
      @error = body_hash['meta']['errorDetail']
    end

  rescue Faraday::ConnectionFailed
    @error = "There was a timeout. Please try again."
  end

    render 'search'
  end
end
