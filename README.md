
# Epigenetics Portfolio Starter (Jekyll + GitHub Pages)

This is a minimal, **ready-to-deploy** starter for a scientific portfolio with a blog.

## 1) Create your GitHub Pages repo

1. Go to GitHub → **New repository**.
2. Name it **`<your-username>.github.io`** (exactly). Example: `ipekselcen.github.io`.
3. Keep it **Public**. Create the repo.

## 2) Download & unzip this starter

- Download the ZIP from ChatGPT (this file). Unzip it on your computer.

## 3) Add your files to the repo

- Drag **all files and folders** (including `_config.yml`, `_posts`, etc.) into your new repo. Commit/push.

## 4) Wait for GitHub Pages to build

- Visit `https://<your-username>.github.io` — your site should appear in a minute or two.

## 5) Customize

- Open `_config.yml` and set your GitHub, LinkedIn, and ORCID links.
- Edit the page markdown files (`about.md`, `projects.md`, `publications.md`, `cv.md`, `contact.md`).
- Write new blog posts by creating markdown files in `_posts/` named like `YYYY-MM-DD-title.md`.

## Optional: test locally

If you want to preview locally:

```bash
# Requires Ruby and Bundler
gem install bundler jekyll
bundle init
bundle add jekyll minima jekyll-seo-tag jekyll-feed
bundle exec jekyll serve
```

Then open http://127.0.0.1:4000 in your browser.

---

### Posting guide

- Create a new file in `_posts/`:
  - `YYYY-MM-DD-your-title.md`
- Front matter:
  ```
  ---
  layout: post
  title: "Your title"
  ---
  ```
- Write in Markdown.

### Projects

You can create standalone pages inside the `projects/` collection if desired. For simple use, keep everything in `projects.md` first and split later.

---

**You’ve got this.** Keep posts short and frequent. This site is a *practice space*.
