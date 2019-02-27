class SearchesController < ApplicationController
  def search
  end
  # def foursquare
  #   begin
  #   @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
  #       req.params['client_id'] = 'NI0WEXLZHDAONATY2HWQ42G5HRI3VY1JUZEAIXVNNSU513DD'
  #       req.params['client_secret'] = 'XATWSSA0U4STC5JLMMYPE3RX31RMOXPA2NJRLFS0DLOXNWO0'
  #       req.params['v'] = '20160201'
  #       req.params['near'] = params[:zipcode]
  #       req.params['query'] = 'coffee shop'
  #     end
  #     body = JSON.parse(@resp.body)
  #     if @resp.success?
  #       @venues = body["response"]["venues"]
  #     else
  #       @error = body["meta"]["errorDetail"]
  #     end

  def foursquare
    begin
     @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
         req.params['client_id'] = 'ZFPLW2YP3HTXLB3XOBZBLD2T2GJVYF0KRNOOOCORRRRMY1S0
'
         req.params['client_secret'] = 'HQB2VK2VUCJFIHUBRNH3HJSNJGLLJJ0YZAH5JHEUXQUBX2OX'
         req.params['v'] = '20160201'
         req.params['near'] = params[:zipcode]
         req.params['query'] = 'coffee shop'
       end

        body_hash = JSON.parse(@resp.body)
       if @resp.success?

         @venues = body_hash["response"]["venues"]
       else
         @error = body["meta"]["errorDetail"]
       end
     rescue Faraday::ConnectionFailed
       @error = "There was a timeout. Please try again."
     end

     render 'search'
   end
end
  #
  # def foursquare
  #   @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
  #     req.params['client_id'] = 'ZFPLW2YP3HTXLB3XOBZBLD2T2GJVYF0KRNOOOCORRRRMY1S0'
  #     req.params['client_secret'] = 'HQB2VK2VUCJFIHUBRNH3HJSNJGLLJJ0YZAH5JHEUXQUBX2OX'
  #     req.params['v'] = '20160201'
  #     req.params['near'] = params[:zipcode]
  #     req.params['query'] = 'coffee shop'
  #   end
  #   debugger
  #
  #   render 'search'
  # end
  #
  #
