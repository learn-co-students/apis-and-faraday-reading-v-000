class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'UQMLWMFK4QBWDRDY5LCHGHB4VJC5UOD4XDMXKGYH3K0NBQ4Z'
        req.params['client_secret'] = 'MZVRXZUHUFXPDSTVG0LZSDBNJP1CWJZ0TYRCJSUMXVOAMN32'
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
