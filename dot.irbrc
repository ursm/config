IRB.conf.update(
  :SAVE_HISTORY => 10000,
  :PROMPT_MODE => :SIMPLE
)

%w(irb/completion pp rubygems what_methods utility_belt).each do |l|
  begin
    require l
  rescue LoadError
  end
end

class Object
  def tapp
    tap { pp self }
  end
end
