if [ $# -ne 1 ]; then
  echo "Usage: $0 <file>"
  exit
fi

cat $1 | awk '{
  for(i=1;i<NF;i++) printf("%s,", $i);
  printf("%s\n", $NF);
}'
