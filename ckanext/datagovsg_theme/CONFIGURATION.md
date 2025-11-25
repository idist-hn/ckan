# Configuration Guide - Open Data Theme

## CKAN Configuration Options

Add these to your CKAN configuration file (`ckan.ini` or `development.ini`):

### Basic Configuration

```ini
# Enable the theme plugin
ckan.plugins = ... datagovsg_theme

# Site Information
ckan.site_title = Open Data Portal
ckan.site_description = Explore national datasets and access APIs for development
ckan.site_intro_text = Welcome to our open data portal

# Logo
ckan.site_logo = /datagovsg_theme/logo.png

# Favicon
ckan.favicon = /datagovsg_theme/favicon.ico
```

### Homepage Configuration

```ini
# Homepage style (layout1, layout2, layout3)
ckan.homepage_style = layout1

# Number of datasets to show on homepage
ckan.datasets_per_page = 20

# Featured groups/organizations
ckan.featured_groups = group1 group2 group3
ckan.featured_orgs = org1 org2 org3
```

### Search Configuration

```ini
# Default search sort
ckan.search.default_package_sort = score desc, metadata_modified desc

# Number of search results per page
ckan.search.rows_max = 1000

# Show private datasets in search (for logged-in users)
ckan.search.show_all_types = true
```

### Display Configuration

```ini
# Date format
ckan.display_timezone = Asia/Ho_Chi_Minh

# Locale/Language
ckan.locale_default = en
ckan.locale_order = en zh_CN zh_TW

# Number of items in lists
ckan.datasets_per_page = 20
ckan.activity_list_limit = 30
```

### Theme-Specific Recommendations

```ini
# Use Bootstrap 5 templates (recommended for this theme)
ckan.base_public_folder = public
ckan.base_templates_folder = templates

# Enable webassets for better performance
ckan.webassets.path = /var/lib/ckan/default/webassets

# Cache settings for better performance
ckan.cache_enabled = true
ckan.cache_expires = 3600
```

## Color Customization

Edit `ckanext/datagovsg_theme/assets/datagovsg_theme.css`:

### Primary Colors

```css
:root {
  /* Main brand color - change this to match your brand */
  --primary-color: #6253e8;
  
  /* Darker shade for hover states */
  --primary-dark: #4f42ba;
  
  /* Lighter shade for backgrounds */
  --primary-light: #7d6ff0;
  
  /* Accent color (usually same as primary) */
  --accent-color: #6253e8;
}
```

### Text Colors

```css
:root {
  /* Main text color */
  --text-color: #1a1a1a;
  
  /* Secondary text (descriptions, metadata) */
  --text-secondary: #666666;
}
```

### Background Colors

```css
:root {
  /* Light background for sections */
  --background-light: #f8f9fa;
  
  /* Border color */
  --border-color: #e0e0e0;
}
```

### Status Colors

```css
:root {
  /* Success messages, active states */
  --success-color: #10b981;
  
  /* Warning messages */
  --warning-color: #f59e0b;
  
  /* Error messages */
  --error-color: #ef4444;
}
```

## Template Customization

### Homepage Hero Section

Edit `ckanext/datagovsg_theme/templates/home/index.html`:

```jinja2
<section class="hero">
  <div class="container">
    <h1>{{ _("Your Custom Title") }}</h1>
    <p>{{ _("Your custom description") }}</p>
  </div>
</section>
```

### Header Navigation

Edit `ckanext/datagovsg_theme/templates/header.html`:

```jinja2
{{ h.build_nav_main(
  ('dataset.search', _('Datasets')),
  ('organization.index', _('Organizations')),
  ('group.index', _('Groups')),
  ('home.about', _('About')),
  ('custom.page', _('Custom Page'))  # Add your custom pages
) }}
```

### Footer Links

Edit `ckanext/datagovsg_theme/templates/footer.html` to customize footer content.

## Advanced Customization

### Adding Custom CSS

