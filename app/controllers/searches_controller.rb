class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'JR5KLHKKTWURSG5KP3L4J3MAFV3LXOKTJI0FXMQHMQPEYPIE'
        req.params['client_secret'] = 'VQ5RMC4UTB3RACU5DGUAZT5LY1NCY1MWGYPSVUUSUK1X3OSR'
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

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
