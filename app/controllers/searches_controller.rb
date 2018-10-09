class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'UKPE1YRAFAG14X2KH3BGNXWMJ4YHKGBYXA2XTNNFNVPAVUB2'
        req.params['client_secret'] = 'SHRU4FCKQIYJYFNVM5R5BA0S0PT0OCO1LZXK1F0DHOLCUT2Y'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        req.options.timeout = 1
      end

      body_hash = JSON.parse(@resp.body)
      if @resp.success? # is @resp.status == 200
        @venues = body_hash['response']['venues']
      else
        @error = body_hash['meta']['errorDetail']
      end

    rescue Faraday::ConnectionFailed
      @error = 'There was a timeout. Please try again.'
    end
      render 'search'
  end
end
