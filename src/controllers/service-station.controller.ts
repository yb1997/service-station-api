import { Router } from "express";
import { auth } from "../middlewares/auth.middleware";
import { ServiceStation } from "../models/service-station.model";
import { db } from "../db";
import { role } from "../middlewares/role.middleware";
import Multer, { diskStorage, } from "multer";
import { AuthenticatedRequest } from "../models/autheticated-request.model";

const serviceStationController = Router();

const router = serviceStationController;

const storage = diskStorage({
    destination: (req, file, cb) => {
        cb(null, "public/images/");
    },
    filename: (req, file, cb) => {
        cb(null, file.originalname);
    } 
});
const upload = Multer({ storage });

router.get("/all", auth, async (req, res) => {
    const users = await db.proc("fetch_users");

    const serviceStations: ServiceStation[] = await db.any<ServiceStation>("select id, name, images, st_astext(location) from service_stations");

    res.json(serviceStations);
});

router.get("/?name={n}", async (req, res) => {
    const serviceStations = await db.oneOrNone("select id, name, images, st_astext(location) from service_stations where name = $0", [req.query.name]);

    res.json(serviceStations);
});

router.post("/upload-photo", role("service_station"), upload.array('photos', 3), async (req, res) => {
    const userId = (req as AuthenticatedRequest).user.userId;
    const fileNames = (req.files as Express.Multer.File[]).map(file => `/images/${file.originalname}`);
    await db.none("update service_stations set images = $1 where id = $2", [fileNames, userId]);
    return res.status(200).send("images uploaded!");
});


export { serviceStationController };