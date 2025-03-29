const express = require("express");
const axios = require("axios");
const admin = require("firebase-admin");
const nodemailer = require("nodemailer");
const cron = require("node-cron");
const cors = require("cors");
require("dotenv").config();

const serviceAccount = JSON.parse(process.env.FIREBASE_CREDENTIALS);
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();
const app = express();
app.use(express.json());
app.use(cors());

const API_KEY = "c5d0341144d549e79af190452252803";
const BASE_URL = "http://api.weatherapi.com/v1";

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
});

app.get("/weather/current", async (req, res) => {
  const { city } = req.query;
  try {
    const response = await axios.get(`${BASE_URL}/current.json?key=${API_KEY}&q=${city}`);
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ error: "Lỗi khi lấy dữ liệu thời tiết" });
  }
});

app.post("/subscribe", async (req, res) => {
  const { email, city } = req.body;
  if (!email || !city) return res.status(400).json({ error: "Email và thành phố là bắt buộc" });

  try {
    await db.collection("subscribers").doc(email).set({ email, city });
    res.json({ message: "Đăng ký thành công" });
  } catch (error) {
    res.status(500).json({ error: "Lỗi khi đăng ký email" });
  }
});

app.post("/unsubscribe", async (req, res) => {
  const { email } = req.body;
  if (!email) return res.status(400).json({ error: "Email là bắt buộc" });

  try {
    await db.collection("subscribers").doc(email).delete();
    res.json({ message: "Hủy đăng ký thành công" });
  } catch (error) {
    res.status(500).json({ error: "Lỗi khi hủy đăng ký" });
  }
});


cron.schedule("0 7 * * *", async () => {
  console.log("Đang gửi email thời tiết...");
  const subscribers = await db.collection("subscribers").get();
  const emails = [];

  subscribers.forEach((doc) => {
    emails.push(doc.data());
  });

  for (const { email, city } of emails) {
    try {
      const response = await axios.get(`${BASE_URL}/forecast.json?key=${API_KEY}&q=${city}&days=1&aqi=no&alerts=no`);
      const forecast = response.data.forecast.forecastday[0].day.condition.text;

      const mailOptions = {
        from: process.env.EMAIL_USER,
        to: email,
        subject: `Dự báo thời tiết hôm nay tại ${city}`,
        text: `Thời tiết hôm nay: ${forecast}`,
      };

      await transporter.sendMail(mailOptions);
      console.log(`Email đã gửi cho ${email}`);
    } catch (error) {
      console.error(`Lỗi khi gửi email cho ${email}:`, error);
    }
  }
}, {
  timezone: "Asia/Ho_Chi_Minh", // Đặt múi giờ Việt Nam
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server chạy trên cổng ${PORT}`));
