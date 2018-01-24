class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'F2Y3XIIVAXX0XABTCCIBRW2OJBFLBOKX2XL5GM34WCEKADB0'
      req.params['client_secret'] = 'TLEMABJOF5BDK2ZY1XPNCIU3RCTKGHPOC2XF1PIUY1DOYZME'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
  end

  body = JSON.parse(@resp.body)
  if @resp.success?
    @venues = body["response"]["venues"]
  else
    @error = body["meta"]["errorDetail"]
  end
  render 'search'
end
