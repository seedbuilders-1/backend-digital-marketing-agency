// prisma/seed-data/services.js

const servicesToSeed = [
  // --- 1. Digital Marketing Audit ---
  {
    title: "Digital Marketing Audit",
    isPublic: true,
    heroHeadline: "Discover What’s Holding Your Online Growth Back",
    heroParagraph:
      "Before scaling your marketing, you need to understand what’s working and what isn’t.\nDigital Marketing Agency offers a Free Digital Marketing Audit to evaluate your current online performance.",
    blueprintHeadline: "A 360-Degree View of Your Digital Ecosystem",
    blueprintParagraph:
      "After the audit, we provide clear recommendations for improvement. We dive deep into your website, SEO, social media, paid ads, and more.",
    bannerText:
      "Ready to unlock your true potential? Get your comprehensive audit today!",
    problemPoints: [],
    whatYouGet: [
      "Website performance",
      "SEO health",
      "Social media strategy",
      "Advertising performance",
      "Conversion funnel"
    ],
    processSteps: [],
    expectedResults: [],
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
    heroHeadline: "A Complete Roadmap For Your Online Growth",
    heroParagraph:
      "Many businesses struggle with digital marketing because they lack a clear, structured strategy. Without a plan, marketing efforts become scattered and ineffective.\nAt Digital Marketing Agency, we develop comprehensive digital marketing strategies that align your marketing channels, campaigns, and goals.",
    blueprintHeadline: "Strategy Built on Data, Not Assumptions",
    blueprintParagraph:
      "We combine in-depth market research, competitive analysis, and customer journey mapping to build a clear, actionable plan designed for measurable ROI.",
    bannerText:
      "Let’s Grow Your Business Together\nSuccess in the digital world requires more than just posting online, it requires strategy, creativity, and data-driven marketing.",
    problemPoints: [],
    whatYouGet: [],
    processSteps: [
      { title: "Market & Competitor Analysis", description: "We study your industry, competitors, and audience to identify growth opportunities." },
      { title: "Channel Strategy", description: "We determine the most effective channels for your business, including social media, search engines, and advertising platforms." },
      { title: "Customer Journey Mapping", description: "We design a clear path that moves potential customers from awareness to purchase." },
      { title: "Campaign Planning", description: "We create structured campaigns designed to generate traffic, leads, and sales." }
    ],
    expectedResults: [
      "Clear marketing direction",
      "Higher ROI from campaigns",
      "Better customer targeting",
      "Scalable marketing growth"
    ],
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
    heroHeadline: "Professional Designs That Capture Attention",
    heroParagraph:
      "Visual content is one of the most important elements of digital marketing.\nOur design team at Digital Marketing Agency creates visually compelling graphics that communicate your brand message and attract your target audience.",
    blueprintHeadline: "Comprehensive Design, From Concept to Creation",
    blueprintParagraph:
      "We cover every visual touchpoint, ensuring brand consistency everywhere.",
    bannerText:
      "Elevate your brand with world-class design. Let's create something unforgettable.",
    problemPoints: [],
    whatYouGet: [
      "Social Media Designs",
      "Marketing Banners",
      "Brand Identity Design",
      "Logo Design",
      "Promotional Materials",
      "Advertising Creatives"
    ],
    processSteps: [],
    expectedResults: [
      "Strong visual branding",
      "Professional marketing assets",
      "Consistent brand identity"
    ],
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
    problemPoints: [],
    whatYouGet: [
      "Social Media Designs",
      "Marketing Banners",
      "Brand Identity Design",
      "Logo Design",
      "Promotional Materials",
      "Advertising Creatives"
    ],
    processSteps: [],
    expectedResults: [
      "Strong visual branding",
      "Professional marketing assets",
      "Consistent brand identity"
    ],
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
    heroHeadline: "Create Seamless User Experiences That Convert Visitors Into Customers",
    heroParagraph:
      "Great design is not only about aesthetics — it's about how users interact with your product.\nAt Digital Marketing Agency, our UI/UX experts design intuitive and user-friendly digital experiences that improve engagement and conversions.",
    blueprintHeadline: "From User Research to Pixel-Perfect Interfaces",
    blueprintParagraph:
      "Our process involves deep user research, information architecture, wireframing, prototyping, and rigorous usability testing to create seamless and effective digital products.",
    bannerText:
      "Turn your idea into an experience. Let's design your digital future.",
    problemPoints: [],
    whatYouGet: [
      "User Research",
      "Wireframing",
      "Interactive Prototypes",
      "Interface Design",
      "User Journey Mapping",
      "Usability Testing"
    ],
    processSteps: [],
    expectedResults: [],
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
    heroHeadline: "Grow Your Business With Strategic Social Media Marketing",
    heroParagraph:
      "Social media is one of the most powerful marketing tools today but posting randomly without a strategy rarely delivers results.\nAt Digital Marketing Agency, we help businesses transform their presence on platforms like Instagram, Facebook and TikTok into a consistent source of leads, customers, and brand visibility.",
    blueprintHeadline: "Our Solution",
    blueprintParagraph:
      "Our Social Media Marketing service combines strategy, creativity, and data to help your brand grow online and attract the right audience.",
    bannerText: "Ready to turn your social media into a growth engine?\nStart your journey with Digital Marketing Agency today.",
    problemPoints: [
      "Low engagement",
      "Inconsistent posting",
      "No clear content strategy",
      "Followers that never become customers"
    ],
    whatYouGet: [
      "Social Media Strategy Development",
      "Professional Content Creation",
      "Branded Graphic Designs",
      "Caption Writing & Hashtag Strategy",
      "Content Scheduling & Posting",
      "Audience Engagement",
      "Performance Tracking & Optimization"
    ],
    processSteps: [
      { title: "Strategy Development", description: "We analyze your business, audience, and competitors." },
      { title: "Content Planning", description: "We create a powerful monthly content calendar." },
      { title: "Content Creation", description: "Our team designs engaging visuals and high-converting captions." },
      { title: "Growth Optimization", description: "We monitor analytics and optimize performance for better reach and engagement." }
    ],
    expectedResults: [
      "Increased brand awareness",
      "Higher engagement rates",
      "Stronger online authority",
      "More leads and conversions"
    ],
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
    heroHeadline: "Generate Immediate Traffic And Leads With Paid Advertising",
    heroParagraph:
      "Paid advertising helps businesses reach their ideal customers quickly.\nOur PPC specialists at Digital Marketing Agency create targeted advertising campaigns on platforms like Facebook, Instagram, and Google.",
    blueprintHeadline: "Precision Targeting for Maximum ROI",
    blueprintParagraph:
      "We handle everything to ensure every click counts.",
    bannerText: "Don't wait for customers to find you. Reach them now.",
    problemPoints: [],
    whatYouGet: [
      "Campaign Strategy",
      "Ad Creative Development",
      "Audience Targeting",
      "Budget Optimization",
      "Performance Tracking"
    ],
    processSteps: [],
    expectedResults: [],
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
    heroHeadline: "Rank Higher On Google And Get More Organic Traffic",
    heroParagraph:
      "Most customers begin their journey with a search on Google. If your business is not visible in search results, you’re missing valuable opportunities.",
    blueprintHeadline: "Our SEO Solution",
    blueprintParagraph:
      "At Digital Marketing Agency, we use advanced SEO strategies to improve your search rankings and attract qualified traffic to your website.",
    bannerText: "Be the first answer your customers find. Invest in SEO.",
    problemPoints: [
      "Low search engine visibility",
      "Poor website structure",
      "Weak keyword targeting",
      "Limited organic traffic"
    ],
    whatYouGet: [
      "SEO Audit & Competitor Analysis",
      "Keyword Research",
      "On-Page Optimization",
      "Technical SEO Improvements",
      "Content Optimization",
      "Link Building Strategies",
      "Monthly Performance Reporting"
    ],
    processSteps: [],
    expectedResults: [
      "Higher Google rankings",
      "Increased website traffic",
      "More qualified leads",
      "Long-term digital growth"
    ],
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
    heroHeadline: "Maximize Your Visibility On Search Engines",
    heroParagraph:
      "Search Engine Marketing helps businesses appear at the top of search results when customers are actively looking for their products or services.",
    blueprintHeadline: "Dominate the Entire Search Page",
    blueprintParagraph:
      "Our SEM service integrates keyword strategy, ad campaign management, and landing page optimization to ensure you capture users at every stage of their search journey.",
    bannerText:
      "Own your keywords. Drive conversions with a powerful SEM strategy.",
    problemPoints: [],
    whatYouGet: [
      "Search Advertising Strategy",
      "Keyword Targeting",
      "Ad Campaign Management",
      "Landing Page Optimization",
      "Performance Tracking"
    ],
    processSteps: [],
    expectedResults: [],
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
    heroHeadline: "Turn Data Into Smart Marketing Decisions",
    heroParagraph:
      "Understanding your marketing performance is key to growth.\nAt Digital Marketing Agency, we use advanced analytics tools to monitor campaign performance and extract actionable insights.",
    blueprintHeadline: "From Tracking Setup to Actionable Recommendations",
    blueprintParagraph:
      "We cover everything from Google Analytics setup and conversion tracking to custom dashboard creation, funnel analysis, and regular reporting that tells you what's working and why.",
    bannerText:
      "Make data-driven decisions with confidence. Let's unlock your insights.",
    problemPoints: [],
    whatYouGet: [
      "Marketing Data Analysis",
      "Website Performance Tracking",
      "Customer Behavior Insights",
      "Conversion Tracking",
      "Performance Reporting"
    ],
    processSteps: [],
    expectedResults: [],
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
    heroHeadline: "Build Powerful Digital Experiences That Convert",
    heroParagraph:
      "Your website or mobile app is often the first impression customers have of your brand.\nAt Digital Marketing Agency, we design and develop high-performance websites and mobile applications that combine functionality, speed, and modern design.",
    blueprintHeadline: "End-to-End Development, From Design to Deployment",
    blueprintParagraph:
      "We handle the entire lifecycle ensuring your product is built for success.",
    bannerText: "Have a big idea? Let's build it, together.",
    problemPoints: [],
    whatYouGet: [
      "Custom Website Development",
      "E-Commerce Platforms",
      "Mobile App Development",
      "Responsive Web Design",
      "CMS Integration",
      "Secure and Scalable Architecture"
    ],
    processSteps: [
      { title: "Custom Website Development", description: "We create high-performance websites tailored specifically to your brand and business objectives." },
      { title: "E-Commerce Solutions", description: "We develop online stores with seamless checkout systems, product management tools, and secure payment integration." },
      { title: "Mobile App Development", description: "Our team builds powerful mobile applications designed for both performance and usability." },
      { title: "Responsive Web Design", description: "Every website we create is fully responsive, ensuring it performs perfectly across desktops, tablets, and mobile devices." },
      { title: "CMS Integration", description: "We integrate user-friendly content management systems so you can easily update and manage your website." }
    ],
    expectedResults: [
      "Build credibility",
      "Improve customer experience",
      "Increase conversions",
      "Scale your business online"
    ],
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
    heroHeadline: "Keep Your Website Secure, Updated, And Performing At Its Best",
    heroParagraph:
      "Your website or mobile application is often the first interaction customers have with your brand. A poorly designed platform can push potential clients away, while a well-built one can turn visitors into loyal customers.\nAt Digital Marketing Agency, we design and develop modern websites and mobile applications that combine cutting-edge technology with exceptional user experience.",
    blueprintHeadline: "Proactive Care for Your Most Important Asset",
    blueprintParagraph:
      "We provide comprehensive support, including hosting, security monitoring, regular backups, and technical troubleshooting.",
    bannerText: "Enjoy peace of mind. Put your website on autopilot.",
    problemPoints: [],
    whatYouGet: [
      "Regular Updates",
      "Security Monitoring",
      "Website Backups",
      "Performance Optimization",
      "Bug Fixes & Technical Support"
    ],
    processSteps: [],
    expectedResults: [
      "This ensures your website remains reliable and efficient at all times."
    ],
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
