json.array!(@skill_profiles) do |skill_profile|
  json.extract! skill_profile, :id, :profile_id, :user_id
  json.url skill_profile_url(skill_profile, format: :json)
end
