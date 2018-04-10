class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'IGDYKJKXN51QLF51QJS4W5WQCMIGTI04WETJ1NIPMKPTGCBX'
      req.params['client_secret'] = 'BN0JNIX2L4PSGKGTD2Q4HUILUC0UYKHBTMPNB1BWRT4ZOXGJ'

      req.params['v'] = '20180101'
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
    render 'search'
  end
end
