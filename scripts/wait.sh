while STATUS=$(docker inspect --format "{{json .State.Health.Status }}" $1); [ $STATUS != "\"healthy\"" ]; do
  if [ $STATUS == "\"unhealthy\"" ]; then
    echo "unhealthy container"
    exit -1
  fi
  printf .
  lf=$'\n'
  sleep 1
done
printf "$lf"
