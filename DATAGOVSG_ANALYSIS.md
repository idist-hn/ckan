# 📊 PHÂN TÍCH WEBSITE DATA.GOV.SG

## 🎨 **1. MÀU SẮC CHÍNH**

### Primary Color
- **Main Purple**: `#6253e8` (đã đúng!)
- **Progress Bar**: `#6253e8`
- **Links & Buttons**: Purple gradient

### Secondary Colors
- **Crimson**: `crimson-300`, `crimson-500` (cho charts)
- **Green**: `green-100`, `green-300` (cho environment topics)
- **Violet**: `violet-300` (cho decorative elements)

### Background & Text
- **Background**: White (`#fff`)
- **Text**: Base content colors
- **Gradients**: `from-white via-white/70 to-transparent`

---

## 📐 **2. LAYOUT & STRUCTURE**

### Container
- **Max Width**: `max-w-screen-xl` (1280px)
- **Padding**: `px-4 sm:px-6`
- **Centered**: `mx-auto`

### Grid System
- **Homepage**: Responsive grid
  - Mobile: 1 column
  - Tablet: 2 columns
  - Desktop: 3-4 columns

---

## 🏠 **3. HOMEPAGE COMPONENTS**

### A. Hero Section
```
- Title: "Singapore's open data portal"
- Subtitle: "Explore national datasets and access APIs for development"
- Large search bar
- Topic tags: Arts & Culture, Education, Economy, Environment, Geospatial, Housing, Health, Social, Transport
- "Real-time APIs" badge
```

### B. Statistics Section
```
- "5000+ datasets from 65+ government agencies"
- Agency cards with:
  - Agency logo
  - API Calls count
  - Downloads count
```

**Top Agencies:**
1. NEA - 840.3M API Calls, 132.1K downloads
2. HDB - 8.3M API Calls, 36.6K downloads
3. ACRA - 4.8M API Calls, 110.2K downloads
4. MOH - 121.9K API Calls, 38.9K downloads
5. MOE - 65.0K API Calls, 3.9K downloads
6. BCA - 744 API Calls, 2.0K downloads

### C. Use Cases Section
```
- "Create with confidence"
- "Find the right data to drive your vision"
- Cards:
  1. "Make better decisions with free government data"
  2. "Explore and embed live charts and tables"
  3. "Use data at scale with APIs"
  4. "Subscribe to the datasets you use"
```

### D. Popular Datasets
```
- Tabs: "Past 24 hours" | "All time"
- Dataset cards showing:
  - Title
  - Topic
  - API Calls
  - Downloads
```

**Most Used (Past 24h):**
1. 24-hour Weather Forecast - 1.6M API Calls
2. PM2.5 - 91.5K API Calls
3. COVID-19 infections - 6.9K API Calls
4. Resale Flat Prices - 4.1K API Calls
5. Hawker Centres Closure - 2.9K API Calls
6. CEA Salesperson Info - 1.7K API Calls

### E. Public Creations
```
- "Public creations using our data"
- Cards with:
  - Icon (flame, building, etc.)
  - Source (The Straits Times, Kontinentalist, PropertyGuru, recycle.gov.sg)
  - Title
  - Description
  - Dataset link
```

### F. Final Stats
```
- "Free for commercial or personal use"
- "What will you create today?"
- 2.38B total API calls (4.82M per day)
- 3.43M total views (5.38K per day)
- 1.27M total downloads (1.71K per day)
```

---

## 🎯 **4. DESIGN ELEMENTS**

### Typography
- **Display Font**: Heavy weight for numbers/emphasis
- **Body Font**: Regular weight
- **Responsive**: `prose-responsive-display-light`, `prose-responsive-display-heavy`

### Cards
- **Border Radius**: Rounded corners
- **Shadow**: Subtle shadows
- **Hover**: Smooth transitions
- **Padding**: Consistent spacing

### Decorative Elements
- **Wave SVG**: Dashed stroke pattern
  ```svg
  stroke-dasharray="4 4"
  stroke-width="2"
  ```
- **Gradient overlays**: `bg-gradient-to-t from-white`

### Icons
- **Font Awesome**: Used for icons
- **Custom SVGs**: For logos and decorations

---

## 🔗 **5. NAVIGATION**

