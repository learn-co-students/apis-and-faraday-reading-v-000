class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "VIVV0T0S2K3YUU3OMGLFMDX2DSX52VYKZHCUV1D5WHIAZE0U"
      req.params['client_secret'] = "EFYLYH4UIIO1CABH2OMSCIZF0SFKH5FDOXWBBOHKHTS5MOAG"
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end
    render 'search'
  end
end
