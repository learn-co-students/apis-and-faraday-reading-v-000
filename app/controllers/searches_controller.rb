class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'JB33CP3A4GXT1NOIYN1NNYGFZ54QWTGXHZKF52DVPSBZ3CJK'
      req.params['client_secret'] = 'QVYX1F1PIXVIWYPQR1LNW41LKHUGLCXWQC3WRQIBS3PUKVH1'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end
    render 'search'
  end
end
