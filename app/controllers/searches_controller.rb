class SearchesController < ApplicationController
  def search

  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "FFTAH4E2FLQ1NT0NYMOXRZ3Z1JWSL1TJLGVVKNVKQTW5QLWZ"
      req.params['client_secret'] = "G4JG4CDQVNESUWHRGAVXEBMDUHEJUTBHPZ3IUABOGVP2Z5QV"
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body_hash["response"]["venues"]
    else
      @error = boby["meta"]["errorDetail"]
    end

  rescue Faraday::TimeoutError
    @error = "There was a timeout. Please try again."

  end
    render 'search'
  end
end
