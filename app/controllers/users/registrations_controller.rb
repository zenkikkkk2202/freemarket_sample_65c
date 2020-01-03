class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :redirect_to_index_from_sms, only: :create, :create_cellphone, :create_address, :create_credit_cards

  require "payjp"

  def index
  end

  def new
    @user = User.new
  end

  def create
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password] 
    session[:name_family] = user_params[:name_family]
    session[:name_last] = user_params[:name_last]
    session[:name_kana_f] = user_params[:name_kana_f]
    session[:name_kana_l] = user_params[:name_kana_l]
    session[:birthday_y] = user_params[:birthday_y]
    session[:birthday_m] = user_params[:birthday_m]
    session[:birthday_d] = user_params[:birthday_d]

    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      name_family: session[:name_family],
      name_last: session[:name_last],
      name_kana_f: session[:name_kana_f],
      name_kana_l: session[:name_kana_l],
      birthday_y: session[:birthday_y],
      birthday_m: session[:birthday_m],
      birthday_d: session[:birthday_d]
    )

    check_user_valid = @user.valid?
    unless check_user_valid
      render :new
    else
      session[:through_first_valid] = "through_first_valid"
      redirect_to cellphones_path
    end
  end

  def new_cellphone
    @user = User.new
    @cellphone = Cellphone.new

  end

  def create_cellphone
    session[:cellphone_number] = cellphone_params[:cellphone_number]

    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      name_family: session[:name_family],
      name_last: session[:name_last],
      name_kana_f: session[:name_kana_f],
      name_kana_l: session[:name_kana_l],
      birthday_y: session[:birthday_y],
      birthday_m: session[:birthday_m],
      birthday_d: session[:birthday_d]
    )

    @cellphone = Cellphone.new(
      cellphone_number: session[:cellphone_number]
    )

    check_user_valid = @user.valid?
    check_cellphone_valid = @cellphone.valid?
    unless check_user_valid && check_cellphone_valid
      render :new_cellphone
    else
      session[:through_first_valid] = "through_first_valid"
      redirect_to addresses_path
    end
  end
    

  def new_address
    @user = User.new
    @cellphone = Cellphone.new
    @address = Address.new
  end

  def create_address
    session[:post_code] = address_params[:post_code]
    session[:prefecture_id] = address_params[:prefecture_id]
    session[:city] = address_params[:city]
    session[:address] = address_params[:address]
    session[:build] = address_params[:build]
    session[:phone_number] = address_params[:phone_number]

    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      name_family: session[:name_family],
      name_last: session[:name_last],
      name_kana_f: session[:name_kana_f],
      name_kana_l: session[:name_kana_l],
      birthday_y: session[:birthday_y],
      birthday_m: session[:birthday_m],
      birthday_d: session[:birthday_d]
    )

    @cellphone = Cellphone.new(
      cellphone_number: session[:cellphone_number]
    )

    @address = Address.new(
      post_code: session[:post_code],
      prefecture_id: session[:prefecture_id],
      city: session[:city],
      address: session[:address],
      build: session[:build],
      phone_number: session[:phone_number]
    )

    check_user_valid = @user.valid?
    check_cellphone_valid = @cellphone.valid?
    check_address_valid = @address.valid?
    unless check_user_valid && check_cellphone_valid && check_address_valid
      render :new_address
    else
      session[:through_first_valid] = "through_first_valid"
      redirect_to credit_cards_path
    end
  end

  def new_credit_card
    @user = User.new
    @cellphone = Cellphone.new
    @address = Address.new
    @credit_card = CreditCard.new
  end

  def create_credit_card
    # session[:card_number] = credit_card_params[:card_number]
    # session[:exp_month] = credit_card_params[:exp_month]
    # session[:exp_year] = credit_card_params[:exp_year] 
    # session[:cvc] = credit_card_params[:cvc]

    
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      name_family: session[:name_family],
      name_last: session[:name_last],
      name_kana_f: session[:name_kana_f],
      name_kana_l: session[:name_kana_l],
      birthday_y: session[:birthday_y],
      birthday_m: session[:birthday_m],
      birthday_d: session[:birthday_d]
    )
    @user.save
    
    @cellphone = Cellphone.new(
      user: @user,
      cellphone_number: session[:cellphone_number]
    )
    @cellphone.save

    @address = Address.new(
      user: @user,
      # cellphone: @cellphone,
      post_code: session[:post_code],
      prefecture_id: session[:prefecture_id],
      city: session[:city],
      address: session[:address],
      build: session[:build],
      phone_number: session[:phone_number]
    )
    @address.save
    
    # @credit_card = Credit_card.new(
    #   card_number: session[:card_number],
    #   exp_month: session[:exp_month],
    #   exp_year: session[:exp_year],
    #   cvc: session[:cvc]
    # )
    # @credit_card.save
    Payjp.api_key = "sk_test_62cd291a7c9df2d7ce3d50f5"
    customer = Payjp::Customer.create(card: params["payjp-token"])
    @credit_card = CreditCard.new(user: @user,customer_id: customer.id,card_id: customer.default_card)
    
    # カード情報まで保存に成功したら全sessionをリセットしてユーザーidのみsessionに預け、完了画面へリダイレクト
    if @credit_card.save
      reset_session
      session[:id] = @user.id
      redirect_to done_path
      return 
    else
      #失敗したらsessionを切って登録ページトップへリダイレクト
      reset_session
      redirect_to new_path
    end
    
  end

  def done
    unless session[:id]
      redirect_to signup_index_path 
      return
    end
    # deviseのメソッドを使ってログイン
    sign_in User.find(session[:id])
  end


  private
   
  def user_params
    params.require(:user).permit(:nickname, :email, :password, :name_family, :name_last, :name_kana_f, :name_kana_l, :birthday_y, :birthday_m, :birthday_d)
  end

  def cellphone_params
    params.require(:cellphone).permit(:cellphone_number)
  end

  def address_params
    params.require(:address).permit(:post_code, :prefecture_id, :city, :address, :build, :phone_number)
  end

  def credit_card_params
    params.require(:credit_card).permit(:payjp_token, :exp_month, :exp_year, :cvc)
  end


   # 前のpostアクションで定義されたsessionがなかった場合登録ページトップへリダイレクト
  def redirect_to_index_from_sms
    redirect_to signup_index_path unless session[:through_first_valid].present? && session[:through_first_valid] == "through_first_valid"
  end
end
