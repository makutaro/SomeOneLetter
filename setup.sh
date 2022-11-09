echo "-- db:create実行--"
rails db:create
echo "-- db:migrate実行--"
rails db:migrate
echo "-- db:seed実行--"
rails db:seed
echo "-- bundle install実行--"
bundle install
echo "-- yarn install実行--"
yarn install
echo "-- asset:compile 実行--"
rails assets:precompile
echo "-- complete!!--"
