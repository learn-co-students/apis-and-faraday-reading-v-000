require 'pry'

class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
    req.params['client_id'] = "JWCEMY4VUOEUBI0EG4KUTMA1HMHAGNBFPCDC3S3A5EL1OJJC"
    req.params['client_secret'] = "5KLTJ2RZOVHLSXGVSRVNTV4R0GTC4INSNMZZ2CXUX3MDBGRV"
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

    # rescue Faraday::ConnectionFailed
    #   @error = "There was a timeout. Please try again."
    # end

    render 'search'
  end
end
