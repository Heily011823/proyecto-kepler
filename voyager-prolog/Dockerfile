FROM swipl
WORKDIR /app

COPY ./src ./src

CMD ["swipl", "-s", "src/voyager.pl", "-g", "main"]