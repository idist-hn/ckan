# Quick Installation Guide - Data.gov.sg Theme

## 🚀 Quick Start (3 Steps)

### Step 1: Enable the Plugin

Edit your CKAN configuration file (e.g., `/etc/ckan/default/ckan.ini` or `development.ini`):

```ini
# Find the ckan.plugins line and add datagovsg_theme
ckan.plugins = stats text_view image_view recline_view datagovsg_theme

# Optional: Customize your site
ckan.site_title = My Data Portal
ckan.site_description = Open data for everyone
```

### Step 2: Restart CKAN

**Development Server:**
```bash
ckan -c /path/to/ckan.ini run
```

**Production (systemd):**
```bash
sudo systemctl restart ckan
```

**Production (supervisor):**
```bash
sudo supervisorctl restart ckan-web
```

### Step 3: Clear Cache (if needed)

```bash
ckan -c /path/to/ckan.ini cache clear
```

## ✅ Verify Installation

1. Open your CKAN site in a browser
2. You should see:
   - Purple header (#6253e8)
   - Modern card-based layout
   - Enhanced search interface
   - Smooth animations

## 🎨 Quick Customization

### Change Primary Color

Edit `ckanext/datagovsg_theme/assets/datagovsg_theme.css`:

```css
:root {
  --primary-color: #YOUR_COLOR_HERE;
}
```

### Add Your Logo

1. Place logo in `ckanext/datagovsg_theme/public/`
2. Update config:
```ini
ckan.site_logo = /datagovsg_theme/your-logo.png
```

### Customize Homepage Text

Edit `ckanext/datagovsg_theme/templates/home/index.html`

## 🐛 Troubleshooting

**Theme not showing?**
- Check `datagovsg_theme` is in `ckan.plugins`
- Restart CKAN
- Clear browser cache (Ctrl+F5)

**CSS not loading?**
- Hard refresh browser (Ctrl+Shift+R)
- Clear CKAN cache: `ckan -c /path/to/ckan.ini cache clear`

**Errors in logs?**
- Check CKAN logs: `tail -f /var/log/ckan/ckan.log`
- Verify all files are in place

## 📚 Full Documentation

See [README.md](README.md) for complete documentation.

## 🎯 What's Included

- ✅ Modern purple theme (#6253e8)
- ✅ Responsive design
- ✅ Enhanced homepage
- ✅ Custom header & footer
- ✅ Improved search interface
- ✅ Smooth animations
- ✅ Card-based layouts

## 🔗 Useful Links

- CKAN Documentation: https://docs.ckan.org
- CKAN Theming Guide: https://docs.ckan.org/en/latest/theming/
- data.gov.sg: https://data.gov.sg

---

**Need Help?** Check the [README.md](README.md) for detailed documentation.

