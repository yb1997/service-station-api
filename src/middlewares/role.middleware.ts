import { Response, Request, NextFunction } from "express";

type Role = "service_station" | "consumer";
type User = { userId: string, role: Role };

export const role = (role: Role) => (req: Request & { user?: User }, res: Response, next: NextFunction) => {
    if (!req.user) {
        res.sendStatus(401);
    } else if (req.user.role !== role) {
        res.sendStatus(403);
    } else {
        next();
    }
}