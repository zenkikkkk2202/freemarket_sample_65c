## usersテーブル

| Column                | Type    | Options     |
| --------------------- | ------- | ----------- |
| e_mail                | string  | null: false |
| image                 | text    |             |
| nickname              | string  | null: false |
| password              | string  | null: false |
| password_conformation | string  | null: false |
| cellphone_number      | integer | null: false |


### Association
- has_many   :products
- has_many   :credit_cards
- has_many :addresses
- belongs_to :facebook
- belongs_to  :google

## productsテーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| name        | string     | null: false                    |
| image       | string     | null: false                    |
| description | text       | null: false                    |
| category    | string     | null: false                    |
| condition   | string     | null: false                    |
| charge      | string     | null: false                    |
| area        | string     | null: false                    |
| day         | string     | null: false                    |
| price       | integer    | null: false                    |
| user_id     | references | null: false, foreign_key: true |

### Association
- belongs_to  :user 
- has_many   :products_images

## credit_cardsテーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| card_number | integer    | null: false                    |
| limit_m     | integer    | null: false                    |
| limit_y     | integer    | null: false                    |
| code        | integer    | null: false                    |
| user_id     | references | null: false, foreign_key: true |

### Association
- belongs_to  :user 

## addressesテーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| name_family  | string     | null: false                    |
| name_last    | string     | null: false                    |
| name_kana_f  | string     | null: false                    |
| name_kana_l  | string     | null: false                    |
| post_code    | integer    | null: false                    |
| prefecture   | string     | null: false                    |
| city         | string     | null: false                    |
| address      | string     | null: false                    |
| build        | string     |                                |
| phone_number | integer    |                                |
| user_id      | references | null: false, foreign_key: true |

### Association
- belongs_to  :user 


## product_imagesテーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| image      | text       | null: false                    |
| product_id | references | null: false, foreign_key: true |

### Association
- belongs_to  :product

## facebooksテーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| information | string     | null: false                    |
| password    | string     | null: false                    |
| user_id     | references | null: false, foreign_key: true |

### Association
- belongs_to  :user 

## googlesテーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| name     | string     | null: false                    |
| gmail    | string     | null: false                    |
| password | string     | null: false                    |
| user_id  | references | null: false, foreign_key: true |

### Association
- belongs_to  :user
