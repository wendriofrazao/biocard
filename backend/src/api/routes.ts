import { Router } from "express";

export const router = Router();

router.get("/", (req, res) => {
  return res.json({
    backend: "biocard",
    version: "1.0.0"
  });
});