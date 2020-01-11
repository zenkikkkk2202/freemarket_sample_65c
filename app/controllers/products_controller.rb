class ProductsController < ApplicationController
  before_action :set_product,only:[:show,:edit,:destroy,:buy_confirm,:buy]
  before_action :set_current_user_products,only:[:edit,:p_transaction,:p_exhibiting,:p_soldout]
  before_action :set_cards,only:[:buy_confirm,:buy]
  before_action :move_to_index, except: [:index, :show, :search]
  def index
    @products_m = Product.where(category: "メンズ").includes(:product_images).limit(10).order('created_at DESC')
    @products_l = Product.where(category: "レディース").includes(:product_images).limit(10).order('created_at DESC')
    @products_k = Product.where(category: "ベビー・キッズ").includes(:product_images).limit(10).order('created_at DESC')
    @products_i = Product.where(category: "インテリア・住まい・小物").includes(:product_images).limit(10).order('created_at DESC')
    @products_b = Product.where(category: "本・音楽・ゲーム").includes(:product_images).limit(10).order('created_at DESC')
    @products_h = Product.where(category: "おもちゃ・ホビー・グッズ").includes(:product_images).limit(10).order('created_at DESC')
    @products_c = Product.where(category: "コスメ・香水・美容").includes(:product_images).limit(10).order('created_at DESC')
    @products_d = Product.where(category: "家電・スマホ・カメラ").includes(:product_images).limit(10).order('created_at DESC')
    @products_s = Product.where(category: "スポーツ・レジャー").includes(:product_images).limit(10).order('created_at DESC')
    @products_h = Product.where(category: "ハンドメイド").includes(:product_images).limit(10).order('created_at DESC')
    @products_t = Product.where(category: "チケット").includes(:product_images).limit(10).order('created_at DESC')
    @products_a = Product.where(category: "自動車・オートバイ").includes(:product_images).limit(10).order('created_at DESC')
    @products_o = Product.where(category: "その他").includes(:product_images).limit(10).order('created_at DESC')
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
      render :new
    end
  end
  
  
  def show
    @saler_products = Product.where(saler_id: @product.saler.id).limit(6)
    @category_products = Product.where(category: @product.category).limit(6)
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

      redirect_to product_path(@product), data: {turbolinks: false}

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
      @products = Product.search(params[:keyword])
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

  def guide
    
  end

  def p_transaction
  end

  def like
  end

  def exhibiting
  end

  def transaction
  end

  def sale
  end

  def p_exhibiting
  end

  def purchase_transaction
  end

  def p_soldout
  end

  def evaluation
  end

  def contact
  end

  def buy_confirm
    if @cards.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = Rails.application.credentials[:payjp][:test_secret_key]
      customer = Payjp::Customer.retrieve(@cards[0].customer_id)
      @customer_card = customer.cards.retrieve(@cards[0].card_id)

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
    if @cards.blank?
      redirect_to action: "new"
      flash[:alert] = '購入にはクレジットカード登録が必要です'
    else
     # 購入した際の情報を元に引っ張ってくる
     # テーブル紐付けてるのでログインユーザーのクレジットカードを引っ張ってくる
      Payjp.api_key = Rails.application.credentials[:payjp][:test_secret_key]
     # キーをセットする(環境変数においても良い)
      Payjp::Charge.create(
      amount: @product.price, #支払金額
      customer: @cards[0].customer_id, #顧客ID
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
     #↑この辺はこちら側のテーブル設計どうりに色々しています
    end
  end

  def category_search
    @category_products = Product.where(category: params[:category]) 
    category = params[:category]
    @category = category.to_i
  end
  private

  def set_product
    @product = Product.find(params[:id])
  end

  def set_current_user_products
    @products = current_user.products.includes(:user,:saler,:buyer,:auction,:product_images)
  end

  def prefecture_params
    params.require(:product).permit(:prefecture)
  end

  def product_params
    params.require(:product).permit(:name,:description,:category,:condition,:charge,:prefecture_id,:day,:price,:fee,:profit, product_images_attributes: [:image, :_destroy]).merge(user_id:current_user.id,saler_id: current_user.id)
  end

  def set_cards
    @cards = current_user.credit_cards
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
  
end
