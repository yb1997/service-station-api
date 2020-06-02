import { Router } from "express";
import { db } from "../db";
import { auth } from "../middlewares/auth.middleware";
import { role } from "../middlewares/role.middleware";
import { AuthenticatedRequest } from "../models/autheticated-request.model";
import { Vehicle } from "../models/vehicle.model";

const bookingController = Router();

const router = bookingController;


// this route is for services stations to find out any booking requests received for filling 
router.get("/bookings-received", role("service_station"), async (req, res) => {
    const user_id = (req as AuthenticatedRequest).user.userId;

    const bookings: any[] = await db.any(
        "select c.first_name, c.last_name, c.email, b.booking_detail, b.created_on from bookings b\
            join consumers c on c.id = b.consumer_id\
            where service_station_id = $1 and c.is_blocked = false;",

        [user_id]
    );

    return res.json(bookings);

});

router.post("/book_fillings", role("consumer"), async (req, res) => {
    const payload = req.body as { serviceStationId: number, bookingDetail: Vehicle[] };
    const consumerId = (req as AuthenticatedRequest).user.userId;

    const result = await db.func(
        "book_fillings",
        [consumerId, payload.serviceStationId, JSON.stringify(payload.bookingDetail)]
    );

    return res.json({ bookingId: result[0].book_fillings });
});

export { bookingController };
