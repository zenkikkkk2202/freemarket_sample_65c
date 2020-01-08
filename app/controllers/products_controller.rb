class ProductsController < ApplicationController
  before_action :set_product,only:[:show,:edit,:destroy,:buy_confirm,:buy]
  before_action :set_current_user_products,only:[:p_transaction,:p_exhibiting,:p_soldout]

  def index
    @products = Product.all.includes(:product_images).limit(10)
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
    @saler_products = Product.where(saler_id: @saler_id).limit(6)
    @category_products = Product.where(category: @product.category).limit(6)
  end

  def edit
    @product.product_images.find(params[:id])
  end

  def update

  end

  def destroy
    if @product.destroy
      redirect_to(root_path)
    else
      redirect_to :show
    end
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
    card = current_user.credit_cards
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = Rails.application.credentials[:payjp][:test_secret_key]
      customer = Payjp::Customer.retrieve(card[0].customer_id)
      @customer_card = customer.cards.retrieve(card[0].card_id)

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
    card = current_user.credit_cards
    
    if card.blank?
      redirect_to action: "new"
      flash[:alert] = '購入にはクレジットカード登録が必要です'
    else
     # 購入した際の情報を元に引っ張ってくる
      card = current_user.credit_cards
     # テーブル紐付けてるのでログインユーザーのクレジットカードを引っ張ってくる
      Payjp.api_key = Rails.application.credentials[:payjp][:test_secret_key]
     # キーをセットする(環境変数においても良い)
      Payjp::Charge.create(
      amount: @product.price, #支払金額
      customer: card[0].customer_id, #顧客ID
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
end
