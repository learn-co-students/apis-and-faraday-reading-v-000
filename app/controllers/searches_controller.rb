class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      client_id = '3ZCKLC3AMVDARNSHVHTMJ10R5YC1M1OPU4SHTJXKK2REZGVQ'
      client_secret = '503RIAC2LZCXV2RYXKOHDXIHK0L5EYIXC4HXHSMZFAVVJOU2'
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = client_id
        req.params['client_secret'] = client_secret
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        # adjust the time for the query to happen before throwing error from time out
        req.options.timeout = 23
      end

      body_hash = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body_hash["response"]["venues"]
      else
        @error = body_hash["meta"]["errorDetail"]
      end

    rescue Faraday::TimeoutError
      @error = 'There was a timeout. Please try again.'
    end
    render 'search'
  end

end
