import psycopg2
from fastapi import FastAPI, Request, Response, HTTPException, status
from fastapi.encoders import jsonable_encoder
from fastapi.responses import JSONResponse
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel
from typing import Union
from starlette.responses import FileResponse

app = FastAPI()

db = psycopg2.connect(
    dbname="cytech", host="192.168.100.127"
)


class User(BaseModel):
    id: int
    name: str


def fetch_users():
    cur = db.cursor()
    cur.execute(
        "SELECT id, name FROM cytech;"
    )
    records = cur.fetchall()
    db.commit()
    cur.close()
    return [
        User(
            id=r[0],
            name=r[1],
        )
        for r in records
    ]


@app.get("/api/users")
def get_users():
    try:
        users = fetch_users()
        return JSONResponse(content=jsonable_encoder(users))
    except Exception as e:
        raise HTTPException(
            content="Internal error",
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
        )


@app.get("/")
async def read_index():
    return FileResponse('static/index.html')