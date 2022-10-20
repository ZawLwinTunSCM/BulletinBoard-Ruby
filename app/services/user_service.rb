class UserService
  class << self

    def list(id)
      @users = UserRepository.list(id)
    end
    
    def createUser(user)
      @is_user_create = UserRepository.createUser(user)
    end
    
    def getUserByID(id)
      @user = UserRepository.getUserByID(id)
    end
    
    def getUserByName(name)
      @user = UserRepository.getUserByName(name)
    end
    
    def updateUser(user, user_params)
      @is_user_update = UserRepository.updateUser(user, user_params)
    end
    
    def destroyUser(user)
      UserRepository.destroyUser(user)
    end
     
    def findByEmail(email)
      @user = UserRepository.findByEmail(email)
    end
    
    def updatePassword(user, password)
      @is_update_password = UserRepository.updatePassword(user, password)
    end
    
  end
end