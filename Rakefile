require 'html-proofer'

task :test do
  sh "bundle exec jekyll build"
  # HTMLProofer.check_directory("./_site", allow_hash_href: true, disable_external: true).run
end

task :serve do
  sh "bundle exec jekyll serve --drafts"
end
