if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
else
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key:  ENV['AWS_SECRET_ACCESS_KEY'],
      region: 'ap-southeast-1',
      path_style: true
    }
    config.fog_directory = ENV['AWS_BUCKET']
    config.asset_host = "http://s3-ap-southeast-1.amazonaws.com/#{ENV['AWS_BUCKET']}"
    config.fog_attributes = { 'Cache-Control' => 'max-age=315360000' }
  end
end
