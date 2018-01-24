class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id']="Z0OZTUREXF4PQAQYQR55HAED41CK3SYCUXOLCQJLYFJTKGYG"
      req.params['client_secret']="1DDMOSBSYT1ZVFUWPNZUOT2W21SJBU0C5R2RQEFRATQUKX1C"
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)

    if @resp.success?
      @venues=body_hash["response"]["venues"]
    else
      @error=body_hash["meta"]["errorDetail"]
    end
    
    render 'search'
  end


end
