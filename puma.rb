
# encoding: utf-8

preload_app!

port ENV['PORT'] || 3000

rackup 'config.ru'
