# ルート
crumb :root do
  link "トップページ", root_path
end

# マイページ
crumb :user_page do
  link "マイページ", "/products/user-page"
end

# プロフィール
crumb :user_profile_edit do
  link "プロフィール", "/products/user_profile_edit"
  parent :user_page
end

# 本人情報の登録
crumb :user_profile_information do
  link "本人情報の登録", "/products/user_profile_information"
  parent :user_page
end

# ログアウト
crumb :user_logout do
  link "ログアウト", "/products/user_logout"
  parent :user_page
end

# 支払い方法
crumb :user_credit do
  link "支払い方法", "/products/user_credit"
  parent :user_page
end

# 出品中
crumb :p_exhibiting do
  link "出品した商品 - 出品中", "/products/notice"
  parent :user_page
end

# 取引中
crumb :p_transaction do
  link "出品した商品 - 取引中", "/products/purchase_exhibit"
  parent :user_page
end

# 売却済み
crumb :p_soldout do
  link "出品した商品 - 売却済み", "/products/news"
  parent :user_page
end

# 出品商品画面
crumb :show do
  link "商品出品画面", "/products/show"
  parent :user_page
  parent :p_exhibiting
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