usr = User.create username: 'Foo', password: '123456789', email: 'foo@mail.com'

Task.create user_id: usr.id, description: 'Clean room', category: 'cleaning', due_date: '10-10-2000', read: false

usr2 = User.create username: 'Bar', password: '123456789', email: 'bar@mail.com'
Task.create user_id: usr2.id, description: 'Task1', category: 'work', due_date: '12-10-2003', read: false
Task.create user_id: usr2.id, description: 'Task2', category: 'work', due_date: '12-10-2003', read: false
