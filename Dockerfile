ARG VERSION="1.5.1"

FROM docker.io/library/python:3.6-slim

ARG VERSION

# hadolint ignore=DL3008,DL4006,SC2086
RUN set -eux \
  \
  ; export VERSION=$(echo "${VERSION}" | grep -oE '[0-9.]+') \
  \
  ; useradd \
      --comment "Celery Exporter Application" \
      --home-dir /home/celery-exporter \
      --create-home \
      --uid 1042 \
      --user-group \
      celery-exporter \
  \
  ; apt-get -q update \
  ; apt-get -qy install --no-install-recommends wget \
  \
  ; wget -qO base.txt https://raw.githubusercontent.com/OvalMoney/celery-exporter/${VERSION}/requirements/base.txt \
  ; wget -qO requirements.txt https://raw.githubusercontent.com/OvalMoney/celery-exporter/${VERSION}/requirements/requirements.txt \
  \
  ; export PYTHONDONTWRITEBYTECODE=1 \
  ; export PYTHONUNBUFFERED=1 \
  \
  ; pip install \
      --disable-pip-version-check \
      --no-cache-dir \
      --no-color \
      --no-input \
      -r requirements.txt \
  \
  ; pip install \
      --disable-pip-version-check \
      --no-cache-dir \
      --no-color \
      --no-input \
      \
      celery-exporter==${VERSION} \
  \
  ; celery-exporter --verbose --version \
  \
  ; apt-get -qy purge wget \
  ; apt-get -qy autoremove \
  ; rm -rf \
      base.txt \
      requirements.txt \
      ~/.cache \
      ~/.bash_history \
      ~/.wget-hsts \
      /var/lib/apt/lists/* \
      /home/celery-exporter/.bash_logout

USER 1042:1042

EXPOSE 9540

ENTRYPOINT ["celery-exporter"]
CMD []
