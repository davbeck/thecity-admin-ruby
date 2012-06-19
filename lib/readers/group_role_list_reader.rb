module TheCity

  class GroupRoleListReader < ApiReader

    # Constructor.
    #
    # @param group_id The group ID to load the roles for.
    # @param page The page number to get.  Default is 1. 
    # @param [CacheAdapter] cacher (optional) The cacher to be used to cache data.
    def initialize(group_id, page = 1, cacher = nil)
      @class_key = "groups_#{group_id}_roles_#{page}"   
      @url_data_path = "/groups/#{group_id}/roles"
      @url_data_params = {:page => page}
      
      # The object to store and load the cache.
      @cacher = cacher unless cacher.nil?    
    end

  end

end