class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'TZ2ZUMPFTCFIDPVDPKGAW41K5OWA2VJKL54NBV33ISHCV2T1'
      req.params['client_secret'] = 'RIPF1DCG33EZPTXNKQETTMJKO3T0YPRMWMSOKAPXGHERUBLZ'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    @venues = body_hash["response"]["venues"]
    render 'search'
  end
end
