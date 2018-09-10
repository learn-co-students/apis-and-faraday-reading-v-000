class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'LCZEVINJJUPV5L3DY4AG0X0HR34TX4WQMSRZPQ0UZ1YV5NA0'
      req.params['client_secret'] = '3SKVIKWFZCBWG4OLC1DDSQYDUCS4UFORXNDR3IMMK5C5GQ1C'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

    body = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end
    render 'search'
  end

end
