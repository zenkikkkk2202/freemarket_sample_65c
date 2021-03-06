class ProductsController < ApplicationController
  before_action :set_product,only:[:show,:edit,:destroy,:buy_confirm,:buy]
  before_action :set_current_user_products,only:[:edit,:p_transaction,:p_exhibiting,:p_soldout]
  before_action :set_cards,only:[:buy_confirm,:buy]
  before_action :move_to_index, except: [:index, :show, :search, :category_search]
  before_action :redirect_index, only: :edit
  def index
    @products_l = Product.where(category: "1").includes(:product_images).limit(10).order('created_at DESC')
    @products_m = Product.where(category: "2").includes(:product_images).limit(10).order('created_at DESC')
    @products_w = Product.where(category: "3").includes(:product_images).limit(10).order('created_at DESC')
    @products_i = Product.where(category: "4").includes(:product_images).limit(10).order('created_at DESC')
    @products_b = Product.where(category: "5").includes(:product_images).limit(10).order('created_at DESC')
    @products_g = Product.where(category: "6").includes(:product_images).limit(10).order('created_at DESC')
    @products_c = Product.where(category: "7").includes(:product_images).limit(10).order('created_at DESC')
    @products_d = Product.where(category: "8").includes(:product_images).limit(10).order('created_at DESC')
    @products_s = Product.where(category: "9").includes(:product_images).limit(10).order('created_at DESC')
    @products_h = Product.where(category: "10").includes(:product_images).limit(10).order('created_at DESC')
    @products_t = Product.where(category: "11").includes(:product_images).limit(10).order('created_at DESC')
    @products_a = Product.where(category: "12").includes(:product_images).limit(10).order('created_at DESC')
    @products_o = Product.where(category: "13").includes(:product_images).limit(10).order('created_at DESC')
  end

  def new
    @product = Product.new
    @product.product_images.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      redirect_to new_product_path,data: { turbolinks: false }
    end
  end
  
  
  def show
    @saler_products = Product.where(saler_id: @product.saler.id).limit(6)
    @category_products = Product.where(category: @product.category).limit(6)
    category = params[:category]
    @category = category.to_i
  end

  def edit
    gon.product = @product
    gon.product_images = @product.product_images
  end


  def update
    @product = Product.find(params[:id])
    # newで登録した登録済画像のidの配列を生成
    ids = @product.product_images.map{|image| image.id }
    # 登録済画像のうち、編集後もまだ残っている画像のidの配列を生成(文字列から数値に変換)
    exist_ids = registered_image_params[:ids].map(&:to_i)
    # 登録済画像が残っていない場合(配列に０が格納されている)、配列を空にする
    exist_ids.clear if exist_ids[0] == 0

    if (exist_ids.length != 0 || new_image_params[:images][0] != " ") && @product.update(product_edit_params)
      # 登録済画像のうち削除ボタンをおした画像を削除
      unless ids.length == exist_ids.length
        delete_ids = ids - exist_ids
        # 削除する画像のidの配列を生成
        delete_ids.each do |id|
          @product.product_images.find(id).destroy
        end
      end

      # 新規登録画像があればcreate、editで追加した画像
      unless new_image_params[:images][0] == " "
        new_image_params[:images].each do |image|
          @product.product_images.create(image: image, product_id: @product.id)
        end
      end

      redirect_to product_path(@product),data: { turbolinks: false }

    else
      redirect_back(fallback_location: root_path)
    end

  end

  def destroy
    if @product.destroy
      redirect_to(root_path)
    else
      redirect_to :show
    end
  end

  def search
    @search_params = params[:keyword]
    @products = Product.search(@search_params).order("created_at DESC").page(params[:page]).per(10)
    @count = @products.count
    @products = Product.all.limit(24).order("created_at DESC") if @products.count == 0
  end


  def user_credit
  end

  def user_profile_information
  end

  def user_profile_edit
  end

  def user_logout
  end

  def user_page
    
  end

  def user_change_address
  end

  def user_mailpassword
  end

  def user_newslist
  end

  def user_callnumber
  end

  def guide
    
  end

  def merupay_receive_cash
    
  end

  def merupay_selldeadline
    
  end

  def merupay_sellpast
    
  end

  def merupay1_expiration_date
    
  end

  def merupay
    
  end

  def merupay_transferpast
    
  end

  def merupay_transfer
    
  end

  def merupay1_pointpast
    
  end

  def merupay1
    
  end

  def p_transaction
    @user = User.find(current_user.id)
  end

  def like
  end

  def evaluation_all
  end

  def evaluation_good
  end

  def evaluation_normal
  end

  def evaluation_bad
  end

  def transaction
  end

  def sale
  end

  def p_exhibiting
    @user = User.find(current_user.id)
  end

  def purchase_transaction
  end

  def p_soldout
    @user = User.find(current_user.id)
  end

  def evaluation
  end

  def contact
  end

  def buy_confirm
    if @card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = Rails.application.credentials[:payjp][:test_secret_key]
      customer = Payjp::Customer.retrieve(@card[0].customer_id)
      @customer_card = customer.cards.retrieve(@card[0].card_id)

      @card_brand = @customer_card.brand      
      case @card_brand
      when "Visa"
        @card_src = "visa.png"
      when "JCB"
        @card_src = "jcb.png"
      when "MasterCard"
        @card_src = "mastercard.png"
      when "American Express"
        @card_src = "AmericanExpress.png"
      when "Diners Club"
        @card_src = "diners.png"
      when "Discover"
        @card_src = "discover.jpg"
      end
    end
  end

  def buy #クレジット購入 
    if @card.blank?
      redirect_to action: "new"
      flash[:alert] = '購入にはクレジットカード登録が必要です'
    else
     # 購入した際の情報を元に引っ張ってくる
     # テーブル紐付けてるのでログインユーザーのクレジットカードを引っ張ってくる
      Payjp.api_key = Rails.application.credentials[:payjp][:test_secret_key]
     # キーをセットする(環境変数においても良い)
      Payjp::Charge.create(
      amount: @product.price, #支払金額
      customer: @card[0].customer_id, #顧客ID
      currency: 'jpy', #日本円
      )
     # ↑商品の金額をamountへ、cardの顧客idをcustomerへ、currencyをjpyへ入れる
      if @product.update(buyer_id: current_user.id)
        flash[:notice] = '購入しました。'
        redirect_to root_path
      else
        flash[:alert] = '購入に失敗しました。'
        redirect_to controller: "products", action: 'show'
      end
     #↑この辺はこちら側のテーブル設計どおりに色々しています
    end
  end

  def category_search
    @category_products = Product.where(category: params[:category]).order('created_at DESC')
    category = params[:category]
    @category = category.to_i
  end
  private

  def set_product
    @product = Product.find(params[:id])
  end

  def set_current_user_products
    if user_signed_in? 
      @products = current_user.products.includes(:user,:saler,:buyer,:auction,:product_images)
    else
      redirect_to new_user_session_path
    end
  end

  def prefecture_params
    params.require(:product).permit(:prefecture)
  end

  def product_params
    params.require(:product).permit(:name,:description,:category,:condition,:charge,:prefecture_id,:day,:price,:fee,:profit, product_images_attributes: [:image, :_destroy]).merge(user_id:current_user.id,saler_id: current_user.id)
  end

  def set_cards

    if user_signed_in? && current_user.id != @product.saler_id && @product.buyer_id.nil? 
      @card = current_user.credit_cards
    else
      redirect_to new_user_session_path
    end

  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def product_edit_params
    params.require(:product).permit(:name, :description, :category, :condition, :charge, :prefecture_id, :day, :price,:fee,:profit)
  end

  def registered_image_params
    params.require(:registered_images_ids).permit({ids: []})
  end

  def new_image_params
    params.require(:new_images).permit({images: []})
  end

  def redirect_index
    if user_signed_in? && @product.saler_id != @product.saler_id
      redirect_to action: :index 
    elsif @product.buyer_id
      redirect_to action: :index 
    end
  end

end
