module TheCityAdmin
  FactoryGirl.define do
  
    factory :user_invitation_list, :class => TheCity::UserInvitationList do
      total_entries 0
      total_pages 0
      per_page 15
      current_page 1
      #invitations {}
    end

  end
end