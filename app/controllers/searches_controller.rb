class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '5CKWAY3QJKWVEI3QW53RNVV0OGJZMOG5OD3IZ0FPBM3N3OLS'
        req.params['client_secret'] = 'TSC2RZAOSUX3ASM4TFMXOUSUWJGS1GKLNWPJLMI50ZM5DIHR'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'restaurant'
        # req.options.timeout = 0
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
