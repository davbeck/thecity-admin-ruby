module TheCity

  class TagList 

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
    #   TagList.new(reader, {:page => 3})
    #
    #   TagList.new(reader, {:page => 2})
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
    # @return array of tag names.
    def all_tags
      return [] if @json_data['tags'].nil?
      @json_data['tags'].collect { |tag| tag['name'] }
    end
    alias :tags :all_tags
    
    
    # Get the specified tag.
    #
    # @param index The index of the tag to get.
    #
    # @return [Tag]
    def [](index)
      Tag.new( @json_data['tags'][index] ) if @json_data['tags'][index]
    end


    # This method is needed for Enumerable.
    def each &block
      @json_data['tags'].each{ |tag| yield( Tag.new(tag) )}
    end    


    # Alias the count method
    alias :size :count

    # Checks if the list is empty.
    #
    # @return True on empty, false otherwise.
    def empty?
      @json_data['tags'].empty?
    end    
  
  end
  
end