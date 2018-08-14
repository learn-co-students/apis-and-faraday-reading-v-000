class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '5QSAY5QM2TGWBRRBXZU3XVJOBG5U102BPFFIKNP51YEDZTDE'
        req.params['client_secret'] = 'HM4DA3P0AACJ0ARSQ0YRO3AMUUQAOMNMQ4S1WW4EIHR30R2X'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffe shop'
      end
      body_hash = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body_hash["response"]["venues"]
      else
        @error = body_hash["meta"]["errorDetail"]
      end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
