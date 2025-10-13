---
title: "Editorial"
permalink: /editorial/
layout: single
---

{% assign items = site.editorial | sort: "order" %}
{% for item in items %}
### <a href="{{ item.url }}">{{ item.title }}</a>
<small>{% if item.kind %}{{ item.kind }}{% endif %}{% if item.tags %} · {{ item.tags | join: ", " }}{% endif %}</small>

{{ item.summary }}

---
{% endfor %}
