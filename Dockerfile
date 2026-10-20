FROM python:3.12-slim
WORKDIR /app
COPY . .
RUN if [ -f finanzas.zip ]; then python -m zipfile -e finanzas.zip /tmp/c && cp -r /tmp/c/finanzas/. /app/ && rm -rf /tmp/c finanzas.zip; fi
RUN pip install --no-cache-dir -r requirements.txt
ENV DB_PATH=/data/finanzas.db HTTPS=1
CMD gunicorn -w 1 --threads 4 --timeout 60 -b 0.0.0.0:${PORT:-8080} app:app
