---
layout: archive
permalink: /publications.html
title: Publications
author_profile: true
description: Publications by Koki Kawabata.
---

You can also find my articles on [Google Scholar](https://scholar.google.com/citations?view_op=search_authors&mauthors=Koki+Kawabata) and [researchmap](https://researchmap.jp/koki-kawabata).

{% include publication-search.html %}

<section class="publication-section" id="conference-papers-section" aria-labelledby="international-conference-and-workshop-papers">
<h2 id="international-conference-and-workshop-papers" class="publication-section-title">Conference Papers</h2>
{% bibliography -f papers -q @*[category=international] %}
</section>

<section class="publication-section" id="journal-articles-section" aria-labelledby="domestic-journal-articles">
<h2 id="domestic-journal-articles" class="publication-section-title">Journal Articles</h2>
{% bibliography -f papers -q @*[category=domestic] %}
</section>

<section class="publication-section" id="student-workshop-papers-section" aria-labelledby="student-workshop-papers">
<h2 id="student-workshop-papers" class="publication-section-title">Student Workshop Papers</h2>
{% bibliography -f papers -q @*[category=student] %}
</section>