### Header
- **Logo**: OGP branding
- **Main Menu**:
  - Datasets
  - Agencies
  - Help
  - Product status
  - Report card
  - Log in
  - Feedback

### Footer
- **Links**:
  - Feedback
  - Open Data Licence
  - Privacy & Terms
- **Copyright**: "©2025 Open Government Products"

---

## 📱 **6. RESPONSIVE DESIGN**

### Breakpoints
- **Mobile**: Default (1 column)
- **Tablet**: `sm:` (2 columns)
- **Desktop**: `lg:` (3-4 columns)

### Mobile Optimizations
- Stacked layout
- Full-width search
- Collapsible menu
- Touch-friendly buttons

---

## 🎨 **7. VISUAL STYLE**

### Spacing
- **Sections**: `mt-16`, `my-8`, `gap-8`
- **Cards**: `gap-4`, `gap-6`
- **Text**: `gap-4`

### Colors by Topic
- **Environment**: Green
- **Housing**: Crimson
- **Health**: Various
- **Economy**: Various

### Animations
- **Progress bar**: NProgress with purple color
- **Hover effects**: Smooth transitions
- **Loading**: Spinner with purple

---

## 🔧 **8. TECHNICAL FEATURES**

### React Components
- Server-side rendering (Next.js)
- Client-side hydration
- Dynamic imports
- Image optimization

### Data Fetching
- Real-time API calls
- Statistics aggregation
- Dataset metadata

### Analytics
- Datadog RUM (Real User Monitoring)
- Datadog Logs
- User tracking

---

## 📋 **9. CONTENT SECTIONS**

### Banner
```
"Sign up here for higher rate limits, priority support and maintenance notifications. 
Rate limits will be enforced on 31 December 2025."
```

### Government Masthead
```
- "A Singapore Government Agency Website"
- "How to identify"
- "Official website links end with .gov.sg"
- "Secure websites use HTTPS"
- "Scam alert"
```

---

## 🎯 **10. KEY FEATURES TO CLONE**

### Must-Have
1. ✅ Purple color scheme (#6253e8)
2. ✅ Hero section with large search
3. ✅ Topic tags (8 categories)
4. ✅ Agency statistics cards
5. ✅ Popular datasets list
6. ✅ Public creations showcase
7. ✅ Final statistics section
8. ✅ Wave decorations
9. ✅ Responsive grid layout
10. ✅ Modern card design

### Nice-to-Have
1. Real-time API statistics
2. Interactive charts
3. Dataset previews
4. User authentication
5. Subscription system
6. Advanced search
7. Data visualization
8. API documentation

---

## 📊 **11. DATASET CARD DESIGN**

```
┌─────────────────────────────────┐
│ [Agency Logo]                   │
│                                 │
│ Agency Name                     │
│                                 │
│ 840.3M API Calls                │
│ 132.1K downloads                │
└─────────────────────────────────┘
```

---

## 🎨 **12. COLOR PALETTE**

```css
/* Primary */
--primary: #6253e8;
--primary-dark: #4f42ba;
--primary-light: #7d6ff0;

/* Topics */
--environment-green: #10b981;
--housing-crimson: #dc2626;
--health-blue: #3b82f6;

/* Neutrals */
--white: #ffffff;
--gray-50: #f9fafb;
--gray-100: #f3f4f6;
--gray-900: #111827;
```

---

## 📝 **13. TYPOGRAPHY SCALE**

```css
/* Display */
.prose-responsive-display-heavy: 
  - Font weight: 700-900
  - Size: 2.5rem - 4rem (responsive)

.prose-responsive-display-light:
  - Font weight: 300-400
  - Size: 2.5rem - 4rem (responsive)

/* Body */
.prose-body-1: 1rem
.prose-body-2: 0.875rem

/* Subhead */
.prose-subhead-5: 0.75rem
```

---

## ✅ **NEXT STEPS**

1. ✅ Phân tích hoàn tất
2. ⏳ Cập nhật CSS theme
3. ⏳ Tùy chỉnh Homepage
4. ⏳ Tùy chỉnh Header & Navigation
5. ⏳ Tùy chỉnh Footer
6. ⏳ Tùy chỉnh Dataset Pages
7. ⏳ Thêm tính năng đặc biệt
8. ⏳ Test và tối ưu hóa

