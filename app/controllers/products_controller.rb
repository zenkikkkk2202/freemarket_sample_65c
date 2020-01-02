class ProductsController < ApplicationController
  def index
    @products = Product.all.includes(:product_images)
  end

  def new
    @product = Product.new
    @product.product_images.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      binding.pry
      redirect_to root_path
    else
      render :new
    end
  end
  
  
  def show
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

  def notice
  end

  def things_to_do
  end

  def like
  end

  def exhibiting
  end

  def transaction
  end

  def sale
  end

  def purchase_exhibit
  end

  def purchase_transaction
  end

  def news
  end

  def evaluation
  end

  def contact
  end

  def buy_confirm
  end

  private

  def prefecture_params
    params.require(:product).permit(:prefecture)
  end

  def product_params
    params.require(:product).permit(:name,:description,:category,:condition,:charge,:prefecture_id,:day,:price,:fee,:profit, product_images_attributes: [:image, :_destroy])
  end
end
