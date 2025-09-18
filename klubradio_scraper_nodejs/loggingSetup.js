// Dieses Modul richtet die Logging-Funktionalität ein.
const winston = require("winston");
const { LOG_FILE_PATH } = require("./config");

const logger = winston.createLogger({
  level: "info",
  format: winston.format.combine(
    winston.format.timestamp({ format: "YYYY-MM-DD HH:mm:ss" }),
    winston.format.printf(
      (info) =>
        `${info.timestamp} - ${info.level.toUpperCase()} - ${info.message}`,
    ),
  ),
  transports: [
    new winston.transports.File({ filename: LOG_FILE_PATH }),
    new winston.transports.Console(),
  ],
});

module.exports = logger;
