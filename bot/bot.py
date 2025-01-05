from telegram.ext import Updater
from config import BOT_TOKEN

bot = VotingBot()
updater = Updater(BOT_TOKEN)

# Add handlers
updater.dispatcher.add_handler(CommandHandler('register', bot.register_wallet))
updater.dispatcher.add_handler(CommandHandler('vote', bot.vote))
updater.dispatcher.add_handler(CommandHandler('status', bot.status))

updater.start_polling()