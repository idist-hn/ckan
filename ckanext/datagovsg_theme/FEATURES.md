# 🎨 Data.gov.sg Theme - Features & Design Guide

## 🌟 Visual Features

### Color Palette

```
Primary Purple:   #6253e8  ████████
Primary Dark:     #4f42ba  ████████
Primary Light:    #7d6ff0  ████████
Text Color:       #1a1a1a  ████████
Text Secondary:   #666666  ████████
Background:       #f8f9fa  ████████
Border:           #e0e0e0  ████████
Success:          #10b981  ████████
Warning:          #f59e0b  ████████
Error:            #ef4444  ████████
```

### Typography

- **Headings**: Bold, modern sans-serif
- **Body**: Clean, readable font
- **Sizes**: Responsive (32px-48px for h1)

## 📱 Components

### 1. Header (Account Masthead)

**Design:**
- Gradient background: `linear-gradient(135deg, #6253e8 0%, #4f42ba 100%)`
- White text with 95% opacity
- Hover: White background with 10% opacity
- Box shadow: `0 2px 8px rgba(98, 83, 232, 0.15)`

**Features:**
- User account menu
- Dashboard link with notification badge
- Settings link
- Logout link
- Login/Register for guests

### 2. Main Header (Masthead)

**Design:**
- White background
- Border bottom: 1px solid #e0e0e0
- Box shadow: `0 1px 3px rgba(0, 0, 0, 0.05)`

**Navigation:**
- Pills style navigation
- Hover: Purple background (10% opacity)
- Active: Purple background
- Border radius: 6px

### 3. Homepage Hero Section

**Design:**
- Gradient background: Purple to dark purple
- White text
- Padding: 60px 0
- Border radius: 12px
- Margin bottom: 40px

**Content:**
- Large heading (48px)
- Subtitle (20px)
- Large search bar
- Call-to-action button

### 4. Search Form

**Design:**
- Border radius: 8px
- Box shadow: `0 2px 8px rgba(0, 0, 0, 0.08)`
- Input: 2px border, 12px padding
- Focus: Purple border with shadow
- Button: Purple background, white text

**Features:**
- Large input field
- Icon button
- Smooth transitions
- Focus states

### 5. Dataset Cards

**Design:**
- Border radius: 12px
- Border: 1px solid #e0e0e0
- Padding: 20px
- Box shadow: `0 2px 8px rgba(0, 0, 0, 0.05)`
- Hover: Lift effect with shadow

**Hover Effect:**
- Transform: `translateY(-2px)`
- Border color: Purple
- Box shadow: `0 4px 16px rgba(98, 83, 232, 0.15)`

### 6. Buttons

**Primary Button:**
- Background: #6253e8
- Color: White
- Border radius: 8px
- Padding: 10px 20px
- Font weight: 600

**Hover:**
- Background: #4f42ba
- Transform: `translateY(-2px)`
- Box shadow: `0 4px 12px rgba(98, 83, 232, 0.3)`

### 7. Tags

**Design:**
- Background: Purple 10% opacity
- Color: Purple
- Border radius: 6px
- Padding: 4px 12px
- Font size: 13px
- Border: 1px solid purple 20% opacity

**Hover:**
- Background: Purple
- Color: White
- Transform: `translateY(-1px)`

### 8. Module Cards

**Design:**
- Border radius: 12px
- Border: 1px solid #e0e0e0
- Box shadow: `0 2px 8px rgba(0, 0, 0, 0.05)`

**Header:**
- Gradient background: Purple to dark purple
- White text
- Border radius: 12px 12px 0 0
- Padding: 16px 20px
- Font weight: 600

**Content:**
- Padding: 20px
- White background

**Hover:**
- Box shadow: `0 4px 16px rgba(0, 0, 0, 0.1)`
- Transform: `translateY(-2px)`

### 9. Footer

**Design:**
- Background: #1a1a1a
- Color: White 80% opacity
- Padding: 40px 0 20px
- Margin top: 60px

**Layout:**
- 4 columns (About, Resources, Help, Connect)
- Social media icons
- Copyright info
- Powered by CKAN

