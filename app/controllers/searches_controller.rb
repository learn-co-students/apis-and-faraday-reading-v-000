class SearchesController < ApplicationController
  def search
  end

  def foursquare
    # @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
    #   req.params['client_id'] = 'IQ0HZ4JSZ1BSTZGXJYACXZOD35BEJGTV5CMBAEUQOJ2YY5QK'
    #   req.params['client_secret'] = '2QF1VPFW5V2BPHK0ZOZH2BGJMKDFTKQH3F0KB3CPEKOUP3O5'
    #   req.params['v'] = '20160201'
    #   req.params['near'] =  params[:zipcode]
    #   req.params['query'] = 'coffee shop'
    #
    # end
    #   body = JSON.parse(@resp.body)
    # if @resp.success?
    #   @venues = body["response"]["venues"]
    # else
    #   @error = body["meta"]["errorDetail"]
    # end
    # render 'search'
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'IQ0HZ4JSZ1BSTZGXJYACXZOD35BEJGTV5CMBAEUQOJ2YY5QK'
        req.params['client_secret'] = '2QF1VPFW5V2BPHK0ZOZH2BGJMKDFTKQH3F0KB3CPEKOUP3O5'
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

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'

  end

end
