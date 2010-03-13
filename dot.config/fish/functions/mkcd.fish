function mkcd
  mkdir $argv

  if test $status = 0
    set -l last $argv[-1]

    switch $last
    case '-*'
      # do nothing
    case '*'
      cd $last
    end
  end
end
