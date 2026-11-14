---
layout: page
permalink: /publications.html
title: Publications
description: Publications by Koki Kawabata.
nav: true
nav_order: 2
---

<p>Publications grouped by publication type.</p>

{% include bib_search.liquid %}

## International Conference and Workshop Papers

<div class="publications">

{% bibliography -f papers -q @*[category=international] %}

</div>

## Student Workshop Papers

<div class="publications">

{% bibliography -f papers -q @*[category=student] %}

</div>

## Domestic Journal Articles

<div class="publications">

{% bibliography -f papers -q @*[category=domestic] %}

</div>

[Complete publication list on researchmap →](https://researchmap.jp/koki-kawabata)
