# ✅ Installation & Customization Checklist

## 📋 Pre-Installation

- [ ] CKAN 2.9+ installed and running
- [ ] Access to CKAN configuration file
- [ ] Ability to restart CKAN service
- [ ] Text editor ready

## 🚀 Installation Steps

### Step 1: Configuration
- [ ] Open CKAN config file (`ckan.ini` or `development.ini`)
- [ ] Find the `ckan.plugins` line
- [ ] Add `datagovsg_theme` to the plugins list
- [ ] Save the file

**Example:**
```ini
ckan.plugins = stats text_view image_view recline_view datagovsg_theme
```

### Step 2: Restart CKAN
- [ ] Stop CKAN if running
- [ ] Start CKAN with new configuration
- [ ] Check for errors in logs

**Commands:**
```bash
# Development
ckan -c development.ini run

# Production (systemd)
sudo systemctl restart ckan

# Production (supervisor)
sudo supervisorctl restart ckan-web
```

### Step 3: Verify Installation
- [ ] Open CKAN in browser
- [ ] Check header is purple
- [ ] Check homepage has hero section
- [ ] Check search bar is styled
- [ ] Check footer is updated
- [ ] Test on mobile device

### Step 4: Clear Cache (if needed)
- [ ] Clear CKAN cache
- [ ] Clear browser cache
- [ ] Hard refresh browser

**Commands:**
```bash
ckan -c /path/to/ckan.ini cache clear
```

## 🎨 Basic Customization

### Site Information
- [ ] Set site title
- [ ] Set site description
- [ ] Set site intro text

**In ckan.ini:**
```ini
ckan.site_title = Your Portal Name
ckan.site_description = Your description
ckan.site_intro_text = Welcome message
```

### Logo & Branding
- [ ] Prepare logo file (PNG recommended)
- [ ] Place logo in `ckanext/datagovsg_theme/public/`
- [ ] Update config with logo path
- [ ] Prepare favicon
- [ ] Update config with favicon path

**In ckan.ini:**
```ini
ckan.site_logo = /datagovsg_theme/logo.png
ckan.favicon = /datagovsg_theme/favicon.ico
```

### Color Customization
- [ ] Decide on primary color
- [ ] Calculate dark shade (20% darker)
- [ ] Calculate light shade (20% lighter)
- [ ] Update CSS variables
- [ ] Test color contrast
- [ ] Verify accessibility

**In assets/datagovsg_theme.css:**
```css
:root {
  --primary-color: #YOUR_COLOR;
  --primary-dark: #DARKER_SHADE;
  --primary-light: #LIGHTER_SHADE;
}
```

## 📝 Content Customization

### Homepage
- [ ] Update hero title
- [ ] Update hero description
- [ ] Customize search placeholder
- [ ] Update feature cards text
- [ ] Add/remove sections

**Edit:** `templates/home/index.html`

### Header Navigation
- [ ] Review navigation items
- [ ] Add custom pages
- [ ] Remove unwanted items
- [ ] Reorder menu items

**Edit:** `templates/header.html`

### Footer
- [ ] Update About section
- [ ] Update Resources links
- [ ] Update Help links
- [ ] Update Connect/Social links
- [ ] Update copyright text

**Edit:** `templates/footer.html`

## 🔧 Advanced Customization

### Custom CSS
- [ ] Create `assets/custom.css`
- [ ] Add custom styles
- [ ] Update `webassets.yml`
- [ ] Test changes
- [ ] Clear cache

### Custom Templates
- [ ] Identify template to override
- [ ] Create template file
- [ ] Add `{% ckan_extends %}`
- [ ] Override specific blocks
- [ ] Test changes

### Custom JavaScript
- [ ] Create `assets/custom.js`
- [ ] Add functionality
- [ ] Update `webassets.yml`
- [ ] Include in template
- [ ] Test functionality

## 🧪 Testing Checklist

### Visual Testing
- [ ] Homepage displays correctly
- [ ] Search page works
- [ ] Dataset pages styled
- [ ] Organization pages styled
- [ ] Group pages styled
- [ ] User pages styled
- [ ] Admin pages accessible

### Responsive Testing
- [ ] Test on mobile (< 768px)
- [ ] Test on tablet (768px - 1024px)
- [ ] Test on desktop (> 1024px)
- [ ] Test landscape orientation
- [ ] Test portrait orientation

### Browser Testing
- [ ] Chrome/Chromium
- [ ] Firefox
- [ ] Safari
- [ ] Edge
- [ ] Mobile browsers

