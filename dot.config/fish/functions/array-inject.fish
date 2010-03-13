function array-inject
  set -l expr $argv[1]
  set -l acc $argv[2]
  set -e argv[1 2]

  for i in $argv
    eval set acc (eval $expr)
  end

  echo $acc
end
