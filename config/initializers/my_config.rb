REGION = YAML.load(
  File.read("#{Rails.root}/config/my_config/region.yml"))[Rails.env]