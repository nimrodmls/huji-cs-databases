for file in ~/db/ex3/sols/*; do
  if [ -f "$file" ]; then
    psql -h dbcourse public -f "$file" > "$file.out"
  fi
done