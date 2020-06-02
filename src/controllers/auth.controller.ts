import { Router } from "express";
import { sign } from "jsonwebtoken";
import { db } from "../db";

const authController = Router();

type User = { user_id: number, status: number, description: string, role: string };

authController.post("/signin", async (req, res) => {

    try {

        const users = await db.func<User[]>("validate_user", [req.body.username, req.body.password]);
        
        if (!users.length) {
            return res.status(401).json("invalid username or password");
        }

        const user = users[0];

        if(user.status !== 0) {
            return res.status(401).send(user.description);
        }

        const token = sign({ userId: user.user_id, role: user.role }, process.env.SECRET as string, { expiresIn: "12h" });

        return res.json({ token });

    } catch (err) {
        return res.status(500).json(err);
    }
    
});


export { authController };