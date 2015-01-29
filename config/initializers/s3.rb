CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket = 'drobazkoimages'
  config.aws_acl    = :public_read
  config.asset_host = 'https://drobazkoimages.s3.amazonaws.com'
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365

  config.aws_credentials = {
    access_key_id:     'AKIAJRIAQWIA657Q4XGA',
    secret_access_key: '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'
  }
end