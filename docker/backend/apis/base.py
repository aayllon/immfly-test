from fastapi import APIRouter

from apis.version1 import route_clock

api_router = APIRouter()
api_router.include_router(route_clock.router)