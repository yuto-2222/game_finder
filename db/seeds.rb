Admin.find_or_create_by!(

  email: 'admin@admin',
  password: "#{ENV['admin_password']}"
  )
  
