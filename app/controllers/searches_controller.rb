class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'ETLA00NSLCAR4SJF04MINLGABU2OLKNSEUJOHPKI5NHV3FUB'
        req.params['client_secret'] = 'LLMSJEYVPEDRASQYY3ZBXLZL3KB3N4F1KEUR0BLWSELIIM20'
        req.params['v'] = '20160201'
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
        @error = "There was a timeout. Please try again."
      end

      render 'search'
  end
end
