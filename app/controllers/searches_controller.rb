class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
   req.params[VMYWR212TODAB5T3T5QBA2YNIQDDJQNKU5ZQ23Z0OIE5X2N3
] = client_id
   req.params[RY52PIVSVZCRVM4HKBRBYCA5YTPMLVRBD3AOKOUED523SUW1
] = client_secret
   req.params['v'] = '20160201'
   req.params['near'] = params[:zipcode]
   req.params['query'] = 'coffee shop'
 end
 render 'search'

end
end
