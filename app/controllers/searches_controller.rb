class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
          req.params['client_id'] = 'DHAUWU1EWOJ3JBKXCN52PEFMGYZWGZGL0CXIUGTJJKFFM3B2'
          req.params['client_secret'] = 'Q0RDRGPOCD4ELCGX1KHVKXH5CS4LPXGQT13Q3OSLMJJYZQOA'
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
