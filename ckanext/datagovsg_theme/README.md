# CKAN Data.gov.sg Theme

A modern, clean CKAN theme inspired by Singapore's [data.gov.sg](https://data.gov.sg) portal.

## Features

- 🎨 **Modern Design**: Clean, professional interface with purple accent color (#6253e8)
- 📱 **Responsive**: Mobile-friendly layout that works on all devices
- 🚀 **Performance**: Optimized CSS with smooth transitions and animations
- 🎯 **User-Friendly**: Enhanced user experience with improved navigation and search
- 🌐 **Accessible**: Following web accessibility best practices

## Design Elements

### Color Scheme
- **Primary Color**: `#6253e8` (Purple)
- **Primary Dark**: `#4f42ba`
- **Primary Light**: `#7d6ff0`
- **Text Color**: `#1a1a1a`
- **Background**: `#f8f9fa`

### Key Features
- Gradient header with purple theme
- Modern card-based layout
- Smooth hover effects and transitions
- Enhanced search interface
- Clean typography
- Rounded corners and soft shadows

## Installation

### 1. Install the Extension

The extension is already in your CKAN installation at:
```
ckanext/datagovsg_theme/
```

### 2. Add to CKAN Configuration

Edit your CKAN configuration file (usually `/etc/ckan/default/ckan.ini` or `development.ini`):

```ini
# Add datagovsg_theme to the list of plugins
ckan.plugins = ... datagovsg_theme

# Optional: Set site title and description
ckan.site_title = Data Portal
ckan.site_description = Singapore's open data portal
```

### 3. Restart CKAN

Restart your CKAN instance:

```bash
# If using development server
ckan -c /path/to/ckan.ini run

# If using production (systemd)
sudo systemctl restart ckan

# If using supervisor
sudo supervisorctl restart ckan-web
```

### 4. Clear Cache (if needed)

If you don't see the changes immediately, clear the cache:

```bash
ckan -c /path/to/ckan.ini cache clear
```

## File Structure

```
ckanext/datagovsg_theme/
├── __init__.py                 # Python package initialization
├── plugin.py                   # Main plugin file
├── README.md                   # This file
├── assets/
│   ├── datagovsg_theme.css    # Main CSS file
│   └── webassets.yml          # Webassets configuration
├── templates/
│   ├── base.html              # Base template (includes CSS)
│   ├── header.html            # Custom header
│   └── home/
│       └── index.html         # Homepage template
└── public/                     # Static files (images, fonts, etc.)
```

## Customization

### Changing Colors

Edit `ckanext/datagovsg_theme/assets/datagovsg_theme.css` and modify the CSS variables:

```css
:root {
  --primary-color: #6253e8;      /* Change this to your color */
  --primary-dark: #4f42ba;       /* Darker shade */
  --primary-light: #7d6ff0;      /* Lighter shade */
}
```

### Customizing Homepage

Edit `ckanext/datagovsg_theme/templates/home/index.html` to change:
- Hero section text
- Featured content
- Layout and structure

### Adding Your Logo

1. Place your logo in `ckanext/datagovsg_theme/public/`
2. Update CKAN config:
```ini
ckan.site_logo = /datagovsg_theme/your-logo.png
```

### Customizing Templates

You can override any CKAN template by creating a file with the same name in the `templates/` directory. For example:

- `templates/package/search.html` - Dataset search page
- `templates/organization/index.html` - Organizations listing
- `templates/footer.html` - Site footer

## Development

### Making CSS Changes

1. Edit `ckanext/datagovsg_theme/assets/datagovsg_theme.css`
2. Restart CKAN or clear cache
3. Refresh your browser (Ctrl+F5 for hard refresh)

### Adding New Templates

1. Create template file in `templates/` directory
2. Use `{% ckan_extends %}` to extend default templates
3. Override specific blocks as needed

Example:
```jinja2
{% ckan_extends %}

{% block primary_content %}
  {{ super() }}
  <!-- Your custom content here -->
{% endblock %}
```

## Troubleshooting

### Theme not showing up?

1. **Check plugin is enabled**: Verify `datagovsg_theme` is in `ckan.plugins` in your config file
2. **Restart CKAN**: Make sure you restarted CKAN after configuration changes
3. **Clear cache**: Run `ckan -c /path/to/ckan.ini cache clear`
4. **Check logs**: Look at CKAN logs for any errors

### CSS not loading?

1. **Hard refresh**: Press Ctrl+F5 (or Cmd+Shift+R on Mac)
2. **Check webassets**: Ensure `webassets.yml` is properly configured
3. **Verify file paths**: Check that CSS file exists in `assets/` directory

### Template errors?

1. **Check syntax**: Ensure Jinja2 syntax is correct
2. **Check extends**: Make sure `{% ckan_extends %}` is at the top
3. **Check logs**: CKAN logs will show template errors

## Support

For issues or questions:
1. Check CKAN documentation: https://docs.ckan.org/en/latest/theming/
2. Review CKAN theming guide: https://docs.ckan.org/en/latest/theming/templates.html
3. Check CKAN community forum: https://github.com/ckan/ckan/discussions

## License

This theme is provided as-is for use with CKAN.

## Credits

Inspired by Singapore's [data.gov.sg](https://data.gov.sg) portal design.
Built for CKAN - The world's leading open-source data portal platform.

---

**Version**: 1.0.0  
**CKAN Compatibility**: 2.9+  
**Bootstrap Version**: 5 (default) / 3 (legacy)

