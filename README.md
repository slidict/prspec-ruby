# prspec-ruby

`prspec` is a local CLI for Ruby/RSpec projects. It reviews a pull request or a
local `git diff` from a test-risk perspective before merge. It is not a code
review tool; it is a small test review helper that warns when Ruby changes appear
to be missing corresponding spec updates.

The public tool name and executable command are `prspec`. The gem name is
`prspec-ruby`, the require name is `prspec-ruby`, files live under
`lib/prspec/...`, and the implementation namespace is intentionally
`Rrspec::Ruby`.

## Installation

Install from git until the gem is released:

```bash
bundle add prspec-ruby --git https://github.com/slidict/prspec-ruby.git
```

After release, install with:

```bash
gem install prspec-ruby
```

## Usage

Run a review against the default diff:

```bash
prspec review
```

Review a specific range or pull-request style range:

```bash
prspec review HEAD~1
prspec review main...HEAD
```

By default, warnings exit with status `0`. To fail CI when warnings are found:

```bash
prspec review --fail-on-warning
```

Other commands:

```bash
prspec version
prspec help
```

## Output examples

When risks are found:

```text
prspec review

MISSING SPEC
lib/billing/refund_calculator.rb
No matching spec changed.
Expected one of:
- spec/billing/refund_calculator_spec.rb
- spec/lib/billing/refund_calculator_spec.rb

RISKY CHANGE
lib/user_status_transition.rb
Ruby file changed without spec updates.

2 issues found.
```

When no risks are found:

```text
prspec review

No test risks found.
```

## MVP limitations

This MVP is local-only. It does not include SaaS, a Web UI, a GitHub App,
a database, authentication, external API integrations, LLM integrations, or a
configuration file. The heuristics are intentionally simple: `prspec review`
reads `git diff --name-only`, ignores files under `spec/`, checks changed Ruby
files, guesses matching spec paths, and warns if no matching spec changed in the
same diff.

## Development

Run tests with:

```bash
bundle exec rspec
```

Run the executable directly during development:

```bash
bundle exec exe/prspec version
bundle exec exe/prspec review HEAD~1
```

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/slidict/prspec-ruby.

## License

The gem is available as open source under the terms of the MIT License.
