class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'Y1U4TDWGE4EUZ35KUCSGNRP3IRFA5X32URM5EOFEBXPSSSFW'
        req.params['client_secret'] = 'B1IRM1SYF53UJKU4CICVMUTY0ZTP3BL1FZCBPVNLAHG5DZC2'
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


