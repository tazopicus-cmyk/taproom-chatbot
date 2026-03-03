# 🍺 Taproom Chatbot

Embeddable chatbot widget for brewery websites. Answers common taproom questions automatically.

## Quick Start

```bash
# Customize your brewery info
nano deploy.sh

# Generate your widget
chmod +x deploy.sh
./deploy.sh

# Upload index.html to your site
```

## Customize

Edit these variables in `deploy.sh`:

```bash
BREWERY_NAME="Tin Dog Brewing"
ADDRESS="4523 Leary Way NW, Seattle WA 98107"
HOURS="Tue-Thu 4-9pm, Fri-Sat 12-10pm, Sun 12-6pm"
PHONE="(206) 555-0123"
WEBSITE="https://tindogbrewing.com"
```

Then open `index.html` in a browser to test, or upload to your server.

## Features

- ✅ Customizable brewery name, address, hours
- ✅ Quick-reply buttons for common questions
- ✅ Mobile-friendly design
- ✅ Matches brewery branding (customizable colors)
- ✅ No dependencies - pure HTML/CSS/JS

## Pricing

- **$49** one-time → Customer gets the widget code
- **$149** → Widget + integration help + custom responses

## Demo

See `demo.html` for a working example.

## Future Enhancements

- Connect to Untappd API for real-time tap list
- Connect to Google Business API for hours
- AI-powered responses with OpenClaw
- Multi-location support

---

Built by [Tin Dog Digital](https://tindogbrewing.com)
