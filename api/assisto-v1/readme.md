## Build and deploy `Docker.nginx`
---
* Build and deploy nginx image
```bash
npm run deploy-nginx
```
* Build and deploy nginx image in production
  
```bash
npm run deploy-nginx:prod
```

## Build and deploy cloud function
---
* Build and deploy cloud function
```bash
npm run deploy
```
* Build and deploy cloud function in production
```bash
npm run deploy:prod
```

## ENV Variables
* SUPABASE_DEV_URL
* SUPABASE_DEV_KEY
* SUPABASE_PROD_URL
* SUPABASE_PROD_KEY
* SUPABASE_DEV_JWT_SECRET
* SUPABASE_PROD_JWT_SECRET
* OPENAI_API_KEY
* CF_APP_ID
* CF_API_KEY
* CF_DEV_API_KEY
* CF_DEV_APP_ID
* MAIL_PASS
* MAIL_ID