class SearchesController < ApplicationController
  def search
  end

  def foursquare
      begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'ZSSVSEUM4VGXHVUMCKKAKZS3BHETXKNXATKIRI2TGKB2MTHS'
      req.params['client_secret'] = 'KVK12YE35O50T5LMJLJWFCKOMFB4ZAL1LETZE1TT4MYMZKKJ'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
      req.options.timeout = 0
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
