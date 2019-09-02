FROM 4ops/python:3.7

RUN set -ex; \
    \
    pip install \
    --no-cache-dir \
    --disable-pip-version-check \
    \
    amqp==2.5.1 \
    billiard==3.6.1.0 \
    celery==4.3.0 \
    celery-prometheus-exporter==1.7.0 \
    importlib-metadata==0.20 \
    kombu==4.6.4 \
    more-itertools==7.2.0 \
    prometheus_client==0.7.1 \
    pytz==2019.2 \
    redis==3.3.8 \
    vine==1.3.0 \
    zipp==0.6.0 \
    ; \
    celery-prometheus-exporter --version

USER app
EXPOSE 8888
CMD ["celery-prometheus-exporter"]
