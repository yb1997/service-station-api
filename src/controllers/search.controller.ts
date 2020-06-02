import { Router, Request } from "express";
import { db } from "../db";
import { auth } from "../middlewares/auth.middleware";
import { role } from "../middlewares/role.middleware";
import { AuthenticatedRequest } from "../models/autheticated-request.model";

const searchController = Router();

const router = searchController;

type Vehicle = {
    model: string;
    year: number;
    capacity: number;
}

type FillingType = "gas" | "petrol" | "diesel";

type Coordinate = { lat: number, lon: number };

type RequestBody = {
    location: Coordinate,
    fillings: { vehicle: Vehicle, fillingType: FillingType }[]
}

type NearestStationsQueryResult = {
    name: string,
    location: { type: string, coordinates: number[] },
    images: string[],
    deals_in: "diesel" | "petrol" | "gas"
}

router.post("/nearest-stations", role("consumer"), async (req, res) => {
    const data = req.body as RequestBody;

    if (!data) {
        return res.sendStatus(400);
    }

    const fillingTypes = data.fillings.map(f => f.fillingType);
    const { lat, lon } = data.location;


    const serviceStations = await db.func<NearestStationsQueryResult[]>("find_nearest_stations", [fillingTypes, lat, lon]);

    return res.json(serviceStations);

});


export { searchController };
