class Api < Roda
  plugin :json

  route do |r|
    r.is 'users' do
      User.as_hash
    end

    r.is 'user/:id' do |id|
      User.find(id: id).as_hash extended: true
    end
  end
end


