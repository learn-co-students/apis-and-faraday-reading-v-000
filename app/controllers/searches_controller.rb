class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'YWFH45P1ZZCWCDTY5SPXUXJAQZSHYDT3L0X3MWHBNIXBRLMI'
        req.params['client_secret'] = '5HOCW5P2YPPXEQWMRXV0BCORNFSDJDCQJEUEPKIQJYIXEH3K'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        # req.options.timeout = 0
      end

      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body['response']['venues']
      else
        @error = body['meta']['errorDetail']
      end

    rescue Faraday::ConnectionFailed
      @error = 'There was a timeout. Please try again.'
    end
    render 'search'
  end
end
