# first stage
FROM python:3 AS builder
WORKDIR /code
COPY . .
RUN pip install --user --no-cache-dir --use-feature=in-tree-build .

# second stage
FROM python:3-slim
COPY --from=builder /root/.local /root/.local
ENV PATH=/root/.local/bin:$PATH
EXPOSE 8025
CMD [ "mailrise", "/etc/mailrise.conf" ]
