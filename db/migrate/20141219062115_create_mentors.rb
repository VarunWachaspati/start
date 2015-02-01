class CreateMentors < ActiveRecord::Migration
  def change
    create_table :mentors do |t|
	t.string   :fname
    t.string   :lname
    t.string   :email
    t.datetime :created_at
    t.datetime :updated_at
    t.string   :linkedin_id
    t.string   :password_digest
    t.string   :remember_token
    t.text     :bio
    t.string   :google
    t.string   :fb
    t.string   :github
    t.string   :skills
    t.string   :pic_file_name
    t.string   :pic_content_type
    t.integer  :pic_file_size
    t.datetime :pic_updated_at
    t.text     :education
    t.string   :linkedin
    t.string   :phone
  
      t.timestamps
    end
    add_index  :mentors, :remember_token
    add_index  :mentors, :email, unique: true
  end
end
