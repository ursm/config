function array-find
  set -l pred $argv[1]
  set -e argv[1]

  for i in $argv
    set -g i $i

    if eval-ex $pred >&- ^&-
      echo $i
      break
    end
  end

  set -ge i
end
