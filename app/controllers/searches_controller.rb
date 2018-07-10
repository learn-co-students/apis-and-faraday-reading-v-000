class SearchesController < ApplicationController
  def search
  end

  def foursquare
    Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['NJELLRU0BS5KQOQGTYN5FL2NSHGVYM135TLBIWQT51VYYUVU'] = client_id
      req.params['N4XIAYZRBXJ2M145YDXHGGPX0BGC0L5EG5VIVPMLQ2KPXRMQ'] = client_secret
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    render 'search'
  end

end
