import { Request } from "express";

type UserPayload = { userId: number, role: string }

export type AuthenticatedRequest = Request<any> & {
    user: UserPayload
}