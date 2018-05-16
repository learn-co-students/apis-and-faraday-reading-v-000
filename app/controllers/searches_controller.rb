class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'TFN1RXWBTHEH3AM4NUQYJH2TYRWQBIPNVE3JRJCSXZUMWSMO'
        req.params['client_secret'] = 'MJK3OCIXMQ3ZEAJHBKNKUIHSGV0HGFR1KWPVMQCWSFJ5M5EK'
        req.params['v'] = '20160201'
        req.params['m'] = 'foursquare'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        req.options.timeout = 20
      end
      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = "Please enter a valid zip code."
      end
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
