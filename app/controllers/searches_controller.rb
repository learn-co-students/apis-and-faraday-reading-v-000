class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'XJFAG2X3JXZ5GSSN52SWFLV2PGH2GPB0VNPSSAHBZRFHXR21'
        req.params['client_secret'] = 'E14TV0XHIQOCOYSWXIORH440G0FHLVANU0AAG1ROMJYZWEUD'
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

      render 'search'
    end
  end
end
