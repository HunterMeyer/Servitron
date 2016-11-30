require 'capybara'
require 'capybara/poltergeist'
require 'capybara/dsl'

class ScreenshotService
  include Capybara::DSL
  attr_reader :url, :options, :session, :visit

  def initialize(url, options = {})
    @url     = url
    @options = options
  end

  def capture
    start
    save_screenshot
  ensure
    quit
  end

  private

  def save_screenshot
    file = format_file_name(options['file_name'] || "#{session.title}_#{Time.now.to_s(:number)}")
    path = "#{Rails.root}/tmp/screenshots/#{file}"
    session.save_screenshot(path, options)
  end

  def quit
    session.driver.quit
  end

  def start
    @session = new_session
    @visit   = session.visit(url)
    sleep 4
  end

  def new_session
    set_defaults
    sess = Capybara::Session.new(:poltergeist)
    sess.driver.headers = { 'User-Agent' => 
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:36.0) Gecko/20100101 Firefox/36.0'
    }
    sess
  end

  def set_defaults
    Phantomjs.path
    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, phantomjs: Phantomjs.path, js_errors: false)
    end
    Capybara.default_driver    = :poltergeist
    Capybara.javascript_driver = :poltergeist
  end

  def format_file_name(name)
    "#{name.gsub(/[^a-z0-9_-]/i, '_')}.png"
  end
end
