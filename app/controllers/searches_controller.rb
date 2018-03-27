class SearchesController < ApplicationController
  def search

  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'OF4BEWF50S3SOLMVOCP11RBACRDGYGFYP13S3OD2I3EY15N4'
        req.params['client_secret'] = 'JO2YIDJP2CX54GORYYDPHSAXCGTNYP14VNK5LSYMNBUVAOF4'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        # req.options.timeout = 2000
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
