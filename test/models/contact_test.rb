require 'test_helper'

class ContactTest < ActiveSupport::TestCase
   def setup
   @contact= Contact.new(name: "Pablo",
                         surnames: "Perez Gonzalez",
                         email:"pablo@gmail.es",
                         category: "Amigos",
                         user_id: 1
                         )

  end
  #Tests:Create contact with all mandatory fields
  test "create contact with all mandatory fields " do
   assert @contact.save
  end

  test "should not save contact without user" do
   @contact.user=nil
   assert_not @contact.save
  end

  test "should not save contact without name" do
   @contact.name= nil
   assert_not @contact.save
  end

  test "should not save contact without surnames" do
   @contact.surnames= nil
   assert_not @contact.save
  end

  test "should not save contact without email" do
   @contact.email= nil
   assert_not @contact.save
  end

  test "should not save contact with repeated email " do
   @contact.email= contacts(:pedro).email
   assert_not @contact.save
  end

  test "should not save contact with invalid email format" do
   @contact.email= "pruebasinarroba"
   assert_not @contact.save   
  end

  test "should not save contact without category" do
   @contact.category=nil

   assert_not @contact.save
  end

  test "should not save contact with not supported category" do
   @contact.category= "Conocidos"
   assert_not @contact.save
  end

  test "should load an image as photo" do
    @contact.photo= File.new("test/fixtures/sample.png")

    assert @contact.save!
    assert "sample.png", @contact.photo_file_name
  end

  test "should accept nested attributes for phones" do
    assert @contact.update_attributes(:phones_attributes => {'0' =>{'number'=>"650980470"}})
    assert @contact.phones.size == 1
  end

end
