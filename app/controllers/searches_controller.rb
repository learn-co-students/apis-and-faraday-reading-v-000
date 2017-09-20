class SearchesController < ApplicationController
  def search
  end

  begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
          req.params['client_id'] = L5IDMC0UN55N4Q5JVGD00JPSFMFD2GMMJSPRMHEFMJVDNDET
          req.params['client_secret'] = Y3MUA4NFMMT31GBRFFSKTDCM1CT0ZXEGBTDZUNAFC0A3BRSF
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
