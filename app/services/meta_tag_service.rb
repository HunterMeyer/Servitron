class MetaTagService
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def all
    html.css('meta')
  end

  def find(tag_name) # examples: 'og:image', 'og:title'
    html.at_css("meta[property='#{tag_name}']")&.attr('content')
  end

  private

  def html
    @html ||= Nokogiri::HTML.parse(HTTParty.get(url))
  end
end
