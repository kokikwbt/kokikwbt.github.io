# Koki Kawabata — academic website

Personal website at https://kokikwbt.github.io, built with Jekyll and the official [al-folio](https://github.com/alshedivat/al-folio) theme.

## Content

- `index.md`: profile, research interests, and recent publications.
- `research.md`: research overview and selected work.
- `publications.md`: publication categories and bibliography display.
- `about.md`: background, affiliation, and contact links.
- `papers.bib`: the publication data, including authors, venues, years, page ranges, and existing links.

New publications are added to `papers.bib`. Set `category` to `international`, `student`, `domestic`; use `selected = {true}` for the home page. `source_order` controls the order within year groups. Forthcoming papers use `note = {(to appear)}`. Include a DOI after it has been assigned.

## Build and preview

Use Ruby 3.3.12 and Bundler:

```bash
bundle install
bundle exec jekyll serve
```

For a production build:

```bash
JEKYLL_ENV=production bundle exec jekyll build
```

GitHub Actions builds pull requests. Changes merged into `master` are built and deployed to GitHub Pages. The public page paths remain `/`, `/research.html`, `/publications.html`, and `/about.html`.

## Theme customization

The versioned `al_folio_core` gem supplies the theme layouts and runtime assets. `assets/css/main.scss` retains the core stylesheet imports and adds the blue accent. `_layouts/bib.liquid` preserves Japanese author name order and displays available volume, issue, and page information. The original email reveal behavior is in `_includes/email-protection.html`.

Load `jekyll-cache-bust` before `al_folio_core` so the theme can resolve its packaged assets. Dependency versions are recorded in `Gemfile.lock`.

The former Quarto sources and styles are retained as historical source files and are excluded from the Jekyll output. Edit the Markdown and BibTeX files above for the current site.

Copied al-folio template files retain the upstream license in `LICENSE.al-folio`. The license applies to those template files.
