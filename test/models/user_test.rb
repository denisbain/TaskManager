require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
    test "create" do
       user = create :user
       assert user.persisted?
    end
end
