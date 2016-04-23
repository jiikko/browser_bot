# BrowserBot
## Installation
```
$ rvm install 2.3.0
$ gem i bundler && bundle install
$ cp config.sample.yml config.yml
$ edit config.yml
```

### phamtomjs
for headless.
* debian
  * http://phantomjs.org/build.html
* MacOS
  * `brew install phantomjs`

## Usage
```shell
bin/run --help
Usage: run [options]
        --headless
        --j=job_name
        --c=config_path
```

## job list
* wantedly_click_support_link

