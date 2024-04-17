const functions = require('firebase-functions');
const express = require('express');
const cors = require('cors');
const admin = require("firebase-admin");
var firebaseServiceAccount = require("./admin-key.json");

admin.initializeApp({ credential: admin.credential.cert(firebaseServiceAccount) });

const app = express();

// Enable CORS for all routes
app.use(cors());

// Define routes
app.post('/', (req, res) => {
    res.send({ 'data': 'd' });
});

app.post('/api/data', async (req, res) => {
    console.log(req.headers.authorization);
    const authToken = req.headers.authorization.split(' ')[1];
    const wrongToken = authToken.replace('y', 'k')
    const decodedToken = await admin.auth().verifyIdToken(wrongToken);
    console.log(decodedToken)
    const data = {
        data: 'This is some data from the server.',
        timestamp: Date.now(),
    };
    res.json(data);
});

// Define a 404 route handler
app.use((req, res, next) => {
    res.status(404).send("Sorry, can't find that!");
});

// Error handler
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Something broke!');
});

// Expose Express app as a Cloud Function
exports.apiv1 = functions.region('asia-south1').https.onRequest(app);
