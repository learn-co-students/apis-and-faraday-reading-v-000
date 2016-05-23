class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search/' do |req|
      req.params['client_id'] = 'FEJJRBPLISE1M0QBBKMX2CORRHDAXCZMI4VB0IUUFGPY0VKF'
      req.params['client_secret'] = 'B21ISM0PQYKRWZEKQXCQAXFUDJ2FNMOAMWYR1EXUJFDPW3CN'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    @venues = body_hash["response"]["venues"]
    render 'search'
  end

end
