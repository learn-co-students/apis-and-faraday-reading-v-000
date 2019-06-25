class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
        @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
            req.params['client_id'] = 'AG0R3MRNMWHCYCFUS4PQFHG2T0HYOJMGHC4IEIAZYEH4BEZU'
            req.params['client_secret'] = 'U22SEK04TXWFOVYTWZTGF5H0QG3L5XJBTTQLLHJPFN0NZ0BH'
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
