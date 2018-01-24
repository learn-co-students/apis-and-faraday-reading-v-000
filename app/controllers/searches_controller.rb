class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '4E3IM3PDBGRJZ05POD3Z1VKWBI0H1FH5WXWPDIZO3XG3QBYH'
      req.params['client_secret'] = 'ZNWEVSN0SBWRO2OEJS53WFQT3M0D5RSQM0PKP1XDWNCQZ2LQ'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    if @resp.success?
        @venues = body_hash["response"]["venues"]
    else
        @error = body["meta"]["errorDetail"]
    end
    render 'search'
  end
end
