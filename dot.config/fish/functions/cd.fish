function cd
  cd $argv

  if test $status = 0
    ls
  end
end
