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

  # Return plain text; the shared bibliography template escapes it as a whole.
  def publication_acceptance_text(value)
    return "" if value.nil?
    raise Liquid::Error, "Acceptance data must be a mapping." unless value.is_a?(Hash)

    accepted = value["accepted"]
    submitted = value["submitted"]
    reported_rate = value["reported_rate"]
    approximate = value["approximate"]
    scope = value["scope"]
    denominator = value["denominator"]

    unless scope.is_a?(String) && !scope.strip.empty?
      raise Liquid::Error, "Acceptance scope must be a non-empty string."
    end
    unless denominator.nil? || (denominator.is_a?(String) && !denominator.strip.empty?)
      raise Liquid::Error, "Acceptance denominator must be a non-empty string."
    end
    unless approximate.nil? || approximate == true || approximate == false
      raise Liquid::Error, "Acceptance approximate must be a boolean."
    end
    { "accepted" => accepted, "submitted" => submitted }.each do |name, count|
      next if count.nil?
      unless count.is_a?(Integer) && count.positive?
        raise Liquid::Error, "Acceptance #{name} must be a positive integer."
      end
    end
    if !reported_rate.nil? &&
       !(reported_rate.is_a?(Numeric) && reported_rate.finite? && reported_rate.between?(0, 100))
      raise Liquid::Error, "Reported acceptance rate must be a finite number from 0 to 100."
    end
    if !accepted.nil? && (submitted.nil? || accepted > submitted)
      raise Liquid::Error, "Accepted count requires a submitted count at least as large."
    end
    if accepted.nil? && reported_rate.nil?
      raise Liquid::Error, "A reported acceptance rate is required when the accepted count is absent."
    end

    grouped = ->(count) { count.to_s.reverse.scan(/\d{1,3}/).join(",").reverse }
    if accepted
      percentage = format("%.1f", 100.0 * accepted / submitted)
      result = "#{grouped.call(accepted)}/#{grouped.call(submitted)} (#{percentage}%)"
    else
      result = "#{format('%.1f', reported_rate)}%"
    end
    "Acceptance: #{result}"
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

# Scholar renders its own Liquid template non-strictly, so validate data before
# rendering to ensure malformed acceptance records stop the build.
Jekyll::Hooks.register :site, :post_read do |site|
  acceptance = site.data["acceptance"]
  next if acceptance.nil?
  unless acceptance.is_a?(Hash)
    raise Jekyll::Errors::FatalException, "Acceptance data must be keyed by publication."
  end

  formatter = Object.new.extend(AcademicPagesPublicationFilters)
  acceptance.each do |key, record|
    begin
      raise Liquid::Error, "Acceptance record must not be empty." if record.nil?
      formatter.publication_acceptance_text(record)
    rescue Liquid::Error => error
      raise Jekyll::Errors::FatalException, "Invalid acceptance data for #{key}: #{error.message}"
    end
  end
end
