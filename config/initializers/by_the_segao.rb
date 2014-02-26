if Rails.env.development?
  SEGA_SETTINGS = YAML.load_file("#{::Rails.root}/config/by_the_segao.yml")
  ENV['AWS_ACCESS_KEY_ID']= SEGA_SETTINGS["aws_access_key_id"]
  ENV['AWS_SECRET_ACCESS_KEY']= SEGA_SETTINGS["aws_secret_access_key"]
  ENV['S3_BUCKET']= SEGA_SETTINGS["s3_bucket"]
end