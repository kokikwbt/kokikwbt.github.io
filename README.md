# Koki Kawabata — academic website

Personal website at https://kokikwbt.github.io, built with Jekyll and the official [AcademicPages](https://github.com/academicpages/academicpages.github.io) theme.

## Content

- `index.md`: profile, research interests, and five selected publications.
- `research.md`: research overview and selected work.
- `publications.md`: Conference Papers, Journal Articles, Student Workshop Papers, in that order.
- `about.md`: background, affiliation, and contact links.
- `papers.bib`: publication titles, authors, venues, years, page ranges, and links.

Add publications to `papers.bib`. The categories are `international` (Conference Papers), `domestic` (Journal Articles), and `student` (Student Workshop Papers). `source_order` controls the display order within each category. Set `selected = {true}` for the home page. Forthcoming papers use `note = {(to appear)}`. Include a DOI after it has been assigned.

Each compact publication row has a venue tag in the list marker position, followed by the title, authors, publication details, and available links. This marker treatment is inspired by [al-folio](https://github.com/alshedivat/al-folio). The native BibTeX disclosure shows citation data without the site's display fields. Search filters the title, authors, venue, and year; all entries remain available when JavaScript is disabled.

## Build and preview

Use Ruby 3.3.12 and Bundler:

```sh
bundle install
bundle exec jekyll serve
```

Production build:

```sh
JEKYLL_ENV=production bundle exec jekyll build
```

GitHub Actions builds pull requests. Changes merged into `master` are built and deployed to GitHub Pages. The public paths remain `/`, `/research.html`, `/publications.html`, and `/about.html`, including the Contact anchor. The build generates `sitemap.xml`.

## Theme and customization

AcademicPages is pinned through Jekyll Remote Theme to commit `8c57e1ae5da379512eb11165257fba02664b8531`. The official layouts, Sass, navigation, and light/dark behavior are loaded from that version. A build needs access to GitHub to retrieve the theme. Ruby dependencies are recorded in `Gemfile.lock`.

- `_data/navigation.yml` keeps the existing page URLs.
- `_includes/author-profile.html` supplies the profile sidebar and supports an optional photograph.
- `_layouts/bib.liquid` preserves full author names and Japanese name order.
- `_plugins/publication_filters.rb` removes site-specific helper fields from exported BibTeX.
- `_includes/publication-search.html` filters publication rows and hides empty sections.
- `assets/css/main.scss` keeps the official theme imports and adds the compact publication rows and venue tags.
- `_includes/email-protection.html` retains the click-to-reveal email address.
- Head and SEO overrides omit unavailable placeholder icons and images. The footer links to the generated sitemap.

### Theme JavaScript

`assets/js/main.min.js` is generated from the pinned official source with UglifyJS 3.19.3. A normal site build does not require Node.js. When updating the theme, regenerate this file in its matching upstream checkout with the official input order:

```sh
npm exec --yes --package=uglify-js@3.19.3 -- uglifyjs assets/js/plugins/jquery.greedy-navigation.js assets/js/_main.js assets/js/theme.js -c -m -o assets/js/main.min.js
```

The generated script is loaded as a module, with jQuery loaded first, as in the official theme.

## Preserved sources and licenses

The former Quarto sources and styles are retained as historical source files and excluded from the Jekyll output. Edit the Markdown and BibTeX files above for the current site.

`LICENSE.academicpages` retains the AcademicPages MIT license for copied template files and generated theme JavaScript. `LICENSE.al-folio` retains the license from the earlier theme migration.
