class SearchesController < ApplicationController
  def search
  end

  def foursquare

      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'NC4MEAYOA1YYYTQPFGSI2GS13MEYVF00KWQIBBX0OWI1S0GI'
        req.params['client_secret'] = 'SXKMCV5YNLSCHHLB41CJU4RTBTYXUHRV3WIQRXIEOH0WVX0U'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        req.options.timeout = 0
      end
      body_hash = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body_hash["response"]["venues"]
      else
        @error = body_hash["meta"]["errorDetail"]
      end
    rescue Faraday::TimeoutError
        @error = "There was a timeout. Please try again."
    end
        render 'search'
      end
end
