# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# カテゴリーの作成
categories = [
  { name: '野菜', description: '新鮮な野菜類' },
  { name: '肉類', description: '牛肉、豚肉、鶏肉など' },
  { name: '魚介類', description: '魚、貝類など' },
  { name: '乳製品', description: '牛乳、チーズ、ヨーグルトなど' },
  { name: '調味料', description: '塩、砂糖、醤油など' }
]

categories.each do |category|
  Category.find_or_create_by!(name: category[:name]) do |c|
    c.description = category[:description]
  end
end

# 食材の作成
foods = [
  { name: 'にんじん', quantity: 10, unit: '本', category: '野菜', stock_quantity: 5, expiry_date: Date.today + 7 },
  { name: 'じゃがいも', quantity: 5, unit: '個', category: '野菜', stock_quantity: 3, expiry_date: Date.today + 14 },
  { name: '豚肉', quantity: 2, unit: 'kg', category: '肉類', stock_quantity: 1, expiry_date: Date.today + 2 },
  { name: '鶏肉', quantity: 1, unit: 'kg', category: '肉類', stock_quantity: 0, expiry_date: Date.today + 2 },
  { name: '鮭', quantity: 4, unit: '切れ', category: '魚介類', stock_quantity: 2, expiry_date: Date.today + 3 }
]

foods.each do |food|
  Food.find_or_create_by!(name: food[:name]) do |f|
    f.quantity = food[:quantity]
    f.unit = food[:unit]
    f.category = food[:category]
    f.stock_quantity = food[:stock_quantity]
    f.expiry_date = food[:expiry_date]
  end
end

# 給食献立の作成
lunches = [
  {
    date: Date.today,
    main_dish: 'カレーライス',
    side_dish: 'サラダ',
    soup: 'コンソメスープ',
    dessert: 'フルーツ',
    calories: 650
  },
  {
    date: Date.today + 1,
    main_dish: 'ハンバーグ',
    side_dish: 'マカロニサラダ',
    soup: 'トマトスープ',
    dessert: 'プリン',
    calories: 700
  }
]

lunches.each do |lunch|
  SchoolLunch.find_or_create_by!(date: lunch[:date]) do |l|
    l.main_dish = lunch[:main_dish]
    l.side_dish = lunch[:side_dish]
    l.soup = lunch[:soup]
    l.dessert = lunch[:dessert]
    l.calories = lunch[:calories]
  end
end

# 学校行事の作成
events = [
  {
    title: '運動会',
    description: '全校生徒参加の運動会',
    start_date: Date.today + 7,
    end_date: Date.today + 7,
    event_type: '学校行事',
    location: '校庭'
  },
  {
    title: '文化祭',
    description: '各クラスの展示と発表',
    start_date: Date.today + 14,
    end_date: Date.today + 15,
    event_type: '学校行事',
    location: '体育館'
  }
]

events.each do |event|
  SchoolEvent.find_or_create_by!(title: event[:title]) do |e|
    e.description = event[:description]
    e.start_date = event[:start_date]
    e.end_date = event[:end_date]
    e.event_type = event[:event_type]
    e.location = event[:location]
  end
end

# 購入履歴の作成
purchase_histories = [
  {
    food: Food.find_by(name: 'にんじん'),
    purchase_date: Date.today - 2,
    quantity: 5,
    unit: '本',
    price: 250
  },
  {
    food: Food.find_by(name: '豚肉'),
    purchase_date: Date.today - 1,
    quantity: 1,
    unit: 'kg',
    price: 800
  }
]

purchase_histories.each do |history|
  PurchaseHistory.find_or_create_by!(
    food: history[:food],
    purchase_date: history[:purchase_date]
  ) do |p|
    p.quantity = history[:quantity]
    p.unit = history[:unit]
    p.price = history[:price]
  end
end
