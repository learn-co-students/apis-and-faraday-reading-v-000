class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
          req.params['client_id'] = "L0LHVR3MSMVBIPIWVF0GFCND5S05EMHDCZ0E43AUBIG5ADMZ"
          req.params['client_secret'] = "GHA1NENAFCVI1I1HAELLPWK1VVLBNK0E0N0N5YDKN0LQQDZI"
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
