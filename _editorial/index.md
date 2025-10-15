---
title: Editorial
layout: single
permalink: /editorial/
---

More of my writing and editing work is hosted here:  
[Visit my Editorial Portfolio →](https://ipekselcen.github.io/editorial-portfolio/)

<div id="editorial-list">Loading posts…</div>

<script>
(async function () {
  const container = document.getElementById('editorial-list');
  const FEED_URL = 'https://ipekselcen.github.io/editorial-portfolio/feed.xml';

  try {
    const res = await fetch(FEED_URL);
    if (!res.ok) throw new Error('Feed request failed');
    const text = await res.text();
    const parser = new DOMParser();
    const xml = parser.parseFromString(text, 'application/xml');

    // Try Atom first, then RSS
    const entries = Array.from(xml.querySelectorAll('entry, item'));
    if (!entries.length) throw new Error('No posts found in feed');

    const ul = document.createElement('ul');
    ul.style.listStyle = 'none';
    ul.style.paddingLeft = '0';

    entries.slice(0, 30).forEach(entry => {
      const title = (entry.querySelector('title')?.textContent || 'Untitled').trim();
      const linkEl = entry.querySelector('link[href]') || entry.querySelector('link');
      const href = linkEl?.getAttribute('href') || entry.querySelector('guid')?.textContent || '#';
      const date = entry.querySelector('updated, pubDate, published')?.textContent || '';
      const li = document.createElement('li');
      li.style.margin = '0 0 0.8rem 0';

      const a = document.createElement('a');
      a.href = href;
      a.textContent = title;
      a.rel = 'noopener';
      a.style.fontWeight = '600';

      const small = document.createElement('div');
      small.style.fontSize = '0.9rem';
      small.style.opacity = '0.75';
      if (date) {
        const d = new Date(date);
        small.textContent = isNaN(d) ? date : d.toLocaleDateString();
      }

      li.appendChild(a);
      if (date) li.appendChild(small);
      ul.appendChild(li);
    });

    container.innerHTML = '';
    container.appendChild(ul);
  } catch (err) {
    console.error(err);
    container.innerHTML = `
      <p>Couldn’t load the editorial feed. You can view everything directly on the editorial site:</p>
      <p><a href="https://ipekselcen.github.io/editorial-portfolio/">Go to Editorial Portfolio →</a></p>
    `;
  }
})();
</script>
