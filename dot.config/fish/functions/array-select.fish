function array-select
  set -l pred $argv[1]
  set -e argv[1]
  set -l result

  for i in $argv
    set -g i $i

    if eval-ex $pred >&- ^&-
      set result $result $i
    end
  end

  echo $result
  set -ge i
end
