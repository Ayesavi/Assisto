const functions = require("firebase-functions");
const logger = require("firebase-functions/logger");
const { createStructuredOutputRunnable } = require("langchain/chains/openai_functions");
const { ChatOpenAI } = require("@langchain/openai");
const { ChatPromptTemplate } = require("@langchain/core/prompts");
const { JsonOutputFunctionsParser } = require("langchain/output_parsers");
const { onRequest, onCall } = require("firebase-functions/v1/https");
const admin = require("firebase-admin");
const jwt = require('jsonwebtoken');
const { createClient } = require('@supabase/supabase-js');
let template = `
User Bio : {question}
Categories:
    driving: Ride, Safar, Commute, Carpool, Drive, Drop-off, Pick-up, सवारी
    cooking: Meal prep, Nashta, Recipe, Food, Cook, Chef, Dinner, Lunch, पकवान
    beauty: Makeup, Sundarta, Hair, Nails, Skincare, Salon, Style, Grooming, सौंदर्य
    babysitting: Childcare, Parvarish, Babysit, Toddler, Infant, Playtime, Bedtime, Kids, बच्चा
    eldercare: Senior, Swasthya, Elderly, Companion, Caregiver, Assistance, Support, Aging, बुजुर्ग
    homework: Schoolwork, Padhai, Study, Tutor, Help, Learning, Education, Assignment, गयान
    teaching: Educate, Gyan, Learn, Tutor, Instructor, Lesson, Study, Guide, शिक्षा
    househelp: Clean, Safai, House, Ghar, Chores, Kaam, Tidy, Organize, घर
    paint: Paint, Rang, Color, Wall, Interior, Exterior, Room, Design, पेंट
    cleaning: Clean, Safai, Tidy, Dust, Sweep, Mop, Scrub, Vacuum, पोछना
    plumbing: Plumber, Nal, Pipe, Leak, Fix, Water, Drain, Repair, पाइप
    mehendi: Henna, Mehendi, Design, Tattoo, Bride, Festive, Ceremony, Art, मेहंदी
    tailoring: Silai, Alteration, Sew, Stitch, Fit, Tailor, Clothing, Dress, कपड़े
    electrical Repairing: Electrician, Bijli, Wire, Fix, Outlet, Light, Appliance, Repair, बिजली
    event Management: Event, Karyakram, Party, Wedding, Plan, Organize, Coordinate, Celebration, इवेंट
    groceries: Food, Kirana, Shop, Grocery, List, Purchase, Market, Delivery, ग्राहक
    personal Care: Care, Dekhbhal, Assist, Help, Support, Groom, Bath, Dress, हेल्प
    custom: Vishesh, Specific, Personal, Unique, Special, Individual, Customized, Tailored, विशेष

You are assistant for Assisto application, Assisto is a user-friendly mobile application designed to provide reliable human assistance and support to individuals whenever and wherever they need it. With Assisto, users can easily access any human services.
From the above categories and user bio and tell the user with list of services the user can serve in be creative and tell him what else he can do according to you. 
Answer: `
let jsonSchema = {
    "title": "ResponseModel",
    "description": "Response model for identifying suitable categories for a user.",
    "type": "object",
    "properties": {
        "categories": {
            "title": "categories",
            "description": "The list of suitable categories for the user",
            "type": "array",
            "items": {
                "type": "string"
            }
        }
    },
    "required": ["categories"]
}

async function genCategories(req, res) {
    try {
        const accessToken = req.headers.authorization.split('Bearer ').pop();
        const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_KEY, {
            global: {
                headers: {
                    'apiKey': process.env.SUPABASE_KEY,
                    'Authorization': `Bearer ${req.headers.access_token}`,
                }
            }
        });
        const prompt = ChatPromptTemplate.fromMessages([
            ["human", template],
        ]);
        const { data, error } = await supabase.auth.getUser();
        if (true) {
            const { context } = req.body;
            const model = new ChatOpenAI({ openAIApiKey: process.env.OPENAI_API_KEY });
            const outputParser = new JsonOutputFunctionsParser();
            const runnable = createStructuredOutputRunnable({
                outputSchema: jsonSchema,
                llm: model,
                prompt: prompt,
                outputParser
            });
            let data = await runnable.invoke({ question: context })
            logger.info(data, { structuredData: true })
            return res.send(data.categories);
        } else {
        }
    } catch (error) {
        console.error("Error", error);
        throw new functions.https.HttpsError(
            "internal",
            "Error during user creation",
            error
        );
    }
}

exports.getCategoriesByDescription = functions
    .region('asia-south1')
    .https.onRequest(genCategories);

