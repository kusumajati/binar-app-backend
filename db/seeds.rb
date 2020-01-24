# frozen_string_literal: true

role = [
    {
        name: "student"
    },
    {
        name: "admin"
    },
    {
        name: "marketing"
    },
    {
        name: "academy"
    },{
        name: "mentor"
    }]
role.each do |f|
  Role.find_or_create_by!(f)
end

levels = [
  {
    name: 'guest'
  },
  {
    name: 'silver'
  },
  {
    name: 'gold'
  },
  {
    name: 'platinum'
  },
  {
    name: 'internal'
  },
  {
    name: 'external'
  }
]
levels.each do |f|
  Level.find_or_create_by!(f)
end
user = [
    {
        nickname: "admin",
        role_id: 2,
        level_id: 5,
        email: "admin@admin.com",
        encrypted_password: "$2a$11$5tuMPCcbe4vt1vIJREhAbenzClJPqSjDPZIxyu7bNTitCc5hf9HK2"
    },
    {
        nickname: "marketing",
        role_id: 3,
        level_id: 5,
        email: "marketing@marketing.com",
        encrypted_password: "$2a$11$5tuMPCcbe4vt1vIJREhAbenzClJPqSjDPZIxyu7bNTitCc5hf9HK2"
    },
    {
      nickname: "academy",
      role_id: 4,
      level_id: 5,
      email: "academy@academy.com",
      encrypted_password: "$2a$11$5tuMPCcbe4vt1vIJREhAbenzClJPqSjDPZIxyu7bNTitCc5hf9HK2"
  }
]
user.each do |f|
    User.find_or_create_by!(f)
end

require "csv"

csv_text_reg = File.read(Rails.root.join("lib", "location", "regency.csv"))
csv_text_prov = File.read(Rails.root.join("lib", "location", "provinces.csv"))
csv_prov = CSV.parse(csv_text_prov, encoding: "ISO-8859-1")
csv_reg = CSV.parse(csv_text_reg, encoding: "ISO-8859-1")

csv_prov.each do |row|
  Province.create(name: row.first)
end

csv_reg.each do |row|
  row_prov = Province.find_by(name: row[1])
  row_prov.regency.create(name: row[2])
end
