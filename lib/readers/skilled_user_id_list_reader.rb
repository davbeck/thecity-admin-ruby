module TheCity

  class SkilledUserIdListReader < ApiReader

    # Constructor.
    #
    # @param options A hash of options for requesting data from the server.
    #                :: skill_id is required
    # @param [CacheAdapter] cacher (optional) The cacher to be used to cache data.
    def initialize(options = {}, cacher = nil) 
      options[:page] ||= 1
      skill_id = options.delete(:skill_id)
      #@class_key = "skilled_user_id_list_#{page}"   
      @url_data_path = "/skills/#{skill_id}/user_ids"
      @url_data_params = options
      
      # The object to store and load the cache.
      @cacher = cacher unless cacher.nil?    
    end

  end

end
