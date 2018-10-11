class SearchesController < ApplicationController
  def search
  end

def foursquare
    Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = clZSRZPUAPHQ4RKKWMR20PMQPNCPNYPKR5JXEUIM0L34DGJAW1
      req.params['client_secret'] = C0L5ONUHSHCAPJZ3EDYCBRG1LN3XGH3RFKGZMETZUM4IWLOQ
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    render 'search'
  end
end