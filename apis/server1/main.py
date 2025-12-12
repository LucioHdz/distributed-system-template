from fastapi import FastAPI

app = FastAPI(port=3000)


@app.get("/")
async def root():
    return {"message": "Hello World from FastAPI! server 1"}