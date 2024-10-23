# BASE IMAGE

FROM python:3.11 AS build

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Multi Stage Build 

FROM gcr.io/distroless/python3

WORKDIR /app

COPY --from=build /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages

COPY --from=build /app /app

ENV PYTHONPATH=/usr/local/lib/python3.11/site-packages:/usr/local/lib/python3.11/dist-packages:$PYTHONPATH

EXPOSE 8000

ENTRYPOINT [ "python3" ]

CMD ["manage.py", "runserver", "0.0.0.0:8000"]