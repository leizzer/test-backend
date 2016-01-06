Sequel.migration do
  change do
    create_table :tasks do
      primary_key :id
      foreign_key :user_id, :users

      String :description, null: false
      String :category, null: false
      Date :due_date, null: false
      TrueClass :read, default: false

      index :id
    end
  end
end
