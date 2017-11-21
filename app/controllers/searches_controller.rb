class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'TSVY0B0JCHEWJGIP3FVTUAZ4RR04A0UFZLQBN0COUGSHMYRW'
        req.params['client_secret'] = '5THS3PK0EGR5VWSINWRMZDGV5YIROKE03LL30LZNWMUH5F1T'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        
      end
      body_hash = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body_hash["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please Try again"
    end
    render 'search'
  end
end
