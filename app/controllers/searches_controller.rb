class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'NJELLRU0BS5KQOQGTYN5FL2NSHGVYM135TLBIWQT51VYYUVU'
        req.params['client_secret'] = 'N4XIAYZRBXJ2M145YDXHGGPX0BGC0L5EG5VIVPMLQ2KPXRMQ'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        req.options.timeout = 0
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
