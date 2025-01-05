import os
from dotenv import load_dotenv

load_dotenv()

BOT_TOKEN = os.getenv('BOT_TOKEN')
CONTRACT_ADDRESS = os.getenv('CONTRACT_ADDRESS')
CONTRACT_NAME = 'token-lock'