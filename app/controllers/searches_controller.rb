class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'OGJGXJAD3FFZS4DJLEGOMRFQGPPELSTMNMUPX0HG1P1E4L3G'
        req.params['client_secret'] = 'MNDTC1B5215OJELQTIWPJZE5GBVSNPE04QFTEJKJJI24UM35'
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
      @error = "There was a timeout.  Please try again."
    end
    render 'search'
  end
  
end
