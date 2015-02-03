FROM rails:onbuild

RUN bundle exec rake assets:precompile

CMD ["bundle", "exec", "unicorn -p 3000 -c ./config/unicorn.rb"]
