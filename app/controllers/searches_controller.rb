class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '2XDNHEYIHQ5EV4RI3IWVZKP42UCFHAPX0IXCULNJ2QSZONO2'
      req.params['client_secret'] = '3O5WSCODVRFS40RACBZPRMG0ANSBFMYMDUENDL0FDH0YKC3C'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    @venues = body_hash["response"]["venues"]
    render 'search'
  end
end
