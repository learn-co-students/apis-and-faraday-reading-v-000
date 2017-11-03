class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
          req.params['client_id'] = 'KAGRCKPW4CNW1S3CL2B3NQBFU5DPVKVTV1UAVB0MUPFQVOSX'
          req.params['client_secret'] = 'HXTVO0WCSFYQPULURBMQ1LT5QHMQ0LYQAIL3G3C1XKD2TIW0'
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
