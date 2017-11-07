class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @response = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |request|
      request.params['client_id'] = 'OL2EVMCCCI2H3MHFANMRP5MYWCANQCBG00T2NUZ3VFZCA3KY'
      request.params['client_secret'] = '10R3P3RSIEFHTGSW0SLK5FE2QNYL44QEKK4DF0VHKRUGUHPZ'
      request.params['v'] = '20160201'
      request.params['near'] = params[:zipcode]
      request.params['query'] = 'coffe shop'
    end
    body_hash = JSON.parse(@response.body)
    if @response.success?
      @venues = body_hash["response"]["venues"]
    else
      @error = 'Please enter a valid zip code'
    end
  rescue Faraday::ConnectionFailed
    @error = "There was a timeout. Please try again."
    render 'search'
  end
end
