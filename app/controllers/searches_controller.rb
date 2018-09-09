class SearchesController < ApplicationController
	def search
	end


  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '3VFL5GOCYMI0OQYTDAKCHTOSKYFK3GNVTZII31KFP4NXHXXU'
      req.params['client_secret'] = '0HSEOOS3YY5J4F2NFERCGN0ZLAK55OYEL0COMSSXYBOV5PD1'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
 
    body_hash = JSON.parse(@resp.body)
    @venues = body_hash["response"]["venues"]
    render 'search'
  end

end

