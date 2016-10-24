class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
          req.params['client_id'] = 'WB23AG1GPIJR0VDI1PDX50S0RDAV32EEHLVZ434AMYEQBT0Q'
          req.params['client_secret'] = 'NGTYWVL0TSSMEZ3DHCLDD12GM30MSFM1BJIHINC3HAOV4GA4'
          req.params['v'] = '20160201'
          req.params['near'] = params[:zipcode]
          req.params['query'] = 'coffee shop'
          #req.options.timeout = 0
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
