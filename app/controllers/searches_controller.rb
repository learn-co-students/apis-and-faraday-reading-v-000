class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '4HZT4OFM0X5K0ZEJKWPIPFHLUA1VHC2WZY1QLOGDAMZMFPOT'
        req.params['client_secret'] = 'UUSD43X55G42B4ALWBJQFJVVZ1TGS1SNBMF1KZOH1EGM1CHA'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        req.options.timeout = 20
      end
      body_hash = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end

end
