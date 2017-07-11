buy <- read.csv("../big_data_capstone_datasets_and_scripts/big_data_capstone_datasets_and_scripts/flamingo-data/buy-clicks.csv", na.strings = "NULL")
game <- read.csv("../big_data_capstone_datasets_and_scripts/big_data_capstone_datasets_and_scripts/flamingo-data/game-clicks.csv", na.strings = "NULL")
ad <- read.csv("../big_data_capstone_datasets_and_scripts/big_data_capstone_datasets_and_scripts/flamingo-data/ad-clicks.csv", na.strings = "NULL")

buy <- buy[,c(5,7)]
names(buy) <- c("userId", "total_spent")
game <- cbind(game, rep(1, length(game$userId)))
game <- game[,c(3,8)]
names(game) <- c("userId", "total_game_clicks")
ad <- cbind(ad, rep(1, length(ad$userId)))
ad <- ad[,c(5,8)]
names(ad) <- c("userId", "total_ad_clicks")

temp_df <- as.data.frame(cbind(unique(game$userId), rep(0, length(unique(game$userId)))))
names(temp_df) <- c("userId", "total_spent")
buy <- rbind(buy, temp_df)
names(temp_df) <- c("userId", "total_ad_clicks")
ad <- rbind(ad, temp_df)

buy <- aggregate(. ~ userId, buy, sum)
game <- aggregate(. ~ userId, game, sum)
ad <- aggregate(. ~ userId, ad, sum)

temp_df = merge(buy, game, by="userId")
final_df = merge(temp_df, ad, by="userId")

write.csv(final_df, file = "kMeansData.csv")
