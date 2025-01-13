# Number Pattern Analyzer

A Ruby-based tool for analyzing numerical patterns and relationships, with Prolog-powered pattern recognition.

## Features

- Calculate squares and differences in number sequences
- Detect mathematical patterns and relationships
- Export results to CSV or JSON
- Customizable pattern recognition rules
- Interactive command-line interface

## Installation

1. Clone the repository:


bash
git clone https://github.com/yourusername/number-pattern-analyzer



2. Install dependencies:

bash
bundle install



3. Ensure SWI-Prolog is installed on your system:
- Ubuntu/Debian: `sudo apt-get install swi-prolog`
- macOS: `brew install swi-prolog`
- Windows: Download from https://www.swi-prolog.org/download/stable

## Usage

### Interactive Mode

bash
ruby bin/run.rb

### Command Line Arguments
```bash
ruby bin/run.rb --start 1 --end 100 --step 1 --patterns on
```

### Adding Custom Patterns

Create a new Prolog file in `lib/patterns/` following this template:
```prolog
pattern(my_pattern, [example, sequence]) :-
    description('Description of the pattern'),
    properties([
        property1('value'),
        property2('value')
    ]).
```

## Configuration

Edit `config/settings.yml` to customize default behavior:
```yaml
patterns_enabled: true
auto_export: false
export_format: csv
display_fractions: true
display_differences: true
```

## Contributing

1. Fork the repository
2. Create your feature branch
3. Add your changes
4. Submit a pull request

## License

MIT License - see LICENSE file for details
```

source 'https://rubygems.org'

gem 'minitest'
gem 'rake'
gem 'json'