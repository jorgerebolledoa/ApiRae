import express from "express";
import getPalabra from "../service/raeService";

const router = express.Router();

router.get('/:palabra', getPalabra);

export default router;