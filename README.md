# Soccer API

Simple API to get Ligue 1 soccer data, written in Crystal.

## Installation

Requires Crystal 0.27.0.

```
git clone git@github.com:suruja/soccerapi.git
cd soccerapi
shards install
```

## Usage

```
crystal run src/soccerapi.cr
```

Data is renderered as JSON on `localhost:3000/`.
Data can be filtered using query params:
- `team` : selected team, as home or visitor
- `home` : selected home team
- `visitor` : selected vistor team
- `date` : date in format `YYYY-MM-DD`
- `before` : before the date in format `YYYY-MM-DD`
- `after` : after the date in format `YYYY-MM-DD`

## Contributing

1. Fork it (<https://github.com/your-github-user/./fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [suruja](https://github.com/your-github-user) - creator and maintainer
