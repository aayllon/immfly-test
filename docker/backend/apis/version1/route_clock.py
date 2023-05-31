from fastapi import APIRouter
import time

router = APIRouter()


@router.get("/clock")
def clock():
    return time.time()