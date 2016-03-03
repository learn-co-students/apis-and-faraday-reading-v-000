class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
          req.params['client_id'] = 'R0JRN34GPHQPTX2GMNVAQOCOWDGR5G12HCREMCQREIMN2MRK'
          req.params['client_secret'] = 'FTMRZ54UG1IDBKF1TYUXLKNI4YJYEFSCOD4VXGPERMPN4TKB'
          req.params['v'] = '20160201'
          req.params['near'] = params[:zipcode]
          req.params['query'] = 'coffee shop'
          req.options.timeout = 10
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
