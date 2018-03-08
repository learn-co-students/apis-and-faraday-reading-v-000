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
      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end
      render 'search'
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
end
