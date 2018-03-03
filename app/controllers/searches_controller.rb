class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '34OQYFFB2LAUS2QYNMPIJDUUZGRLGIWER13ALVU3PGPEW1G0'
        req.params['client_secret'] = 'G25ILK5E4CVJ3ICRU3WF4AT5VJG4JCAYJGS40DPOMD2SK2IB'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        #req.options.timeout = 20
      end
      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end

      rescue Faraday::ConnectionFailed
        @error = 'There was a timeout. Please try again.'
    end
    render 'search'
  end
end
