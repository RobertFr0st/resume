FROM elixir:latest

MAINTAINER Nicholas Kelley <nickdk.1995@gmail.com>

#phoenix prereqs
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get update && apt-get install -y build-essential libpq-dev postgresql-client nodejs wkhtmltopdf xvfb

ENV PHOENIX_ROOT /var/www/resume
RUN mkdir -p $PHOENIX_ROOT/tmp/pids
WORKDIR $PHOENIX_ROOT

COPY mix.exs mix.exs
COPY mix.lock mix.lock

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez
RUN mix deps.get

COPY . .

#mix ecto.create &&
