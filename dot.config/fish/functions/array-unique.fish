function array-unique
  echo (array-inject 'contains $i $acc; and echo $acc; or echo $acc $i' '' $argv)
end
