Rails.application.configure do
  if Rails.env == "development"
    config.secret_key_base = "3964e7f3758bf4ef29068ffb53ff046f759bed190bea1a27fef5658daf86ca362e2bbac2df383811a3d476854fff7bcb6c5c8e4a7ccab4b642ad8e58f9f792fb"
  elsif Rails.env == "production"
    config.secret_key_base = ENV["SECRET_KEY_BASE"]
  end
end
