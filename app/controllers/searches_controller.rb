class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'GPZPMPCAU4Y4CJA1APRZOOJCC3QXZQ3KGCS4XLQWG0QMLEI5'
        req.params['client_secret'] = 'SLANCO3AAQ11AQLPLE4JEKCTIGCRZVNYQK0VAKGF1R551J2V'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        req.options.timeout = 0
      end

      body_hash = JSON.parse(@resp.body)

      if @resp.success?
        @venues = body_hash['response']['venues']
      else
        @error = body_hash['meta']['errorDetail']
      end
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Pleast try again."
    end

    render 'search'
  end
end