Create additional CSS file in `assets/` directory:

1. Create `assets/custom.css`
2. Add to `assets/webassets.yml`:
```yaml
datagovsg_theme:
  output: datagovsg_theme/datagovsg_theme.css
  contents:
    - datagovsg_theme.css
    - custom.css
```

### Adding Custom JavaScript

1. Create `assets/custom.js`
2. Add to `assets/webassets.yml`:
```yaml
datagovsg_theme_js:
  output: datagovsg_theme/datagovsg_theme.js
  contents:
    - custom.js
```

3. Include in template:
```jinja2
{% block scripts %}
  {{ super() }}
  {% asset 'datagovsg_theme/datagovsg_theme_js' %}
{% endblock %}
```

### Custom Fonts

1. Add font files to `public/fonts/`
2. Add to CSS:
```css
@font-face {
  font-family: 'YourFont';
  src: url('/datagovsg_theme/fonts/yourfont.woff2') format('woff2');
}

body {
  font-family: 'YourFont', sans-serif;
}
```

## Performance Optimization

### Enable Caching

```ini
# In ckan.ini
ckan.cache_enabled = true
ckan.cache_expires = 3600

# Redis cache (recommended for production)
ckan.redis.url = redis://localhost:6379/0
```

### Minify Assets

```ini
# Enable asset minification
ckan.webassets.debug = false
```

### CDN Configuration

For production, consider using a CDN for static assets:

```ini
ckan.site_url = https://yourdomain.com
ckan.root_path = /data/{{LANG}}
```

## Multilingual Support

### Enable Multiple Languages

```ini
ckan.locale_default = en
ckan.locale_order = en zh_CN zh_TW ms

# Locales offered
ckan.locales_offered = en zh_CN zh_TW ms

# Locales filtered out
ckan.locales_filtered_out = 
```

### Translate Custom Text

Create translation files in `i18n/` directory (see CKAN documentation).

## Security Settings

```ini
# HTTPS only (production)
ckan.site_url = https://yourdomain.com

# Security headers
ckan.cors.origin_allow_all = false
ckan.cors.origin_whitelist = https://yourdomain.com

# Session security
beaker.session.secure = true
beaker.session.httponly = true
```

## Monitoring & Analytics

### Google Analytics

```ini
ckan.google_analytics.id = UA-XXXXXXXXX-X
ckan.google_analytics.domain = auto
```

### Custom Analytics

Add to `templates/base.html`:

```jinja2
{% block custom_analytics %}
  <!-- Your analytics code here -->
{% endblock %}
```

## Troubleshooting Configuration

### Check Current Configuration

```bash
ckan -c /path/to/ckan.ini config-tool /path/to/ckan.ini -s ckan.plugins
```

### Validate Configuration

```bash
ckan -c /path/to/ckan.ini config-tool /path/to/ckan.ini --validate
```

### Reset Cache

```bash
ckan -c /path/to/ckan.ini cache clear
```

## Example Production Configuration

```ini
[app:main]
use = egg:ckan
full_stack = true

# Site
ckan.site_title = Open Data Portal
ckan.site_logo = /datagovsg_theme/logo.png
ckan.site_description = Open data for everyone
ckan.site_url = https://data.example.gov.sg
ckan.favicon = /datagovsg_theme/favicon.ico

# Plugins
ckan.plugins = stats text_view image_view recline_view datastore datapusher datagovsg_theme

# Theme
ckan.base_public_folder = public
ckan.base_templates_folder = templates

# Performance
ckan.cache_enabled = true
ckan.cache_expires = 3600
ckan.webassets.debug = false

# Locale
ckan.locale_default = en
ckan.locale_order = en zh_CN
ckan.display_timezone = Asia/Ho_Chi_Minh

# Search
ckan.search.default_package_sort = score desc, metadata_modified desc
ckan.datasets_per_page = 20
```

---

For more information, see [README.md](README.md) or visit [CKAN Documentation](https://docs.ckan.org).

