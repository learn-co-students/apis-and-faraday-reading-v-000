class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'H4BT5BFLMLKDEQC3HR2SSVHH0W4FAY3SHFXC5NRQRKKII120'
      req.params['client_secret'] = '4HPBW54SLNSJSIHB3KGRK52THK5HLIDVJ4LFYDM3WSXSMVTG'
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
