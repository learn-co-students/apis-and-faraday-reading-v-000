class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "WPN2RZSNIRPBJ2O0RG4DST0R35UN505S2X430UOJBNUZVFZL"
      req.params['client_secret'] = "XWVCWRIROEGQIJAXKH1DIURDFQXVALPYNA3RLTHES12120RZ"
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
