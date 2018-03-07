class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '4CHDJ0HWEH2TQ4QGG0GQHTGIFPFWIGDPMMQKTL2FOQXVEUGP'
      req.params['client_secret'] = 'KZNGNULLCGDMHNURGMKJPYG3K2WDB233FCZUUGPBE4BWHAVB'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    @venues = body_hash["response"]["venues"]
    render 'search'
  end
end
