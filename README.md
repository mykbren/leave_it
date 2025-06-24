# leave_it

**Inject pessimistic (`~>`) version constraints into your Gemfile from your Gemfile.lock automatically, preventing major updates during bundling and allowing only safe patch and minor version upgrades.**

If I had to describe the motivation behind this tool in one sentence, it would be:  
**No more pain after `bundle update` — keep your Gemfile locked to working versions, and update dependencies one by one only when needed.** (⇀‸↼‶)

PS. Patches can still break functionality sometimes, but by nature they shouldn’t — this tool helps minimize those risks. (｀_´)ゞ

---

## Motivation

Managing Ruby gem dependencies can be tricky, especially when your Gemfile includes gems without explicit version constraints. Running bundle update often results in major version bumps that introduce breaking changes or cause unexpected instability in your project.

I was tired of manually specifying version constraints and constantly dealing with surprise major upgrades during bundling that break things — wasting hours debugging incompatibilities.

Another common pain is resurrecting an old project from its Gemfile.lock. The lockfile helps you restore the exact gem versions that last worked, but sometimes you need to update a few libraries to get the project running on newer Ruby or system environments. Then, running bundle update without precise version constraints causes a flood of major upgrades, breaking your app's functionality completely — and leaving you staring at a wall of errors (╯°□°）╯︵ ┻━┻

This tool solves those headaches by scanning your Gemfile.lock and automatically injecting the correct pessimistic (~>) version constraints into your Gemfile for any gems missing them. This keeps your dependencies safely locked, prevents unintentional major upgrades, and helps maintain project stability — whether you’re actively developing or resurrecting legacy code.

---

## Features

* Parses your `Gemfile.lock` for exact gem versions.
* Adds pessimistic version constraints (`~> x.y.z`) to unversioned gems in your `Gemfile`.
* Keeps existing version constraints untouched.
* Simple CLI interface — just run in your project directory.
* Helps reduce unintended major version updates and improves bundle stability.

---

## Installation

Add this line to your Gemfile:

```ruby
gem 'leave_it'
```

Then execute:

```bash
bundle install
```

Or install it yourself with:

```bash
gem install leave_it
```

---

## Usage

Run the CLI from your project root directory (where `Gemfile` and `Gemfile.lock` reside):

```bash
leave-it .
```

This will update your `Gemfile` in-place, adding `~>` version constraints for all gems missing them, based on the versions locked in your `Gemfile.lock`.

---

## Example

Before:

```ruby
gem 'rake'
gem 'rspec', '~> 3.10'
```

After running `leave-it .`:

```ruby
gem 'rake', '~> 13.0.6'
gem 'rspec', '~> 3.10'
```

---

## Development

Clone the repo and run tests:

```bash
git clone https://github.com/mykbren/leave_it.git
cd leave_it
bundle install
bundle exec rspec
```

---

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/mykbren/leave_it](https://github.com/mykbren/leave_it).

---

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).