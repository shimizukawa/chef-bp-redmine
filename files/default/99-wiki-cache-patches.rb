module Redmine
  module WikiFormatting
    class << self

      def to_html(format, text, options = {})
        text = if Setting.cache_formatted_text? && cache_store && cache_key = cache_key_for(format, options[:object], options[:attribute])
          # Text retrieved from the cache store may be frozen
          # We need to dup it so we can do in-place substitutions with gsub!
          cache_store.fetch cache_key do
            formatter_for(format).new(text).to_html
          end.dup
        else
          formatter_for(format).new(text).to_html
        end
        text
      end

      # Returns a cache key for the given text +format+, +object+ and
      # +attribute+ or nil if no caching should be done
      def cache_key_for(format, object, attribute)
        if object && attribute && !object.new_record? && object.respond_to?(:updated_on) && !format.blank?
          "formatted_text/#{format}/#{object.class.model_name.cache_key}/#{object.id}-#{attribute}-#{object.updated_on.to_s(:number)}"
        elsif object && attribute && !object.new_record? && !format.blank?
          identifier = if object.respond_to?(:notes)
            Digest::MD5.hexdigest(object.notes)
          elsif object.respond_to?(:scmid)
            "#{object.committed_on.to_s(:number) rescue ''}-#{object.revision || ''}-#{object.scmid}"
          end

          if identifier
            "formatted_text/#{format}/#{object.class.model_name.cache_key}/#{object.id}-#{attribute}-#{identifier}"
          end
        end
      end

    end
  end
end

