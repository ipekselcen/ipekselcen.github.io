# Ipek Selcen's Portfolio Site

Professional portfolio for chromatin biology and bioinformatics career.

## Setup Instructions

### Option 1: Full Custom HTML (Simplest)

1. Copy `index.html` to the root of your repository
2. Delete Jekyll files (_config.yml, Gemfile, etc.)
3. Push to GitHub
4. Visit https://ipekselcen.github.io

### Option 2: Hybrid (Custom Portfolio + Jekyll Blog)

This gives you the custom portfolio homepage plus a Jekyll-powered blog for progress tracking.

1. **Replace these files in your repository:**
   - `index.html` → Use `index-hybrid.html`
   - `_config.yml` → Use provided config
   - `blog.html` → Add to root

2. **Add these folders:**
   - `_layouts/` → Contains default.html and post.html
   - `_posts/` → Contains your blog posts (markdown files)

3. **File structure:**
```
your-repo/
├── index.html              # Custom portfolio (from index-hybrid.html)
├── blog.html               # Blog index page
├── _config.yml             # Jekyll config
├── _layouts/
│   ├── default.html
│   └── post.html
└── _posts/
    └── 2025-10-24-building-portfolio.md
```

4. **To add new blog posts:**
   - Create files in `_posts/` folder
   - Format: `YYYY-MM-DD-title.md`
   - Add frontmatter:
```markdown
---
layout: post
title: "Your Post Title"
date: 2025-10-24
categories: [bioinformatics, chromatin]
---

Your content here...
```

5. **Push to GitHub:**
```bash
git add .
git commit -m "Update portfolio with hybrid design"
git push
```

6. **Enable GitHub Pages:**
   - Go to repository Settings → Pages
   - Source: Deploy from main branch
   - Your site will be live at https://ipekselcen.github.io

## Customization

### Update Your Information

In `index.html`, replace:
- Your email address
- LinkedIn URL
- Google Scholar profile
- Publications
- Project details

### Blog Posts

Write about:
- Research progress
- Learning new techniques
- Paper summaries
- Tool development
- Career reflections

### Styling

The color scheme uses:
- Primary: #667eea (purple-blue)
- Secondary: #764ba2 (deep purple)
- Background: #f8f9fa (light gray)

Modify these in the `<style>` section to match your preferences.

## Support

For issues with:
- GitHub Pages: https://docs.github.com/pages
- Jekyll: https://jekyllrb.com/docs/

## License

Feel free to use this template for your own portfolio!