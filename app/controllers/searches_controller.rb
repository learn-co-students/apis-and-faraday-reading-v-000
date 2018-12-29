class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'KJD5GFVN0KXONXTYY5SOYTRQDVNL1RXUZZX0Z5WVC53UKZSO'
        req.params['client_secret'] = 'PRB505WO4MJ01T43E5EN1ZFLRK5SFCWPBCU30GOFSU113Q2P'
        req.params['v'] = '20181229'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffe shop'
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
