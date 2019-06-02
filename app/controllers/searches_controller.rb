class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = BJMVWKEV1NU0HW21SEUC1AHG04HVPUYUNYMVPYEMJGUKNB0N
      req.params['client_secret'] = H0MZMFBBGAK0EHAMGZQFI0Y3UNIQ0XE0AUF0F2NW4AZBBOVX
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    render 'search'
  end
end
