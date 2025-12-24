# Bundler 4.0.x reproduction

## Run


## Expected

Installing Bundler 4.0.x and then running `bundle install` followed by `bundle clean` should not remove the version of bundler that was used to install gems via `bundle install`

## Actual

When you run the script in `Dockerfile` it installs bundler 4.0.3, runs `bundle install && bundle clean` then `bundle -v` returns `Bundler version 2.6.9` which is the default verison for Ruby 3.4.8

## Run

```
$ ./reproduce.sh
# ...
Bundler version 2.6.9
```


## Notes

If you remove the `bundle clean` or you remove the `COPY bin ./bin/` (bundler binstub copy) then it returns the correct result.

The `bundle clean` is used on Heroku and this binstub comes by standard on Rails applications for a LONG time, however stopped being generated in Rails:

- https://github.com/rails/rails/pull/54687
- https://github.com/ruby/rubygems/pull/8345

This will cause a lot of failures for older applications that have a checked in `bin/bundle` binstub that wish to use Bundler 4.0+
