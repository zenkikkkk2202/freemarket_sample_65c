class Users::RegistrationsController < Devise::RegistrationsController

  def new
    @user = User.new
  end

  def create
    
  end

  def new_cellphone
    @user = User.new
  end

  def create_cellphone
    
  end

  def new_address
    @user = User.new
  end

  def create_address
    
  end

  def new_credit_cards
    @user = User.new
  end

  def create_credit_cards
    
  end
end
