class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp= Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "TUDLRCQIGYNDTWFCEZ5KJWP0M5YLIKHX3FWY1MOEQYISTH3S"
      req.params['client_secret'] = "DK3UKPQVASIWEH0Z0UOHVJYKNBBTN1HN0UMII05H11IOI4O3"
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


#   rescue Faraday::ConnectionFailed
# @error = "There was a timeout. Please try again."
# end

  render 'search'
  end
end
