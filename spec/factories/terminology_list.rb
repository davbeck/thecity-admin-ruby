module TheCityAdmin
  FactoryGirl.define do
  
    factory :terminology_list, :class => TheCity::TerminologyList do
      total_entries 0
      total_pages 0
      per_page 15
      current_page 1
      #labels {}
    end

  end
end