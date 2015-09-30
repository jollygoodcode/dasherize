namespace :maintain do
  desc "update gems"
  task :update do
    today = Time.current.strftime("%F")

    abort("Please clean your local file changes first.") if `git status --porcelain` != ""

    abort("Please run this task against master branch") if `git rev-parse --abbrev-ref HEAD`.chomp! != "master"

    output_warning "\n== Pulling latest changes from remote origin =="
    `git pull origin master`

    output_warning "\n== Bundle update & Running specs =="
    `bundle update && bin/rspec`

    if $CHILD_STATUS.success?
      `git checkout -b bundle-update-#{today}`
      `git add Gemfile.lock`
      `git commit -m "Bundle update on #{today}\nAuto-pushed by 'rake maintain:update task'."`
      `git push origin bundle-update-#{today}`
    else
      `git checkout Gemfile.lock`
      output_warning "Something went wrong while performing `bundle update` or updated gems break tests."
    end
  end
end

def output_warning(info)
  if Rails.env.development?
    puts info
  else
    logger.warn info
  end
end
