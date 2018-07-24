class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'KCPJYKE3TISAHGFWPZF0ISQ4HLJJWQ4WKA3DWHPSB5WWXJQ1'
        req.params['client_secret'] = 'TJ10GRCRH2LXDDBT2AZRRZ1FBVYKLHBZTTE3Z31XX3JLIZVT'
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
