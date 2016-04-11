require 'test_helper'

class PhoneTest < ActiveSupport::TestCase

  test "create phone with all mandatory fields " do
   phone= Phone.new(number: "630677445")

   assert phone.save
  end

  test "should not save phone without number" do
   phone= Phone.new

   assert_not phone.save
  end

end
