TestApp.route('login') do |r|
  r.root do
    logout User
    wedge(:login).to_js :display
  end
end
