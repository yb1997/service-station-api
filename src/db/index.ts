import pgPromise from "pg-promise";

const pgp = pgPromise();

const db = pgp({ 
    host: process.env.PGHOST,
    database: process.env.PGDATABASE,
    user: process.env.PGUSER,
    password: process.env.PGPASSWORD,
    port: +(process.env.PGPORT as string)
});

export { pgp, db };

