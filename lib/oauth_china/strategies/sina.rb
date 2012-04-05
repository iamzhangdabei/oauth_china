module OauthChina
  class Sina < OauthChina::OAuth
      
    def initialize(*args)
      self.consumer_options = {
        :site               => 'http://api.t.sina.com.cn',
        :request_token_path => '/oauth/request_token',
        :access_token_path  => '/oauth/access_token',
        :authorize_path     => '/oauth/authorize',
        :realm              => url
      }
      super(*args)
    end

    def name
      :sina
    end

    def authorized?
      #TODO
    end

    def destroy
      #TODO
    end
    
    def my_name
      @all_my_info["screen_name"]
    end
    
    def my_id
      @all_my_info["id"]
    end
    
    def all_my_info
      @all_my_info || = JSON.parse(self.get("http://api.t.sina.com.cn/account/verify_credentials.json").body)
    end
    
    def add_status(content, options = {})
      options.merge!(:status => content)
      self.post("http://api.t.sina.com.cn/statuses/update.json", options)
    end


    def upload_image(content, image_path, options = {})
      options = options.merge!(:status => content, :pic => File.open(image_path, "rb")).to_options
      upload("http://api.t.sina.com.cn/statuses/upload.json", options)
    end

    

  end
end