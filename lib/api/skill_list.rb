module TheCity

  class SkillList 

    include Enumerable

    attr_reader :total_entries, :total_pages, :per_page, :current_page

    # Constructor.
    #
    # @param [SkillListReader] reader The object that loaded the data.
    # @param options A hash of filters for loading the user list.
    # 
    # Options:
    #   :page - The page number to get.
    #   :search -  (optional) A skill name to search on.
    #
    #
    # Examples:
    #   SkillList.new(reader, {:page => 3})
    #
    #   SkillList.new(reader, {:page => 2})
    #    
    def initialize(reader, options = {}) 
      @json_data = reader.load_feed

      @total_entries = @json_data['total_entries']
      @total_pages = @json_data['total_pages']
      @per_page = @json_data['per_page']
      @current_page = @json_data['current_page']      
    end
    
    
    # All the skills in the list.
    #
    # @return array of skill names.
    def all_skills
      return [] if @json_data['skills'].nil?
      @json_data['skills'].collect { |skill| skill['name'] }
    end
    alias :skills :all_skills
    
    
    # Get the specified skill.
    #
    # @param index The index of the skill to get.
    #
    # @return [Skill]
    def [](index)
      Skill.new( @json_data['skills'][index] ) if @json_data['skills'][index]
    end


    # This method is needed for Enumerable.
    def each &block
      @json_data['skills'].each{ |skill| yield( Skill.new(skill) )}
    end    


    # Alias the count method
    alias :size :count

    # Checks if the list is empty.
    #
    # @return True on empty, false otherwise.
    def empty?
      @json_data['skills'].empty?
    end    
  
  end
  
end