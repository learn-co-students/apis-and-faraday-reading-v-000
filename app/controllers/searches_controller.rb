class SearchesController < ApplicationController

  def search

  end

  def foursquare

    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '0VNIVSMDP2U0Y3K5HWTW2BK4EEVSX5DBAFJ5HTYZ14AR0WMN'
        req.params['client_secret'] = 'HUZNWTS3032J010DYDCWHLI3IGF3TAXRCJLRNEJKQTLIVQGP'
        req.params['v'] = '20181025'
        req.params['near'] = params[:zipcode]
        req.params['query'] = params[:query]
      end
      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]

      end

    rescue Faraday::ConnectionFailed
      @error = "So Sorry, but there was a timeout (whatever that means!) Please try again."
    end



    render 'search'
  end
end
