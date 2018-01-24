class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = "ZTGMXKDNWRMMYZ1QUDCVM4LALVQZ1SNU215JGNIQYJJ4SCD1"
        req.params['client_secret'] = "NPYH0CB5FMFEBLWYAHYEHOFCFGU2HDV51XTRVNCORDXMZA1C"
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        # req.options.timeout = 0
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