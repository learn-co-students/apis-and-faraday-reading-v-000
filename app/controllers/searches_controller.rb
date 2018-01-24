class SearchesController < ApplicationController
  def search
  end

begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
		req.params['client_id'] = 'CGCDK5N1W0DNAKYUAQ00HRGZ4A0X1NX2SP5ETJ3M52B0K0YL'
		req.params['client_secret'] = 'V1O3S0ELGAXV1W31HK25MHCO0BTXEMMD5LCCAMBQCOIFQPNE'
		req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        # req.options.timeout = 0
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