to run:

```
docker build -t snowflake .
docker run -it -v "$(pwd)/testConnection.py:/testConnection.py" -v "$(pwd)/run.sh:/run.sh" snowflake /bin/bash
```
