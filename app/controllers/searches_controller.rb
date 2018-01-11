class SearchesController < ApplicationController
  def search
  end



  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'U05BQET1EDVEPBMN1X3SZ3GM2NW0BPQ5OMNNFWHHLYCOARKI'
      req.params['client_secret'] = 'R0LIVDFRZMQGZXKGWVNZ2RH5H1NXE2JLYEN2AZP2LQULZGC3'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

    body_hash = JSON.parse(@resp.body)
    @venues = body_hash["response"]["venues"]
    render 'search'
  end
end
