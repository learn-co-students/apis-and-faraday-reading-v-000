class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      resp = Faraday.get('https://api.foursquare.com/v2/venues/search') do |req|
        req.params['client_id'] = '44KRSHKDSLTQP5X0AZNZTGS1IYGLCDT2ETCWDRP5PQUNWFH3'
        req.params['client_secret'] = '3PLD3TGQWLYVBMTESC20EGMGKFCDTAPDQ5XNNA0EL5AAYPOA'
        req.params['v'] = '20170706'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end
      
      body_hash = JSON.parse(resp.body)
      
      if @resp.success?
        @venues = body_hash["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end
      
      rescue Faraday::TimeoutError
        @error = "There was a timeout. Please try again."
    end
    
    render 'search'
  end
end
