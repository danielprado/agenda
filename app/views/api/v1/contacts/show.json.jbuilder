json.extract! @contact, :id, :name, :surnames, :email, :category, :created_at, :updated_at, :phones
json.photo  asset_url(@contact.photo.url(:medium))
