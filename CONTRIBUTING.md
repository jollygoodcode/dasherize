# Contributing

Thank you for contributing! We :heart: pull requests from everyone.

We have a few technical guidelines to follow:

1. Open an issue to discuss a new feature.
2. Write tests.
3. Make sure the entire test suite passes locally and on CI.
4. Update your code according to `rubocop` preferences.
5. Open a pull request.
6. Participate in the reviews on the pull request.

For pure documentation changes, please add `[ci skip]` to your commit message,
to prevent CI server from needless :runner:.

## Configure Your Local Development Environment

After cloning this repository, run the setup script:

`bin/setup`

Prepare your `ENV` variables accordingly with `.env.sample`.

## Testing

Set up your development environment as per previous section.

Run `bin/rspec` to execute the full test suite.

## Style Checks

### Ruby

Run style checks with `bundle exec rubocop -DR`

## Contributor License Agreement

If you submit a contribution to this application's source code, you hereby grant
it under MIT LICENSE. See [LICENSE](/LICENSE).
