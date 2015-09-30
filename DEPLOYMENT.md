# Deployment

Host on Heroku. [Integrated with GitHub](https://devcenter.heroku.com/articles/github-integration).

## Deploy to Staging

    git push staging master

## Deploy a Feature Branch to Staging

Suppose feature branch name: `feature/awesome`:

    git push staging feature/awesome:master

## Deploy to Production

    git push production master

For more information, please refer to [Heroku Docs](https://devcenter.heroku.com/articles/git).
