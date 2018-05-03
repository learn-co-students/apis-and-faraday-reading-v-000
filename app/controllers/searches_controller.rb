class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'Y42NNKS20OWLTS2NWRFCIPC15BTCJMVRZMCIV344WJ4HXSEN'
        req.params['client_secret'] = 'W3HJSSFW1GBA1HJELKPXFNEXHWAO4GCKBKHM51C0YRNHZK05'
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
      @error = "There was a timeout. Please try again"
    end

    render 'search'
  end
end
