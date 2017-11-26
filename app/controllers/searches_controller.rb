class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'LXMXTHR2QLOHJI34GU3SI15K33T3505LUR2QSF4JNKER25VV'
        req.params['client_secret'] = 'ZNPHHGJYCSTSO2TQD3WJAPU3YD0UF3W1JV1DO4FV5VEXRIWU'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
    end
    body  = JSON.parse(@resp.body)
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
