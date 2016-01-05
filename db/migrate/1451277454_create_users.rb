Sequel.migration do
  change do
    create_table :users do
      primary_key :id
      String :username, null: false, unique: true
      String :email, null: false, unique: true
      String :crypted_password, null: false
      String :phone_number
    end
  end
end
