class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = "LXGDDJC41OWZUD1ZEPAHZ5ZGOKCTTRLQO4KT2FCYSFPBCUDJ"
        req.params['client_secret'] = "MRYB2PZUCEORRR123EQ5UQQDSL1YR3JX10EIL15VG2NIYAK5"
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

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end

    render 'search'
  end
end
