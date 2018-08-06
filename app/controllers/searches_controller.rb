class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = "14JVMSSDFMFUP1B4XDMKWY4WYZN2ASMGYME4NWPI3J0AZQ2O"
        req.params['client_secret'] = "JJ0SUNO4UADXVPJNQ4KZTBMG0X1NBIALNC2IUFH2KYNBELZA"
        req.params['v'] = 20160201
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        # req.options.timeout = 0 #TEST PURPOSES ONLY!
      end

      body_hash = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body_hash["response"]["venues"]
      else
        @error = body_hash["meta"]["errorDetail"]
      end

    rescue Faraday::ConnectionFailed
      @error = "Timed out!"
    end

    render 'search'
  end

end
