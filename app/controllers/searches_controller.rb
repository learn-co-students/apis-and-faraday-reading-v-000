class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "WFIDWX3KML04MDWJM40UVZCYP1DX4BBJJI4TNLSRJWU5ZW1Z"
      req.params['client_secret'] = "JULDSQUCAR5STQ4BMDMO23PHMWMBQ4IGWPFHCZ000N0R04QE"
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    @venues = body_hash["response"]["venues"]
    render 'search'
  end
end
