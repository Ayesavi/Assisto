import * as nodemailer from "nodemailer";
export default async function sendMail(
  subject: string,
  cc: string[],
  body: any
) {
  let toaddrs = cc.join(", ");

  // Create reusable transporter object using the default SMTP transport
  let transporter = nodemailer.createTransport({
    host: "smtp.gmail.com",
    port: 587,
    secure: false, // true for 465, false for other ports
    auth: {
      user: process.env.MAIL_ID, //
      pass: process.env.MAIL_PASS, //
    },
  });

  // setup email data with unicode symbols
  let mailOptions = {
    from: '"Ayesavi Digital Technologies" <updates.ayesavi.in>', // sender address
    to: toaddrs, // list of receivers
    subject: subject, // Subject line
    html: body, // HTML body content
  };

  // send mail with defined transport object
  try {
    let info = await transporter.sendMail(mailOptions);
    console.log("Message sent: %s", info.messageId);
  } catch (error) {
    console.error("Error sending email:", error);
  }
}
