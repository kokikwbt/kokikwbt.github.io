---
layout: single
permalink: /about.html
title: About
author_profile: true
---

I am an Assistant Professor at SANKEN, The University of Osaka, working on data mining and machine learning for complex, evolving data.

## Background

I received my Ph.D. in Information Science from The University of Osaka in 2021. My work spans data-stream processing, tensor decomposition, anomaly detection, and time-series analysis, with an emphasis on algorithms that are both mathematically grounded and useful in real-world settings.

## Honors & Awards
{: #honors-awards}

<ul class="about-records about-awards" role="list">
{% for award in site.data.awards %}
  <li>
    <span class="about-record-date">{{ award.date | escape }}</span>
    <div class="about-record-body">
      <a class="about-record-title" href="{{ award.url | escape }}" lang="{{ award.language | default: 'en' | escape }}">{{ award.name | escape }}</a>{% if award.context %}<span class="about-record-context"> · {{ award.context | escape }}</span>{% endif %}
    </div>
  </li>
{% endfor %}
</ul>

## Research Funding
{: #research-funding}

<ul class="about-records about-funding" role="list">
{% for project in site.data.funding %}
  <li>
    <span class="about-record-date">{{ project.period | escape }}</span>
    <div class="about-record-body">
      <a class="about-record-title" href="{{ project.url | escape }}" lang="{{ project.title_language | default: 'ja' | escape }}">{{ project.title | escape }}</a>
      <p class="about-record-meta">{{ project.role | escape }} · {{ project.scheme | escape }}{% if project.grant_number %} · {{ project.grant_number | escape }}{% endif %}{% if project.principal_investigator %} · PI: {{ project.principal_investigator | escape }}{% endif %}</p>
    </div>
  </li>
{% endfor %}
</ul>

## Affiliation

**The Institute of Scientific and Industrial Research (SANKEN)**<br>
The University of Osaka<br>
8-1 Mihogaoka, Ibaraki, Osaka 567-0047, Japan

## Contact
{: #contact}

<button type="button" class="email-reveal btn btn--inverse" data-email-reveal aria-label="Reveal email address">Reveal email address</button>

<noscript><p class="email-fallback">koki [at] sanken [dot] osaka-u [dot] ac [dot] jp</p></noscript>

- [GitHub](https://github.com/kokikwbt)
- [researchmap](https://researchmap.jp/koki-kawabata)
- [ORCID](https://orcid.org/0000-0003-4202-4513)
- [Google Scholar](https://scholar.google.com/citations?view_op=search_authors&mauthors=Koki+Kawabata)
- [DBLP](https://dblp.org/pid/219/8132)
- [X](https://x.com/kokikwbt)
- [LinkedIn](https://www.linkedin.com/in/kokikwbt/)
- [The University of Osaka profile](https://rd.iai.osaka-u.ac.jp/ja/741f1b08cc6f3c12.html)

{% include email-protection.html %}
