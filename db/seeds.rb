
10.times do |i|
    User.create!(
      email: "user #{i+1}@miuandes.cl",
      first_name: "Person #{i+1}",
      last_name: "Tomatos #{i+1}"
    )
  end
  
  
  10.times do |i|
    Chat.create!(
      sender_id: "#{i+1}",
      receiver_id: "#{i+1} %10"
      
    )
  end
  
  10.times do |i|
    Message.create!(
      chat_id: "#{i+1} *2",
      user_id: "#{i+1} +4",
      body: "Hello, How are you user #{i+1}"
      
    )
  end
  
  