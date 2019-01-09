class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'MFD4CHTLDAWOCQC25N3A2WVJP4IYFI2FGXG5REUILTBWQUHV'
        req.params['client_secret'] = '4TW5E15QR5W5FB2CI5RAI3IOZHHQ4MBF5KC5COANIELR3G0C'
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
      @error = "There was a timeout"
    end
    render 'search'
  end

end
