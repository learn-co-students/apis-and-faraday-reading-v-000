class SearchesController < ApplicationController
  def search
  end

  def foursquare
	begin
	    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
	        req.params['client_id'] = "CRO52RUF2ZTGIQOQODTWB0FETIU1TDHHG0MXM1HQ2YQ4K2IX"
	        req.params['client_secret'] = "0YXIEYKK5GFYZ44XWYBIE2RAPBBQ3JEGOEMQW52XUC0QJGO0"
	        req.params['v'] = '20160201'
	        req.params['near'] = params[:zipcode]
	        req.params['query'] = 'coffee shop'
	        req.options.timeout = 100
	      end
	      body = JSON.parse(@resp.body)
	      if @resp.success?
	        @venues = body["response"]["venues"]
	      else
	        @error = body["meta"]["errorDetail"]
	      end
	 
	    rescue Faraday::TimeoutError
	      @error = "There was a timeout. Please try again."
	    end
	    render 'search'
  end
end
