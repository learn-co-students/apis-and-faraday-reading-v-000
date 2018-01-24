class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '3ZKEQKA253RYTT1QH40DVQP31GHAOK1210LIZNVU3MQSS3IB'
      req.params['client_secret'] = 'T2D54HIUWTHWFXVHTJ1AHV34CHVJG5N1AKVQWJVOMRHJUBQD'
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

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end

    render 'search'
  end
end
