FROM rails:onbuild

RUN bundle exec rake RAILS_ENV=production DATABASE_URL=postgresql://user:pass@127.0.0.1/dbname assets:precompile

CMD ["bundle", "exec", "unicorn -p 3000 -c ./config/unicorn.rb"]
