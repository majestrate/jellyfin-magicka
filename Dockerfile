FROM elixir:1.15

# By default, if we're cutting a release it'll likely be prod
ARG ENV=prod

# We'll pass in ENV as a build arg to docker
ENV MIX_ENV=$ENV

# Our working directory within the container
WORKDIR /opt/jellyfin



ADD ./config/config.exs ./config/config.exs
ADD ./lib ./lib
ADD ./priv/web ./priv/web
ADD ./bin/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT "/entrypoint.sh" "$ENV"