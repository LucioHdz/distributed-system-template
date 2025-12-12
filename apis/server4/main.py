from fastapi import FastAPI

app = FastAPI(port=3004)


@app.get("/")
async def root():
    return {"message": "Hello World from FastAPI! server 4"}