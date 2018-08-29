class SearchesController < ApplicationController
  def search
    render 'search'
  end

  def foursquare

    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '0W4LE0J2UHWQUYV5EUIGLOK15H1UK2FI23N2JUK00Z4DCXNH'
      req.params['client_secret'] = 'OWUHU1CDMNK0IOXU3ROQC45OKIUGVVCYCOWL1ZXZJFRTEZUX'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    @venues = body_hash["response"]["venues"]
    render 'search'

  end

end
