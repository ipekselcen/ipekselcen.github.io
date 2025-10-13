---
title: "Projects"
permalink: /projects/
layout: single
---

{% assign items = site.projects | sort: "order" %}
{% for item in items %}
### <a href="{{ item.url }}">{{ item.title }}</a>
<small>{% if item.role %}{{ item.role }}{% endif %}{% if item.tags %} · {{ item.tags | join: ", " }}{% endif %}</small>

{{ item.summary }}

---
{% endfor %}
