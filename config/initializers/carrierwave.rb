access_key_id = APP_CONFIG["aws"]["access_key_id"] || ENV["aws_access_key_id"]
secret_access_key = APP_CONFIG["aws"]["secret_access_key"] || ENV["aws_secret_access_key"]
bucket = APP_CONFIG["aws"]["bucket"] || ENV["aws_bucket"]

CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              "AWS",
    aws_access_key_id: access_key_id,
    aws_secret_access_key: secret_access_key
  }
  config.fog_directory = bucket
end