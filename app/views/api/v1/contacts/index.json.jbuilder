json.array!(@contacts) do |contact|
  json.extract! contact, :id, :name, :surnames, :email , :category, :phones
  json.photo  asset_url(contact.photo.url(:thumb))
  json.url user_contact_url(@user,contact, format: :json)
end
