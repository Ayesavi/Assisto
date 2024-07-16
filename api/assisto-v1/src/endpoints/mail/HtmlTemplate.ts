export default function getBody(body: MailBody) {
  return `
  <!DOCTYPE html>
  <html lang="en">
  
  <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <style>
          body {
              font-family: Arial, sans-serif;
              margin: 0;
              padding: 0;
              background-color: #faf8ff; /* surfaceBright */
              color: #1a1b21; /* onBackground */
          }
  
          .container {
              width: 100%;
              max-width: 600px;
              margin: 0 auto;
              background-color: #ffffff; /* surfaceContainerLowest */
              border: 1px solid #e2e1ec; /* surfaceVariant */
              border-radius: 8px;
              overflow: hidden;
          }
  
          .header {
              background-color: #4b5c92; /* primary */
              padding: 20px;
              text-align: center;
          }
  
          .header img {
              max-width: 150px;
          }
  
          .content {
              padding: 30px;
          }
  
          .content h1 {
              font-size: 24px;
              color: #01174b; /* onPrimaryContainer */
              margin-bottom: 20px;
          }
  
          .content p {
              font-size: 16px;
              line-height: 1.6;
              margin-bottom: 20px;
          }
  
          .button {
              display: inline-block;
              padding: 10px 20px;
              color: #ffffff; /* onPrimary */
              background-color: #4b5c92; /* primary */
              border-radius: 5px;
              text-decoration: none;
          }
  
          .footer {
              background-color: #4b5c92; /* primary */
              color: #ffffff; /* onPrimary */
              padding: 10px 20px;
              text-align: center;
              font-size: 12px; /* Smaller footer text */
          }
  
          .footer a {
              color: #ffffff; /* onPrimary */
              text-decoration: none;
          }
      </style>
  </head>
  
  <body>
      <div class="container">
          <div class="header">
              <img src="https://ovzuzdeyvlhiukwrbmxc.supabase.co/storage/v1/object/public/storage/icon_512.png" alt="Company Logo">
          </div>
          <div class="content">
              <h1>${body.title}</h1>
              <p>Thank you for using Assisto. ${body.body}</p>
              <p><strong>Team Ayesavi</strong></p>
          </div>
          <div class="footer">
              <p>&copy; ${new Date().getFullYear()} Ayesavi Digital Technologies. All rights reserved.</p>
              <p><a href="https://assisto.ayesavi.in">assisto.ayesavi.in</a> | <a href="mailto:assisto@ayesavi.in">assisto@ayesavi.in</a></p>
              <p>Naya Raipur | Chhattisgarh</p>
          </div>
      </div>
  </body>
  
  </html>  
        `;
}

interface MailBody {
  recipientName?: string;
  body: string;
  title: string;
}
