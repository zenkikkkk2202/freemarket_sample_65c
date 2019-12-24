class ProductsController < ApplicationController
  def index
    
  end

  def new
    @product = Product.new
  end

  def create
    
  end
  
  def show
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

  private

  def prefecture_params
    params.require(:product).permit(:prefecture)
  end
end
