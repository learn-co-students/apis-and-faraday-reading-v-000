class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
  @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
    req.params['client_id'] = 'MBM3IVXJSOE00H5ABXOIJJFHLYT4C1HAWIE3KP3YLRXLUGDM'
    req.params['client_secret'] = 'PO5JOGYSLTOJWEZ3JU02EJXPQT0UOCJTMDUNNJQDRS20JR1M'
    req.params['v'] = '20160201'
    req.params['near'] = params[:zipcode]
    req.params['query'] = 'coffee shop'
  end
  body = JSON.parse(@resp.body)
  if @resp.success?
    @venues = body["response"]["venues"]
  else
    @error = body["meta"]["errorDetail"]
  end

rescue Faraday::ConnectionFailed
    @error = "There was a timeout. Please try again."
  end
  render 'search'
end
end
