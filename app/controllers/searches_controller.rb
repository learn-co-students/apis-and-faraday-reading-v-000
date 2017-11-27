class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'ABZUYKBVZ5YACP1CP0FMSC01UXTOBKRUBXFMM0MIYO51VO52'
        req.params['client_secret'] = 'HLEXZG4Z4DJQ3L5SVDR1ZDDE0B5QTOP3KZKQUDO1YJZYXPVF'
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
