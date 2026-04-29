FROM python:3.11-slim as builder 

WORKDIR /app

RUN pip install --upgrade pip
COPY requirements.txt .

RUN pip install -r requirements.txt

FROM python:3.11-slim

WORKDIR /app

RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

COPY --from=builder /usr/local/lib/python3.11/site-packges /usr/local/lib/python3.11/site-packges

COPY --from=builder /usr/local/bin/uvicorn /usr/local/bin/uvicorn

COPY app/ ./app/

USER appuser
EXPOSE 8080
CMD ["uvicorn, "app.main:app", "--host", "0.0.0.0", "--port", "8080"]
  
