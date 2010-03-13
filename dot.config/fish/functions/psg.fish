function psg
  set -l opt aux
  ps $opt | head -n 1
  ps $opt | grep -i $argv | grep -v grep
end
