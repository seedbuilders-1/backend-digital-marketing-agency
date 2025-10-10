// prisma/seed-data/services.js

const servicesToSeed = [
  // --- 1. Digital Marketing Audit ---
  {
    title: "Digital Marketing Audit",
    isPublic: true,
    heroHeadline: "Uncover Your Hidden Growth Opportunities",
    heroParagraph:
      "Our comprehensive audit analyzes every channel of your digital presence to create a data-driven roadmap for success. Stop guessing, start growing.",
    blueprintHeadline: "A 360-Degree View of Your Digital Ecosystem",
    blueprintParagraph:
      "We dive deep into your website, SEO, social media, paid ads, and more, benchmarking you against competitors to find actionable insights that drive real results.",
    bannerText:
      "Ready to unlock your true potential? Get your comprehensive audit today!",
    plans: [
      {
        name: "Complete Digital Audit",
        price: "150000",
        priceUnit: "one-off",
        audience: "For businesses ready to scale",
        position: 0,
        features: [
          "Website & UX Review",
          "SEO Performance Analysis",
          "Social Media Presence Audit",
          "Email Marketing Health Check",
          "Paid Advertising (PPC) Analysis",
          "Content Effectiveness Review",
          "Analytics & Tracking Accuracy",
          "Competitor Benchmarking",
          "Branding & Messaging Consistency",
        ],
      },
    ],
    faqs: [],
    caseStudies: [],
    testimonials: [],
  },

  // --- 2. Digital Marketing Strategy ---
  {
    title: "Digital Marketing Strategy",
    isPublic: true,
    heroHeadline: "Your Roadmap to Sustainable Growth",
    heroParagraph:
      "Move beyond scattered tactics with a bespoke digital marketing strategy that aligns your brand, budget, and business goals for maximum impact.",
    blueprintHeadline: "Strategy Built on Data, Not Assumptions",
    blueprintParagraph:
      "We combine in-depth market research, competitive analysis, and customer journey mapping to build a clear, actionable 3-12 month plan designed for measurable ROI.",
    bannerText:
      "Stop reacting and start leading. Let's build your winning strategy.",
    plans: [
      {
        name: "Custom Growth Strategy",
        price: "200000",
        priceUnit: "one-off",
        audience: "For founders & marketing leaders",
        position: 0,
        features: [
          "Market & Audience Research",
          "In-depth Competitive Analysis",
          "Brand Positioning & Messaging",
          "Multi-Channel Strategy (SEO, Social, PPC)",
          "Content & Campaign Planning",
          "Customer Journey Mapping",
          "Budget & ROI Planning",
          "KPI & Measurement Framework",
          "Execution Roadmap",
        ],
      },
    ],
    faqs: [],
    caseStudies: [],
    testimonials: [],
  },

  // --- 3. Graphics Design (Full Suite & Sub-Packages) ---
  {
    title: "Full Graphics Design Suite",
    isPublic: true,
    heroHeadline: "Visuals That Captivate, Communicate, and Convert",
    heroParagraph:
      "From a memorable brand identity to stunning marketing materials, our full design suite provides everything you need to make a powerful visual impact.",
    blueprintHeadline: "Comprehensive Design, From Concept to Creation",
    blueprintParagraph:
      "We cover every visual touchpoint, including brand identity, marketing collateral, digital assets, product packaging, and professional presentations, ensuring brand consistency everywhere.",
    bannerText:
      "Elevate your brand with world-class design. Let's create something unforgettable.",
    plans: [
      {
        name: "Full Design Suite",
        price: "500000",
        priceUnit: "one-off",
        audience: "For new brands or full rebrands",
        position: 0,
        features: [
          "Brand Identity Design",
          "Marketing Collateral",
          "Digital Assets",
          "Product & Packaging Design",
          "Presentations & Reports",
        ],
      },
      {
        name: "Brand & Marketing Essentials",
        price: "400000",
        priceUnit: "one-off",
        audience: "For established businesses needing assets",
        position: 1,
        features: [
          "Brand Identity Design",
          "Marketing Collateral",
          "Digital Assets",
          "Product & Packaging Design",
        ],
      },
      {
        name: "Brand Identity Starter",
        price: "150000",
        priceUnit: "one-off",
        audience: "For startups needing a logo & guide",
        position: 2,
        features: ["Logos, Color Palettes", "Visual Guidelines"],
      },
      {
        name: "Single Design (Flyer/Graphic)",
        price: "10000",
        priceUnit: "per design",
        audience: "For quick, single-item needs",
        position: 3,
        features: ["One Social Media Graphic/Flier"],
      },
    ],
    faqs: [],
    caseStudies: [],
    testimonials: [],
  },
  {
    title: "Graphics Design (Retainer)",
    isPublic: true,
    heroHeadline: "Your On-Demand Creative Partner",
    heroParagraph:
      "Get consistent, high-quality design assets every month without the overhead of a full-time hire. Perfect for ongoing marketing and social media needs.",
    blueprintHeadline: "Consistent Branding, Delivered Monthly",
    blueprintParagraph:
      "Our retainer plans ensure your brand stays fresh and active with a steady stream of marketing collateral and digital assets, from social media graphics to flyers and banners.",
    bannerText:
      "Never worry about design again. Secure your dedicated creative resource.",
    plans: [
      {
        name: "Marketing & Digital Assets",
        price: "150000",
        priceUnit: "/month",
        audience: "Full creative support",
        position: 0,
        features: ["Flyers, Brochures, Banners", "Social Media Graphics & Ads"],
      },
      {
        name: "Digital Assets Only",
        price: "120000",
        priceUnit: "/month",
        audience: "Social media focus",
        position: 1,
        features: ["Social Media Graphics & Ads"],
      },
    ],
    faqs: [],
    caseStudies: [],
    testimonials: [],
  },

  // --- 4. UI/UX Design ---
  {
    title: "UI/UX Design",
    isPublic: true,
    heroHeadline: "Intuitive Digital Experiences Users Love",
    heroParagraph:
      "We design beautiful, user-centric websites and applications that are not only visually stunning but also easy to use, driving engagement and conversions.",
    blueprintHeadline: "From User Research to Pixel-Perfect Interfaces",
    blueprintParagraph:
      "Our process involves deep user research, information architecture, wireframing, prototyping, and rigorous usability testing to create seamless and effective digital products.",
    bannerText:
      "Turn your idea into an experience. Let's design your digital future.",
    plans: [
      {
        name: "Full UI/UX Product Design",
        price: "600000",
        priceUnit: "one-off",
        audience: "For new web or mobile apps",
        position: 0,
        features: [
          "User Research & Personas",
          "Information Architecture",
          "Wireframing & Prototyping",
          "Visual Design & UI Systems",
          "Usability Testing",
        ],
      },
      {
        name: "UI/UX Retainer (Monthly)",
        price: "150000",
        priceUnit: "/month",
        audience: "For MVP design & short-term needs",
        position: 1,
        features: [
          "Basic User Research",
          "Wireframes & Low-fi Prototypes",
          "UI Design for 1-2 Key Screens",
          "1 Round of Revisions",
        ],
      },
      {
        name: "UI/UX Retainer (Quarterly)",
        price: "400000",
        priceUnit: "/quarter",
        audience: "For growth-stage businesses",
        position: 2,
        features: [
          "In-depth User Research",
          "High-fidelity Prototyping",
          "UI Design for Multiple Screens",
          "Design System Creation",
        ],
      },
      {
        name: "UI/UX Retainer (Yearly)",
        price: "1200000",
        priceUnit: "/year",
        audience: "For continuous improvement & scaling",
        position: 3,
        features: [
          "Ongoing User Research",
          "Full Product Overhaul",
          "Design System Management",
          "Unlimited Revisions",
        ],
      },
    ],
    faqs: [],
    caseStudies: [],
    testimonials: [],
  },

  // --- 5. Social Media Marketing ---
  {
    title: "Social Media Marketing",
    isPublic: true,
    heroHeadline: "Build Your Tribe, Grow Your Brand",
    heroParagraph:
      "We manage your social media presence from strategy to execution, creating engaging content and fostering a loyal community around your brand.",
    blueprintHeadline: "Content, Community, and Conversions",
    blueprintParagraph:
      "Our service covers everything: content strategy, creation (graphics, reels, videos), community management, and in-depth analytics to ensure your social media efforts drive business results.",
    bannerText: "Ready to dominate social media? Let's get started.",
    plans: [
      {
        name: "Monthly",
        price: "150000",
        priceUnit: "/month",
        audience: "Consistent Growth",
        position: 0,
        features: ["Full-service management"],
      },
      {
        name: "Quarterly",
        price: "400000",
        priceUnit: "/quarter",
        audience: "Strategic Campaigns",
        position: 1,
        features: ["Includes campaign planning"],
      },
      {
        name: "Yearly",
        price: "1000000",
        priceUnit: "/year",
        audience: "Long-term partnership",
        position: 2,
        features: ["Includes yearly strategy review"],
      },
    ],
    faqs: [],
    caseStudies: [],
    testimonials: [],
  },

  // --- 6. Sponsored Ads / Pay-Per-Click (PPC) ---
  {
    title: "Sponsored Ads / Pay-Per-Click (PPC)",
    isPublic: true,
    heroHeadline: "Generate Leads and Sales, Instantly",
    heroParagraph:
      "Reach your ideal customers at the exact moment they're ready to buy with targeted, high-ROI ad campaigns on Google, Facebook, LinkedIn, and more.",
    blueprintHeadline: "Precision Targeting for Maximum ROI",
    blueprintParagraph:
      "We handle everything from keyword research and audience segmentation to ad creative, A/B testing, and landing page optimization to ensure every click counts.",
    bannerText: "Don't wait for customers to find you. Reach them now.",
    plans: [
      {
        name: "Weekly Campaign",
        price: "30000",
        priceUnit: "/week",
        audience: "Short-term promotions",
        position: 0,
        features: ["Excludes ad budget"],
      },
      {
        name: "Monthly Management",
        price: "200000",
        priceUnit: "/month",
        audience: "Ongoing lead generation",
        position: 1,
        features: ["Excludes ad budget"],
      },
      {
        name: "Quarterly Strategy",
        price: "500000",
        priceUnit: "/quarter",
        audience: "Sustained growth",
        position: 2,
        features: ["Excludes ad budget"],
      },
      {
        name: "Yearly Partnership",
        price: "1200000",
        priceUnit: "/year",
        audience: "Long-term scaling",
        position: 3,
        features: ["Excludes ad budget"],
      },
    ],
    faqs: [],
    caseStudies: [],
    testimonials: [],
  },

  // --- 7. Search Engine Optimization (SEO) ---
  {
    title: "Search Engine Optimization (SEO)",
    isPublic: true,
    heroHeadline: "Climb to the Top of Google and Stay There",
    heroParagraph:
      "Our comprehensive SEO service improves your search engine rankings, drives organic traffic, and establishes your brand as an authority in your industry.",
    blueprintHeadline: "A Holistic Approach to SEO Success",
    blueprintParagraph:
      "We combine technical SEO, on-page optimization, quality content creation, and strategic link building to create a sustainable foundation for long-term organic growth.",
    bannerText: "Be the first answer your customers find. Invest in SEO.",
    plans: [
      {
        name: "Monthly",
        price: "150000",
        priceUnit: "/month",
        audience: "Steady Improvement",
        position: 0,
        features: ["On-page, technical, content"],
      },
      {
        name: "Quarterly",
        price: "400000",
        priceUnit: "/quarter",
        audience: "Accelerated Growth",
        position: 1,
        features: ["Includes link building push"],
      },
      {
        name: "Yearly",
        price: "1000000",
        priceUnit: "/year",
        audience: "Market Domination",
        position: 2,
        features: ["Full-scope strategy"],
      },
    ],
    faqs: [],
    caseStudies: [],
    testimonials: [],
  },

  // --- 8. Search Engine Marketing (SEM) ---
  {
    title: "Search Engine Marketing (SEM)",
    isPublic: true,
    heroHeadline: "Capture High-Intent Customers with Paid Search",
    heroParagraph:
      "Combine the power of SEO and PPC with a unified Search Engine Marketing strategy that guarantees visibility and drives qualified leads from search engines.",
    blueprintHeadline: "Dominate the Entire Search Page",
    blueprintParagraph:
      "Our SEM service integrates keyword strategy, ad campaign management, and landing page optimization to ensure you capture users at every stage of their search journey.",
    bannerText:
      "Own your keywords. Drive conversions with a powerful SEM strategy.",
    plans: [
      {
        name: "Monthly",
        price: "150000",
        priceUnit: "/month",
        audience: "Consistent Performance",
        position: 0,
        features: ["Excludes ad budget"],
      },
      {
        name: "Quarterly",
        price: "400000",
        priceUnit: "/quarter",
        audience: "Aggressive Campaigns",
        position: 1,
        features: ["Excludes ad budget"],
      },
      {
        name: "Yearly",
        price: "1000000",
        priceUnit: "/year",
        audience: "Sustained Market Lead",
        position: 2,
        features: ["Excludes ad budget"],
      },
    ],
    faqs: [],
    caseStudies: [],
    testimonials: [],
  },

  // --- 9. Analytics ---
  {
    title: "Analytics & Data Insights",
    isPublic: true,
    heroHeadline: "Turn Your Data Into Your Biggest Advantage",
    heroParagraph:
      "Stop drowning in data and start making smarter decisions. We set up, manage, and interpret your analytics to provide clear, actionable insights for growth.",
    blueprintHeadline: "From Tracking Setup to Actionable Recommendations",
    blueprintParagraph:
      "We cover everything from Google Analytics setup and conversion tracking to custom dashboard creation, funnel analysis, and regular reporting that tells you what's working and why.",
    bannerText:
      "Make data-driven decisions with confidence. Let's unlock your insights.",
    plans: [
      {
        name: "Monthly",
        price: "150000",
        priceUnit: "/month",
        audience: "Ongoing Insights",
        position: 0,
        features: ["Regular reporting & guidance"],
      },
      {
        name: "Quarterly",
        price: "400000",
        priceUnit: "/quarter",
        audience: "Deep-Dive Analysis",
        position: 1,
        features: ["Includes funnel optimization"],
      },
      {
        name: "Yearly",
        price: "1000000",
        priceUnit: "/year",
        audience: "Data Partnership",
        position: 2,
        features: ["Full-scope data strategy"],
      },
    ],
    faqs: [],
    caseStudies: [],
    testimonials: [],
  },

  // --- 10. Web & Mobile Development ---
  {
    title: "Web & Mobile App Development",
    isPublic: true,
    heroHeadline: "Build Scalable, High-Performance Digital Products",
    heroParagraph:
      "From custom websites to cross-platform mobile apps, our development team brings your vision to life with secure, scalable, and user-friendly solutions.",
    blueprintHeadline: "End-to-End Development, From Design to Deployment",
    blueprintParagraph:
      "We handle the entire lifecycle: UI/UX design, backend architecture, API integrations, e-commerce setup, and post-launch maintenance, ensuring your product is built for success.",
    bannerText: "Have a big idea? Let's build it, together.",
    plans: [
      {
        name: "Full Web & Mobile App",
        price: "8000000",
        priceUnit: "one-off",
        audience: "For enterprise-level projects",
        position: 0,
        features: [
          "Custom design & development",
          "iOS & Android Apps",
          "Backend & APIs",
          "E-commerce Integration",
        ],
      },
      {
        name: "Web Application Only",
        price: "3000000",
        priceUnit: "one-off",
        audience: "For custom software & platforms",
        position: 1,
        features: [
          "Custom web app development",
          "Backend & Database",
          "API Integrations",
          "Cloud Deployment",
        ],
      },
      {
        name: "Mobile Application Only",
        price: "6000000",
        priceUnit: "one-off",
        audience: "For iOS & Android apps",
        position: 2,
        features: [
          "Native or Cross-Platform",
          "UI/UX Design",
          "Backend Connectivity",
          "App Store Deployment",
        ],
      },
      {
        name: "Basic Website Design",
        price: "800000",
        priceUnit: "one-off",
        audience: "For professional business sites",
        position: 3,
        features: [
          "Up to 10 pages",
          "Responsive Design",
          "Contact Forms & Blog",
          "SEO-ready structure",
        ],
      },
    ],
    faqs: [],
    caseStudies: [],
    testimonials: [],
  },

  // --- 11. Website Management ---
  {
    title: "Website Management & Maintenance",
    isPublic: true,
    heroHeadline: "Keep Your Website Secure, Fast, and Fresh",
    heroParagraph:
      "Focus on your business while we handle the technical side. Our website management service ensures your site is always updated, secure, and performing at its best.",
    blueprintHeadline: "Proactive Care for Your Most Important Asset",
    blueprintParagraph:
      "We provide comprehensive support, including hosting, security monitoring, regular backups, performance optimization, content updates, and technical troubleshooting.",
    bannerText: "Enjoy peace of mind. Put your website on autopilot.",
    plans: [
      {
        name: "Quarterly",
        price: "400000",
        priceUnit: "/quarter",
        audience: "Essential Maintenance",
        position: 0,
        features: ["Security, backups, updates"],
      },
      {
        name: "Yearly",
        price: "1000000",
        priceUnit: "/year",
        audience: "Full-Service Partnership",
        position: 1,
        features: ["Includes content updates & SEO monitoring"],
      },
    ],
    faqs: [],
    caseStudies: [],
    testimonials: [],
  },
];

module.exports = {
  servicesToSeed,
};
