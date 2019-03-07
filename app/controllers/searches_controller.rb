class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'V5L52V0KS3WXYJNYAMNSGHVL5ONEALPOE1HBLDGUDX5MES3R'
        req.params['client_secret'] = 'B3GB02ULZKXQ4ERY4MDBE5GPXEWEW0SR4FKV5YBPV3WA5GOX'
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
