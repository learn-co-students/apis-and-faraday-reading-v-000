class SearchesController < ApplicationController
  def search
  end

  def foursquare
     begin
       @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
           req.params['client_id'] = "SWELNUV1IEP4EZHHBFIS2ETCWWP1DPAB2JBMZ43NWUK32HB4"
           req.params['client_secret'] = "OM1D5XT3K0ZPDQVH05BQ5PYUUILCCYZ2JFQN3TFOOFOSLBFK"
           req.params['v'] = '20160201'
           req.params['near'] = params[:zipcode]
           req.params['query'] = 'coffee shop'
          #  req.options.timeout = 0
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
