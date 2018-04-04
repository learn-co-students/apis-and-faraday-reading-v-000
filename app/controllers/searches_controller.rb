class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '4SVSAXFJM0WJYVF1UJBUJ4VEDBTH55BA3PJ5PJYUHJDXA3WW'

        req.params['client_secret'] =  'Q1UJJPIWULJCS4IVHD2P5GWRACIWUAWYMIFPDA1IDYYOHCMP'

        req.params['v'] = '20180404'
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
