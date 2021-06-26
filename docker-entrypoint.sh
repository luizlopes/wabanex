#!/bin/bash
mix deps.get
mix ecto.setup
mix compile --force
# mix seeds
mix phx.server