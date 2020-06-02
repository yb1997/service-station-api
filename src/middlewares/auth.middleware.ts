import { Response, Request, NextFunction } from "express";

export const auth = (req: Request & { user?: unknown }, res: Response, next: NextFunction) => {
    if (!req.user) {
        res.sendStatus(401);
    } else {
        next();
    }
}