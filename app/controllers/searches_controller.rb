class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
          req.params['client_id'] = 'J2IX0A1GAGCCIXAUQCAP1B0OH3SAK0LCO1VPEKRCRLTZTSXM'
          req.params['client_secret'] = 'FOWBL1EKGADMTARY3JRMUIPP0PDR5FUQHUW1ZUKGM1135FGS'
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
