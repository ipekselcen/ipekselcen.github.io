---
title: Projects
layout: single
permalink: /projects/
classes: wide
---

More of my work is hosted here:  
[Visit my Bioinformatics Projects →](https://ipekselcen.github.io/bioinformatics-projects/)

<div id="projects-list" style="margin-top:1rem;">Loading projects…</div>

<script>
(async function () {
  const container = document.getElementById('projects-list');
  const BASE = 'https://ipekselcen.github.io/bioinformatics-projects';

  function makeItem(href, title, dateStr) {
    const li = document.createElement('li');
    li.style.margin = '0 0 .85rem 0';
    const a = document.createElement('a');
    a.href = href;
    a.textContent = title || href;
    a.rel = 'noopener';
    a.style.fontWeight = '600';
    li.appendChild(a);
    if (dateStr) {
      const meta = document.createElement('div');
      meta.style.fontSize = '.9rem';
      meta.style.opacity = '.75';
      meta.textContent = dateStr;
      li.appendChild(meta);
    }
    return li;
  }

  async function fetchText(url) {
    const r = await fetch(url, { mode: 'cors' });
    if (!r.ok) throw new Error(url + ' → ' + r.status);
    return r.text();
  }

  try {
    // Prefer feed (has true titles), fall back to sitemap.
    let xmlText = null, source = null;
    const candidates = [`${BASE}/feed.xml`, `${BASE}/atom.xml`, `${BASE}/sitemap.xml`];
    for (const url of candidates) {
      try { xmlText = await fetchText(url); source = url; break; } catch(e) {}
    }
    if (!xmlText) throw new Error('No feed/sitemap found');

    const xml = new DOMParser().parseFromString(xmlText, 'application/xml');

    // FEED (Atom/RSS)
    let entries = Array.from(xml.querySelectorAll('entry, item'));
    if (entries.length) {
      const ul = document.createElement('ul');
      ul.style.listStyle = 'none';
      ul.style.paddingLeft = '0';
      entries.slice(0, 50).forEach(entry => {
        const title = (entry.querySelector('title')?.textContent || 'Untitled').trim();
        const href =
          entry.querySelector('link[rel="alternate"]')?.getAttribute('href') ||
          entry.querySelector('link[href]')?.getAttribute('href') ||
          entry.querySelector('guid')?.textContent || '#';
        const d = entry.querySelector('updated, pubDate, published')?.textContent || '';
        const nice = d ? (isNaN(new Date(d)) ? d : new Date(d).toLocaleDateString()) : '';
        ul.appendChild(makeItem(href, title, nice));
      });
      container.innerHTML = '';
      container.appendChild(ul);
      return;
    }

    // SITEMAP (pages)
    const urls = Array.from(xml.querySelectorAll('url > loc'))
      .map(n => n.textContent.trim())
      .filter(u => u.startsWith(`${BASE}/`))
      .filter(u => !/\/(assets|page\/\d+|tags|categories|feed\.xml|atom\.xml|sitemap\.xml|index\.html)$/.test(u));

    const ul = document.createElement('ul');
    ul.style.listStyle = 'none';
    ul.style.paddingLeft = '0';

    for (const href of urls) {
      try {
        const html = await fetchText(href);
        const doc = new DOMParser().parseFromString(html, 'text/html');
        const title = doc.querySelector('h1, .page__title')?.textContent?.trim()
                    || decodeURIComponent(href.split('/').filter(Boolean).pop()).replace(/[-_]/g, ' ');
        const lastmod = Array.from(xml.querySelectorAll('url'))
          .find(u => u.querySelector('loc')?.textContent.trim() === href)
          ?.querySelector('lastmod')?.textContent;
        const nice = lastmod ? new Date(lastmod).toLocaleDateString() : '';
        ul.appendChild(makeItem(href, title, nice));
      } catch {
        ul.appendChild(makeItem(href, null, ''));
      }
    }

    container.innerHTML = '';
    container.appendChild(ul);

  } catch (err) {
    console.error(err);
    container.innerHTML = `
      <p>Couldn’t load the project list. You can view everything directly on the bioinformatics site:</p>
      <p><a href="${BASE}">Go to Bioinformatics Projects →</a></p>
    `;
  }
})();
</script>
