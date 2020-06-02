import { json, urlencoded } from 'body-parser';
import { join } from "path";
import express, { NextFunction, Request, Response } from 'express';
import jwt from 'express-jwt';
import { authController } from "./controllers/auth.controller";
import { bookingController } from "./controllers/booking.controller";
import { searchController } from './controllers/search.controller';
import { serviceStationController } from './controllers/service-station.controller';


require('dotenv').config();

const app = express();
const port = (process.env.PORT && +process.env.PORT) || 3000;

app.use(express.static( join(__dirname, "../", "public"), ));
app.use(json());
app.use(urlencoded({ extended: true }));
app.use(
    jwt({
        secret: process.env.SECRET as string,
        credentialsRequired: false
    })
);

app.use("/search", searchController);

app.use("/service-station", serviceStationController);

app.use("/auth", authController);

app.use('/booking', bookingController);

app.get("/", (req, res) => {
    res.send("root path accessed");
});

app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
    if (res.headersSent) {
        return next(err);
    }

    if (err?.name === "UnauthorizedError") {
        return res.status(401).send("Token Expired");
    }

    res.status(500).json(err);
});


app.listen(port, (err) => {
    if (err) {
        return console.error(err);
    }
    console.log(`server is listening on ${port}`);
});