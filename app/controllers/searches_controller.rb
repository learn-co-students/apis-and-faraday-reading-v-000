class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
   @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
       req.params['client_id'] = '1CTN5VPUNJCR5OGJCDYPSAX35XU1ELVFBFSZMLYXZKX1XJP1'
       req.params['client_secret'] = 'VUAKM3KHYLM0TGL0ROJ1KWG00FTTL1K5R45SM1XMDPKVNETL'
       req.params['v'] = '20160201'
       req.params['near'] = params[:zipcode]
       req.params['query'] = 'coffee shop'
       req.options.timeout = 0
     end
     body = JSON.parse(@resp.body)
     if @resp.success?
       @venues = body["response"]["venues"]
     else
       @error = body["meta"]["errorDetail"]
     end

   rescue Faraday::TimeoutError
     @error = "There was a timeout. Please try again."
   end
   render 'search'
    end

  end
