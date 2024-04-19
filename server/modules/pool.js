const { Pool } = require('pg');
let pool;

// When our app is deployed to the internet 
// we'll use the DATABASE_URL environment variable
// to set the connection info: web address, username/password, db name
// For example, set this in your production environment configuration:
// DATABASE_URL=postgresql://jDoe354:secretPw123@some.db.com/prime_app
if (process.env.DATABASE_URL) {
    pool = new Pool({
        connectionString: process.env.DATABASE_URL,
        ssl: {
            rejectUnauthorized: false  // Important for some cloud providers that use self-signed certificates
        }
    });
} else {
    // When we're running this app on our own computer
    // we'll connect to the PostgreSQL database that is 
    // also running on our computer (localhost)
    pool = new Pool({
        host: 'localhost',
        port: 5432,
        database: 'frolf-app',  // Make sure this matches the name of your local database
    });
}

// Handling potential errors from the pool
pool.on('error', (err, client) => {
    console.error('Unexpected error on idle client', err);
    process.exit(-1);
});

// Gracefully shut down the pool when the app is terminated
process.on('SIGINT', () => {
    pool.end(() => {
        console.log('pool has ended');
        process.exit(0);
    });
});

// Export the pool for use elsewhere in your application
module.exports = pool;
