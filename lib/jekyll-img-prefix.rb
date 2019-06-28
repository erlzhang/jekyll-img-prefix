module Jekyll
  module AssetFilter
    require 'jekyll'
    require 'nokogiri'

    def img_prefix(content)
      img_url = @context.registers[:site].config['img_prefix']
      return content unless img_url

      doc = Nokogiri::HTML.fragment(content)
      return content unless doc

      doc.css('img').each do |img|
        original_url = img.get_attribute("src")
        next if original_url =~ /\Ahttp/i

        new_url = img_url.to_s + relative_url(original_url)
        img.set_attribute('src', new_url)
      end
      doc.to_s
    end

    def img_url_prefix(input)
      img_url = @context.registers[:site].config['img_prefix']
      img_url.to_s + relative_url(input)
    end
  end
end

Liquid::Template.register_filter(Jekyll::AssetFilter)
