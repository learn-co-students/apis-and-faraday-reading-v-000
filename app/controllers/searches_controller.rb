class SearchesController < ApplicationController
  def search
  end

  def foursquare
    Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "50UXQ3WILT0OP2VZSTD01Y2W3PHHDKODWRFD4KG3PVDW2ZIK"

      req.params['client_secret'] = "IRXMQIZS3K03V5QIHJ5LMZXTVZIOLPQKTUKZTIWC4OBJ0S0Q"
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    @venues = body_hash["response"]["venues"]
    render 'search'
  end
end
