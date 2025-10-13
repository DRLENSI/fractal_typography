# Digital Homebase - Fractal Typography Website

This directory contains the digital homebase for the Fractal Typography project - a showcase website for the recursive typography experiments.

## Files

- **index.html** - Main website with sections for About, Showcase, Forge (essays), and How It Works
- **style.css** - Responsive styling using the project's color scheme (snow_cherry, edge_of_delusion, never_meant_to_do)
- **script.js** - Interactive features including smooth scrolling, navigation highlighting, and scroll animations

## Features

### Sections

1. **Hero** - Introduction with the iconic "yo dawg" tagline and a sample fractal image
2. **About** - Project overview and key features
3. **Showcase** - Gallery of all fractal levels (1-5 and 999) with PDF download links
4. **The Forge** - Essays and fragments about recursive typography, with Substack integration placeholder
5. **How It Works** - Technical explanation with code samples and GitHub link

### Design

- **Color Scheme**: Based on the fractal images
  - Primary: `#6D0839` (snow_cherry)
  - Secondary: `#252720` (edge_of_delusion)
  - Accent: `#D0E799` (never_meant_to_do)
  
- **Typography**: Cabin font family (matching the LaTeX source)
- **Responsive**: Works on mobile, tablet, and desktop
- **Animations**: Smooth scroll and fade-in effects

## Deployment

The website is designed to be deployed via GitHub Pages. A workflow file (`.github/workflows/pages.yml`) is included for automatic deployment when changes are pushed to the master branch.

### Local Testing

To test locally, run a simple HTTP server:

```bash
python -m http.server 8000
# or
python3 -m http.server 8000
```

Then visit http://localhost:8000

## Substack Integration

The website includes a placeholder for Substack newsletter integration. To connect your Substack:

1. Update the form action in `index.html` (line ~143)
2. Replace `#` with your Substack subscribe URL
3. Update the script.js form handler to redirect to your Substack

## Customization

- **Essays**: Add new essay cards in the Forge section
- **Images**: All images are referenced from the `figures/` directory
- **PDFs**: PDF downloads link to the `pdf/` directory
- **Colors**: Modify CSS variables in `:root` selector in `style.css`

## Future Enhancements

- Blog/essay CMS integration
- Interactive fractal generator
- More detailed mathematical explanations
- User-submitted fractal designs
