---
title: Blog
permalink: /blog/
layout: single
classes: wide cv-page
toc: false
---

Welcome to my learning log. I post concise notes and explainers. Browse the latest below, or see the full archive on the home page.

{% for post in site.posts %}
- [{{ post.title }}]({{ post.url }}) — <small>{{ post.date | date: "%b %d, %Y" }}</small><br/>
  {{ post.excerpt }}
{% endfor %}
