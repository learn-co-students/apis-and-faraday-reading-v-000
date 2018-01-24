class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'YJBNFF2EHNAXZJ0ERKKF2GSKO11PTYOJTGRUWZHICDB4F33X'
      req.params['client_secret'] = 'HQYC1LTGSQTJO0C0T2MJZNFZS1Q1GWJU5QI3QA1JUFM5YT33'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    @venues = body_hash["response"]["venues"]
    render 'search'
  end
end
