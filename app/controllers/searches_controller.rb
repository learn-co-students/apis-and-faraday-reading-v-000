class SearchesController < ApplicationController
  def search
  end

  def foursquare
  	@resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
  		req.params['client_id'] = 'PTZDVCHEQUZTMDCVL2VXQK14I12R2EJCVQJOWSU3LB01US33'
  		req.params['client_secret'] = 'QGQE2HHBN3HPZIUHEDZG44ZT55FHX1VMPTQAEIJT15OBTYIC'
  		req.params['v'] = '20160201'
  		req.params['near'] = params[:zipcode]
  		req.params['query'] = 'coffee shop'
  	end
  body_hash = JSON.parse(@resp.body)
	  if @resp.success?
	    @venues = body_hash['response']['venues']
	  else
	  	@error = body_hash['meta']['errorDetail']
	  end
  
  render 'search'
  end
end
