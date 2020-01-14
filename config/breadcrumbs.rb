# ルート
crumb :root do
  link "トップページ", root_path
end

# マイページ
crumb :user_page do
  link "マイページ", user_page_products_path
end

# プロフィール
crumb :user_profile_edit do
  link "プロフィール", user_profile_edit_products_path
  parent :user_page
end

# 本人情報の登録
crumb :user_profile_information do
  link "本人情報の登録", user_profile_information_products_path
  parent :user_page
end

# ログアウト
crumb :user_logout do
  link "ログアウト", user_logout_products_path
  parent :user_page
end

# 支払い方法
crumb :user_credit do
  link "支払い方法", user_credit_products_path
  parent :user_page
end

# 出品中
crumb :p_exhibiting do
  link "出品した商品 - 出品中", p_exhibiting_products_path
  parent :user_page
end

# 取引中
crumb :p_transaction do
  link "出品した商品 - 取引中", p_transaction_products_path
  parent :user_page
end

# 売却済み
crumb :p_soldout do
  link "出品した商品 - 売却済み", p_soldout_products_path
  parent :user_page
end

# 出品商品画面
crumb :show do
  link "出品した商品 - 出品中", p_exhibiting_products_path
  link "商品出品画面"
  parent :user_page
end

# ニュース一覧
crumb :user_newslist do
  link "ニュース一覧", user_newslist_products_path
  parent :user_page
end

# メール/パスワード
crumb :user_mailpassword do
  link "メール/パスワード", user_mailpassword_products_path
  parent :user_page
end

# 発送元・お届け先住所変更
crumb :user_change_address do
  link "発送元・お届け先住所変更", user_change_address_products_path
  parent :user_page
end

#  電話番号の確認
crumb :user_callnumber do
  link " 電話番号の確認", user_callnumber_products_path
  parent :user_page
end

#  メルペイの売上・振込申請
crumb :merupay do
  link " 売上・振込申請", merupay_products_path
  parent :user_page
end

#  メルペイの売上振込申請の売上履歴
crumb :merupay_sellpast do
  link " 売上・振込申請", merupay_products_path
  link " 売上履歴",merupay_sellpast_products_path
  parent :user_page
end

#  メルペイの売上金の振込申請制限
crumb :merupay_selldeadline do
  link " 売上・振込申請", merupay_products_path
  link " 売上金の振込申請期限", merupay_selldeadline_products_path
  parent :user_page
end

#  メルペイの振込申請して現金を受け取るページの口座情報のフォーム
crumb :merupay_receive_cash do
  link " 売上・振込申請", merupay_products_path
  link "  振込先口座の指定", merupay_receive_cash_products_path
  parent :user_page
end

#  メルペイの振込申請して現金を受け取るページの口座情報のフォーム
crumb :merupay_transfer do
  link " 売上・振込申請", merupay_products_path
  link "  振込先口座の指定", merupay_receive_cash_products_path
  parent :user_page
end

#  売上・振込申請の振込申請履歴一覧
crumb :merupay_transferpast do
  link " 売上・振込申請", merupay_products_path
  link " 振込申請履歴一覧", merupay_transferpast_products_path
  parent :user_page
end

# カテゴリページ
crumb :category_search do
  category = params[:category]
  @category = category.to_i
  link Product.categories.keys[@category], "/products/category_search/:category"
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).