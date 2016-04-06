class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp= Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'D5NS5FJCUN4JZYZAV0I12TMREUCIHRXNWLAGEPONJIZIHYQO'
        req.params['client_secret'] = 'AMDG3GLFFXIZTVV05R3AG02MPTMPK1W1RYD2POO4IJPBBPNB'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        #req.options.timeout = 0
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
      render  "search"
  end


end
