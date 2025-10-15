---
title: Projects
layout: single
permalink: /projects/
classes: wide cv-page
toc: false
---

More of my work is hosted here:  
[Visit my Bioinformatics Projects →](https://ipekselcen.github.io/bioinformatics-projects/)

<div id="projects-list">Loading posts…</div>

<script>
(async function () {
  const container = document.getElementById('projects-list');

  async function fetchText(url) {
    const r = await fetch(url, { mode: 'cors' });
    if (!r.ok) throw new Error('HTTP ' + r.status + ' for ' + url);
    return r.text();
  }

  // Try feed.xml, then atom.xml, then sitemap.xml
  const BASE = 'https://ipekselcen.github.io/bioinformatics-projects';
  const candidates = [`${BASE}/feed.xml`, `${BASE}/atom.xml`, `${BASE}/sitemap.xml`];

  try {
    let xmlText = null, which = null;

    for (const url of candidates) {
      try {
        xmlText = await fetchText(url);
        which = url;
        break;
      } catch (_) {}
    }
    if (!xmlText) throw new Error('No feed/sitemap found');

    const xml = new DOMParser().parseFromString(xmlText, 'application/xml');

    // If this is a feed (Atom/RSS)
    let entries = Array.from(xml.querySelectorAll('entry, item'));
    if (entries.length) {
      const ul = document.createElement('ul');
      ul.style.listStyle = 'none';
      ul.style.paddingLeft = '0';

      entries.slice(0, 50).forEach(entry => {
        const title = (entry.querySelector('title')?.textContent || 'Untitled').trim();

        // Atom: <link rel="alternate" href="...">
        let href = entry.querySelector('link[rel="alternate"]')?.getAttribute('href')
                 || entry.querySelector('link[href]')?.getAttribute('href')
                 || entry.querySelector('guid')?.textContent
                 || '#';

        const dateStr = entry.querySelector('updated, pubDate, published')?.textContent || '';
        const li = document.createElement('li');
        li.style.margin = '0 0 0.8rem 0';

        const a = document.createElement('a');
        a.href = href;
        a.textContent = title;
        a.rel = 'noopener';
        a.style.fontWeight = '600';

        const meta = document.createElement('div');
        meta.style.fontSize = '0.9rem';
        meta.style.opacity = '0.75';
        if (dateStr) {
          const d = new Date(dateStr);
          meta.textContent = isNaN(d) ? dateStr : d.toLocaleDateString();
        }

        li.appendChild(a);
        if (dateStr) li.appendChild(meta);
        ul.appendChild(li);
      });

      container.innerHTML = '';
      container.appendChild(ul);
      return;
    }

    // Else: try sitemap.xml (<url><loc>…</loc></url>)
    const urls = Array.from(xml.querySelectorAll('url > loc'))
      .map(n => n.textContent.trim())
      .filter(u => u.startsWith(`${BASE}/`))
      .filter(u => !/\/(page\/\d+|tags|categories|assets|index\.html)$/.test(u));

    if (urls.length) {
      const ul = document.createElement('ul');
      ul.style.listStyle = 'none';
      ul.style.paddingLeft = '0';

      urls.slice(0, 50).forEach(href => {
        const title = decodeURIComponent(href.split('/').filter(Boolean).pop()).replace(/[-_]/g, ' ');
        const li = document.createElement('li');
        li.style.margin = '0 0 0.8rem 0';

        const a = document.createElement('a');
        a.href = href;
        a.textContent = title || href;
        a.rel = 'noopener';
        a.style.fontWeight = '600';

        li.appendChild(a);
        ul.appendChild(li);
      });

      container.innerHTML = '';
      container.appendChild(ul);
      return;
    }

    throw new Error('No entries in feed/sitemap');
  } catch (err) {
    console.error(err);
    container.innerHTML = `
      <p>Couldn’t load the project list. You can view everything directly on the bioinformatics site:</p>
      <p><a href="https://ipekselcen.github.io/bioinformatics-projectso/">Go to Bioinformatics Projects →</a></p>
    `;
  }
})();
</script>