**Links:**
- Color: White 80% opacity
- Hover: Purple light (#7d6ff0)

## 🎯 Animations & Transitions

### Standard Transition
```css
transition: all 0.3s ease;
```

### Hover Effects

**Cards:**
- Lift: `translateY(-2px)`
- Shadow increase
- Border color change

**Buttons:**
- Lift: `translateY(-2px)`
- Background darken
- Shadow increase

**Tags:**
- Lift: `translateY(-1px)`
- Background to solid
- Color invert

**Links:**
- Color change
- No underline on hover

## 📐 Spacing & Layout

### Border Radius
- Small: 6px (tags, labels)
- Medium: 8px (buttons, inputs)
- Large: 12px (cards, modules)

### Shadows

**Light:**
```css
box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
```

**Medium:**
```css
box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
```

**Hover:**
```css
box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
```

**Purple Shadow:**
```css
box-shadow: 0 4px 12px rgba(98, 83, 232, 0.3);
```

### Padding
- Small: 4px 10px
- Medium: 10px 20px
- Large: 16px 20px
- Extra Large: 20px

### Margins
- Section spacing: 40px - 60px
- Card spacing: 16px
- Element spacing: 8px - 20px

## 🎨 Design Principles

### 1. Consistency
- Same border radius throughout
- Consistent spacing
- Unified color palette
- Standard transitions

### 2. Hierarchy
- Clear visual hierarchy
- Size indicates importance
- Color draws attention
- Spacing creates groups

### 3. Accessibility
- High contrast text
- Clear focus states
- Readable font sizes
- Semantic HTML

### 4. Responsiveness
- Mobile-first approach
- Flexible layouts
- Responsive typography
- Touch-friendly targets

### 5. Performance
- Optimized CSS
- Minimal animations
- Efficient selectors
- Cached assets

## 🔧 Customization Points

### Easy to Change

1. **Colors** - CSS variables in `:root`
2. **Border Radius** - Search and replace values
3. **Shadows** - Adjust rgba values
4. **Spacing** - Modify padding/margin
5. **Typography** - Change font families

### Moderate Difficulty

1. **Layout** - Modify grid/flex
2. **Components** - Adjust structure
3. **Animations** - Change transitions
4. **Responsive** - Update breakpoints

### Advanced

1. **Templates** - Jinja2 structure
2. **JavaScript** - Add interactions
3. **Webassets** - Build process
4. **Integration** - CKAN hooks

## 📊 Component Checklist

- [x] Header with gradient
- [x] Navigation menu
- [x] User account menu
- [x] Hero section
- [x] Search bar (large)
- [x] Dataset cards
- [x] Module cards
- [x] Buttons (primary, secondary)
- [x] Tags
- [x] Footer (4 columns)
- [x] Responsive design
- [x] Hover effects
- [x] Focus states
- [x] Loading states
- [x] Error states

## 🎯 Best Practices

### CSS
- Use CSS variables
- Mobile-first media queries
- Semantic class names
- Avoid !important
- Comment complex sections

### Templates
- Use {% ckan_extends %}
- Keep templates DRY
- Use snippets for reusable parts
- Comment template logic
- Follow CKAN conventions

### Performance
- Minimize CSS
- Optimize images
- Use webassets
- Enable caching
- Lazy load images

### Accessibility
- Semantic HTML
- ARIA labels
- Keyboard navigation
- Color contrast
- Focus indicators

## 🌈 Color Usage Guide

### Primary Purple (#6253e8)
- Primary buttons
- Active states
- Links
- Accents
- Gradients

### Dark Purple (#4f42ba)
- Hover states
- Gradient ends
- Emphasis

### Light Purple (#7d6ff0)
- Backgrounds (10% opacity)
- Hover links
- Subtle accents

### Text Colors
- Primary: #1a1a1a (headings, important text)
- Secondary: #666666 (descriptions, metadata)

### Backgrounds
- Light: #f8f9fa (sections)
- White: #ffffff (cards, content)
- Dark: #1a1a1a (footer)

## 📱 Responsive Breakpoints

```css
/* Mobile */
@media (max-width: 768px) {
  /* Smaller fonts, stacked layout */
}

/* Tablet */
@media (min-width: 769px) and (max-width: 1024px) {
  /* Medium layout */
}

/* Desktop */
@media (min-width: 1025px) {
  /* Full layout */
}
```

---

**Design inspired by**: [data.gov.sg](https://data.gov.sg)  
**Framework**: Bootstrap 5  
**Icons**: Font Awesome  
**Version**: 1.0.0

