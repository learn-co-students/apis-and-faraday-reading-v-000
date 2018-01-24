class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'XIENCKFVWWHSA1KOPV11HQTKHQVXGJRZELMCZAMZLKRG0JPH'
        req.params['client_secret'] = 'AM5MLVGE4NFY5O24QFO2ZZR3K5I0XW4Y3IVUUQTRTVVYKODH'
        req.params['v'] =  '20160207'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        req.options.timeout = 0
      end

      body_hash = JSON.parse(@resp.body)

      if @resp.success?
        @venues = body_hash["response"]["venues"]
      else
        @error = "Must enter location (ll, zipcode, ...)"
      end

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
