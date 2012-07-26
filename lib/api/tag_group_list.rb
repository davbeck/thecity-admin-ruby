module TheCity

  class TagGroupList 

    include Enumerable

    attr_reader :total_entries, :total_pages, :per_page, :current_page

    # Constructor.
    #
    # @param [UserListReader] reader The object that loaded the data.
    # @param options A hash of filters for loading the user list.
    # 
    # Options:
    #   :page - The page number to get.
    #   :search -  (optional) A tag name to search on.
    #
    #
    # Examples:
    #   TagGroupList.new(reader, {:page => 3, :group_types => 'CG'})
    #
    #   TagGroupList.new(reader, {:page => 2})
    #    
    def initialize(reader, options = {}) 
      @json_data = reader.load_feed

      @total_entries = @json_data['total_entries']
      @total_pages = @json_data['total_pages']
      @per_page = @json_data['per_page']
      @current_page = @json_data['current_page']      
    end
    
    
    # All the tags in the list.
    #
    # @return array of group names.
    def all_groups
      return [] if @json_data['groups'].nil?
      @json_data['groups'].collect { |group| group['name'] }
    end
    alias :groups :all_groups
    
    
    # Get the specified tag.
    #
    # @param index The index of the tag to get.
    #
    # @return [TagGroup]
    def [](index)
      Group.new( @json_data['groups'][index] ) if @json_data['groups'][index]
    end


    # This method is needed for Enumerable.
    def each &block
      @json_data['groups'].each{ |group| yield( Group.new(group) )}
    end    


    # Alias the count method
    alias :size :count

    # Checks if the list is empty.
    #
    # @return True on empty, false otherwise.
    def empty?
      @json_data['groups'].empty?
    end    
  
  end
  
end