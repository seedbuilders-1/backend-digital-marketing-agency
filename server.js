require("dotenv").config();
const express = require("express");
const cors = require("cors");
const app = express();
const PORT = process.env.PORT || 3000;
const cookieParser = require("cookie-parser");
const auth = require("./middlewares/authmiddleware");
const { authorizeRoles } = require("./middlewares/authenticate");
const swaggerJsDoc = require("swagger-jsdoc");
const swaggerUi = require("swagger-ui-express");
const http = require("http");
const { Server } = require("socket.io");
const initializeSocket = require("./socket");
const morgan = require("morgan");

const options = {
  definition: {
    openapi: "3.0.0",
    info: {
      title: "DMA-API",
      version: "1.0.0",
      description: "An API for digital marketing agency, Nigeria",
    },
    servers: [
      {
        url: `http://localhost:${PORT}`,
      },
      {
        url: "https://api.digitalmarketingagency.ng",
        description: "Production server",
      },
    ],
  },
  apis: ["swagger.yaml"],
};
const specs = swaggerJsDoc(options);
app.use(
  "/api-docs",
  swaggerUi.serve,
  swaggerUi.setup(specs, {
    swaggerOptions: {
      persistAuthorization: true,
    },
  })
);

// Import different route files
const authRoutes = require("./routes/authRoutes");
const userRoutes = require("./routes/userRoutes");
const orgRoutes = require("./routes/orgRoutes");
const testimonialRoutes = require("./routes/testimonialRoutes");
const serviceRoutes = require("./routes/serviceRoutes");
const serviceRequestRoutes = require("./routes/serviceRequestRoutes");
const adminRoutes = require("./routes/adminRoutes");
const invoiceRoutes = require("./routes/invoiceRoutes");
const milestoneRoutes = require("./routes/milestoneRoutes");
const paymentRoutes = require("./routes/paymentRoutes");
const conversationRoutes = require("./routes/conversationRoutes");
const referralRoutes = require("./routes/referralRoutes");
const logger = require("./utils/logger");

const jsonParser = express.json();
app.use(cookieParser());
app.use(
  cors({
    origin: [
      "http://localhost:3000",
      "http://localhost:3001",
      "https://digitalmarketingagency.ng",
      "https://www.digitalmarketingagency.ng",
    ],
    methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS", "PATCH"],
    allowedHeaders: ["Content-Type", "Authorization", "X-Custom-Header"],
    optionsSuccessStatus: 204,
  })
);

// Custom stream for Winston
const stream = {
  write: (message) => logger.http(message.trim()),
};

app.use(morgan("combined", { stream }));

// Mount routes to different paths
app.use("/api/auth", jsonParser, authRoutes);
app.use("/api/users", jsonParser, userRoutes);
app.use("/api/orgs", jsonParser, orgRoutes);
app.use("/api/testimonials", jsonParser, testimonialRoutes);
app.use("/api/service-requests", jsonParser, serviceRequestRoutes);
app.use("/api/admin", jsonParser, auth, authorizeRoles("admin"), adminRoutes);

app.use("/api/services", jsonParser, serviceRoutes);
app.use("/api/invoices", jsonParser, invoiceRoutes);
app.use("/api/milestones", jsonParser, milestoneRoutes);
app.use("/api/payments", jsonParser, paymentRoutes);
app.use("/api/conversations", jsonParser, conversationRoutes);
app.use("/api/referrals", jsonParser, referralRoutes);

const server = http.createServer(app); // Create an HTTP server from the Express app

const io = new Server(server, {
  cors: {
    // CHANGE THIS:
    origin: [
      "http://localhost:3000",
      "http://localhost:3001",
      "https://digitalmarketingagency.ng",
      "https://www.digitalmarketingagency.ng",
    ],
    // TO THIS ^^^. Make it an array that matches your Express CORS settings.
    methods: ["GET", "POST"],
  },
});
initializeSocket(io);

server.listen(PORT, () => console.log(`Server running on port ${PORT}`));
