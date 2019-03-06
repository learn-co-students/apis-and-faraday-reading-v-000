class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '3Y5P203OYNS20Q1W2FSH4PJGD3Y5AJSA5UKKN3RPBVXW0EBH'
      req.params['client_secret'] = 'Y14RAIYDPFJKEKZAAUVXQSIIIVSDQGD3L5C4T14VNUFLYCEM'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

    body_hash = JSON.parse(@resp.body)
    @venues = body_hash["response"]["venues"]

    render 'search'
  end
end
