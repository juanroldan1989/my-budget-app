# Maps environment variables into configuration settings

#EventFinda
Rails.application.config.finda_user_name = Figaro.env.finda_user_name
Rails.application.config.finda_password  = Figaro.env.finda_password
