class SearchesController < ApplicationController
  
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'M2TAIVMKINCSZUP54GNBCP551KB01QKVUL3BZ0XOMG5ISPXK'
        req.params['client_secret'] = 'JBJJF0UTVCQDVL05HIIXIJLAVGKKRXG004YV2HHGJBFMNOBS'
        req.params['v'] = '20180501'
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
