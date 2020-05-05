to run:

```
docker build -t snowflake .
docker run -it -v "$(pwd)/docker-image/testConnection.py:/testConnection.py" -v "$(pwd)/docker-image/run.sh:/run.sh" snowflake /bin/bash
```
