# encoding: UTF-8

module Middleman
  module Sitemap
    class TocResource < ::Middleman::Sitemap::Resource
      def initialize(store, path, resource, resource_text, toc_element)
        @resource = resource
        @toc_element = toc_element
        @path = path
        @text = resource_text

        super(store, path)

        data[:title] = title
        data[:keywords] ||= ""
        data[:description] ||= ""
        data[:text] = text
        data[:url] = url
        data[:parent_title] = parent_title
      end

      def title
        @toc_element.raw_text
      end

      def text
        text_for_toc_element = nil
        toc_texts = @text.split(/(?=<h[12])/)

        toc_texts.each do |toc_text|
          if toc_text.match(/h[12] id=\"#{@toc_element.id}\"/).present?
            text_for_toc_element = toc_text
          end
        end

        text_for_toc_element
      end

      def url
        '/' + @path
      end

      def parent_title
        @resource.data.title
      end

      def render ;end
    end
  end
end
