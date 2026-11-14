# frozen_string_literal: true

require "bibtex"
require "cgi"
require "liquid"

# Site-owned bibliography helpers; no al-folio runtime is required.
module AcademicPagesPublicationFilters
  HELPER_FIELDS = %w[
    abbr additional_info annotation award award_name bibtex_show category
    html language preview selected source_author_display source_order
    altmetric dimensions google_scholar_id inspirehep_id
  ].freeze

  OWNER_NAME = /(?<![\p{L}\p{N}_-])(?:Koki Kawabata|川畑 光希)(?![\p{L}\p{N}_-])/u

  # Remove only a complete outer pair of BibTeX capitalization braces.
  def publication_display_text(value)
    text = value.to_s.strip
    while text.start_with?("{") && text.end_with?("}")
      depth = 0
      complete_wrapper = text.each_char.with_index.all? do |character, index|
        depth += 1 if character == "{"
        depth -= 1 if character == "}"
        depth.positive? || (index == text.length - 1 && depth.zero?)
      end
      break unless complete_wrapper

      text = text[1...-1].strip
    end
    text
  end

  def publication_authors(value)
    CGI.escapeHTML(value.to_s).gsub(OWNER_NAME) do |name|
      "<strong>#{name}</strong>"
    end
  end

  # The year is displayed separately beside the badge.
  def publication_badge(abbreviation, venue, year)
    label = publication_display_text(abbreviation)
    return label unless label.empty?

    label = publication_display_text(venue)
    suffix = year.to_s.strip
    label = label.sub(/\s+#{Regexp.escape(suffix)}\z/, "") unless suffix.empty?
    label
  end

  def publication_clean_bibtex(value)
    text = value.to_s
    return "" if text.strip.empty?

    bibliography = BibTeX.parse(text)
    if bibliography.errors? || bibliography.entries.empty?
      raise Liquid::Error, "Cannot parse a publication BibTeX entry for display."
    end

    site = @context&.registers&.[](:site)
    configured = Array(site&.config&.fetch("filtered_bibtex_keywords", []))
    hidden_fields = (HELPER_FIELDS + configured.map { |field| field.to_s.downcase }).uniq

    bibliography.each_entry do |item|
      item.fields.keys.each do |field|
        name = field.to_s.downcase
        item.delete(field) if hidden_fields.include?(name) || name.start_with?("source_")
      end
    end

    bibliography.to_s.strip
  rescue BibTeX::ParseError => error
    raise Liquid::Error, "Cannot parse a publication BibTeX entry for display: #{error.message}"
  end
end

Liquid::Template.register_filter(AcademicPagesPublicationFilters)
