class SearchesController < ApplicationController
  def search
  end
  def foursquare
    Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['VEB0OAQTYTHNGDJNMGQCC2JVXXSMEAVFNZKFQBYYN3DHSF0U'] = client_id
      req.params['AISKI0PBVU2QMEK3030S0WLYM2KOGOBQYD4MUYCQFEUFRC3A'] = client_secret
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    @venues = body_hash["response"]["venues"]
    render 'search'
  end
end
