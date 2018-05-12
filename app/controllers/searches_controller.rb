class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '12XBW0YCY1R2ULMO1HJUD1MSO4JJULJIQARQEEFQ0FU0SLJL'
        req.params['client_secret'] = '0LTNMRGTODODPPT3HFR4LJMXDU0NDUEKXJ01G4IZCWMBQG5Q'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end

      body_hash = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end

      rescue Farady::ConnectionFailed
        @error = "There was a timeout. Please try again."
      end
    end
    render 'search'
  end
end
