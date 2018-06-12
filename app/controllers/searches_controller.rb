class SearchesController < ApplicationController
  def search
  end

  def foursquare
      @resp = Faraday.get('https://api.foursquare.com/v2/venues/search') do |req|
          req.params['client_id'] = 'PWOR2QEAHSWGPMCV4JY23MIR21OIYXFESJ41RMXLQ0PYRNVQ'
          
          req.params['client_secret'] = 'VIHWXVDEVJS44EKLOZQ5NXDRF3R3YQW124VE1C4QTNXIMLQ0'
          
          req.params['v'] = '20180612'
          
          req.params['near'] = params[:zipcode]
          
          req.params['query'] = 'coffee shop'
      end
      body_hash = JSON.parse(@resp.body)
      @venues = body_hash['response']['venues']
      render 'search'
  end
    
end