### Functionality Testing
- [ ] Search works
- [ ] Login/logout works
- [ ] Dataset creation works
- [ ] Dataset editing works
- [ ] File upload works
- [ ] API access works
- [ ] User registration works

### Performance Testing
- [ ] Page load time acceptable
- [ ] CSS loads properly
- [ ] Images load properly
- [ ] No console errors
- [ ] No broken links

## 🔒 Security Checklist

### Configuration
- [ ] HTTPS enabled (production)
- [ ] Secure session cookies
- [ ] CORS configured properly
- [ ] API keys secured
- [ ] Database secured

### Best Practices
- [ ] No sensitive data in templates
- [ ] No hardcoded credentials
- [ ] Input validation enabled
- [ ] CSRF protection enabled
- [ ] XSS protection enabled

## 📊 Performance Optimization

### Caching
- [ ] Enable CKAN cache
- [ ] Set cache expiry
- [ ] Configure Redis (if available)
- [ ] Test cache effectiveness

### Assets
- [ ] Minify CSS (production)
- [ ] Minify JavaScript (production)
- [ ] Optimize images
- [ ] Enable gzip compression
- [ ] Use CDN (if available)

### Database
- [ ] Optimize queries
- [ ] Index frequently searched fields
- [ ] Clean old data
- [ ] Monitor performance

## 🌍 Internationalization

### Language Support
- [ ] Enable desired languages
- [ ] Set default language
- [ ] Set locale order
- [ ] Test language switching

**In ckan.ini:**
```ini
ckan.locale_default = en
ckan.locale_order = en zh_CN zh_TW
ckan.locales_offered = en zh_CN zh_TW
```

### Translation
- [ ] Identify text to translate
- [ ] Create translation files
- [ ] Translate content
- [ ] Test translations
- [ ] Update as needed

## 📚 Documentation

### Internal Documentation
- [ ] Document customizations made
- [ ] Document color choices
- [ ] Document custom templates
- [ ] Document custom CSS
- [ ] Document configuration

### User Documentation
- [ ] Create user guide
- [ ] Document features
- [ ] Create FAQ
- [ ] Document API usage

## 🚀 Deployment

### Pre-Deployment
- [ ] Test thoroughly
- [ ] Backup current installation
- [ ] Backup database
- [ ] Document changes
- [ ] Plan rollback strategy

### Deployment
- [ ] Deploy to staging first
- [ ] Test on staging
- [ ] Get approval
- [ ] Deploy to production
- [ ] Monitor for issues

### Post-Deployment
- [ ] Verify deployment
- [ ] Test critical functions
- [ ] Monitor logs
- [ ] Monitor performance
- [ ] Gather user feedback

## 🔄 Maintenance

### Regular Tasks
- [ ] Monitor logs weekly
- [ ] Check for CKAN updates
- [ ] Check for security updates
- [ ] Backup regularly
- [ ] Test backups

### Monthly Tasks
- [ ] Review analytics
- [ ] Update content
- [ ] Check broken links
- [ ] Review user feedback
- [ ] Plan improvements

### Quarterly Tasks
- [ ] Security audit
- [ ] Performance review
- [ ] User survey
- [ ] Feature planning
- [ ] Documentation update

## 📞 Support Resources

### Documentation
- [ ] Read README.md
- [ ] Read INSTALL.md
- [ ] Read CONFIGURATION.md
- [ ] Read FEATURES.md
- [ ] Read QUICKSTART.md

### External Resources
- [ ] CKAN Documentation
- [ ] CKAN Community Forum
- [ ] Bootstrap Documentation
- [ ] Font Awesome Icons
- [ ] CSS Resources

### Troubleshooting
- [ ] Check logs first
- [ ] Search CKAN forum
- [ ] Check GitHub issues
- [ ] Ask community
- [ ] Document solution

## ✅ Final Checklist

- [ ] Theme installed successfully
- [ ] All customizations complete
- [ ] Testing passed
- [ ] Documentation updated
- [ ] Team trained
- [ ] Users notified
- [ ] Monitoring in place
- [ ] Backup strategy confirmed
- [ ] Support plan ready
- [ ] Launch! 🚀

---

**Congratulations!** You've successfully installed and customized the Data.gov.sg theme!

**Next Steps:**
1. Monitor user feedback
2. Plan future enhancements
3. Keep CKAN updated
4. Share your success!

**Need Help?** Check the documentation files or CKAN community resources.

---

**Version**: 1.0.0  
**Last Updated**: 2025-11-18

