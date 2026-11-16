---
layout: single
permalink: /research.html
title: Research
author_profile: true
---

<div class="research-overview">
  <p class="research-intro">Research on evolving data combines time-series modeling, tensor methods, and graph learning to understand patterns, relationships, and future behavior.</p>

  <div class="research-themes">
    {% for theme in site.data.research %}
    <section class="research-theme" aria-labelledby="{{ theme.id }}-heading">
      <h2 id="{{ theme.id }}-heading">{{ theme.title | escape }}</h2>
      <figure class="research-theme-figure">
        {% include {{ theme.illustration }} %}
        <figcaption>{{ theme.question | escape }}</figcaption>
      </figure>
      <p class="research-theme-description">{{ theme.description | escape }}</p>
      <div class="research-theme-work">
        <p class="research-work-label">Selected publications</p>
        <ul class="research-work-list">
          {% for work in theme.works %}
          <li>
            <div class="research-work-marker">
              <span class="venue-tag" data-venue="{{ work.venue | escape }}">{{ work.venue | escape }}</span>
              <span class="research-work-year">{{ work.year }}</span>
            </div>
            <a href="{{ '/publications.html' | relative_url }}#{{ work.key }}"{% if work.language %} lang="{{ work.language }}"{% endif %}>{{ work.title | escape }}</a>
          </li>
          {% endfor %}
        </ul>
      </div>
    </section>
    {% endfor %}
  </div>

  <p class="research-publications"><a href="{{ '/publications.html' | relative_url }}">View all publications <span aria-hidden="true">→</span></a></p>
</div>
