require 'pathname'

HOME = Pathname.new(ENV['HOME'])

def ln_snf(source, *dest)
	sh 'ln', '-snf', source, *dest
end

task :default => :all
task :all => %w(regular:symlink dotfiles:symlink)

namespace :regular do
	task :symlink do
		ln_snf Pathname('bin').expand_path.relative_path_from(HOME), HOME + 'bin'
	end
end

namespace :dotfiles do
	task :symlink do
		Pathname.glob('dot.*').map(&:expand_path).map {|p|
			[p.relative_path_from(HOME), HOME + p.basename.sub(/^dot\./, '.')]
		}.each do |from, to|
			ln_snf from, to
		end
	end
end
