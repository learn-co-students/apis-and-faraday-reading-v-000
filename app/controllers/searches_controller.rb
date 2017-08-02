class SearchesController < ApplicationController
  def search
  end

  def foursquare
    # @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
    #   req.params['client_id'] = 'KLUFNP3YYIGN30NOZ4J0NV5D5TFRBFZHQOYT3V05ONRHMRKG'
    #   req.params['client_secret'] = 'R5MN0WMDQPAVHWSWY1TD0WABXFE1JLM3R0REC0RLQMQZM1SO'
    #   req.params['v'] = '20160201'
    #   req.params['near'] = params[:zipcode]
    #   req.params['query'] = 'coffee shop'
    # end
    #
    # body = JSON.parse(@resp.body)
    # if @resp.success?
    #   @venues = body["response"]["venues"]
    # else
    #   @error = body["meta"]["errorDetail"]
    # end
    # render 'search'
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'KLUFNP3YYIGN30NOZ4J0NV5D5TFRBFZHQOYT3V05ONRHMRKG'
        req.params['client_secret'] = 'R5MN0WMDQPAVHWSWY1TD0WABXFE1JLM3R0REC0RLQMQZM1SO'
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
