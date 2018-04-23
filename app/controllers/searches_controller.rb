class SearchesController < ApplicationController

  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'YALV0GTTYCM00LV4X3QWBTQO2ZO5ZAZBY1LCFEEWBSCHFKQG'
        req.params['client_secret'] = 'IMNRNHGKAW4KEU5TKVFWADPXLJPABQOGGAMH2KYXDDP5K00N'
        req.params['v'] = '20180423'
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
    render'search'
  end

end
