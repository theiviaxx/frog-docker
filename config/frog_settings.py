import os
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# Use a very simple auth system
AUTHENTICATION_BACKENDS = ('frog.auth.SimpleAuthBackend',)

# Used in email links
FROG_SITE_URL = 'http://127.0.0.1/'

# Which machine is hosting this?  Add the domain host for the machine here
ALLOWED_HOSTS = ['127.0.0.1']

# Set this to False if hosting publicly, otherwise leave this True to provide debug info
DEBUG = True