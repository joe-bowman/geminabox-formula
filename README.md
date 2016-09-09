# geminabox-formula
A Saltstack formula to install the geminabox Gem Server.

This formula also installs dependencies of geminabox, including Ruby and Ruby Development packages.

## Pillar
The formula should create a running geminabox server, without any additional pillar.

In order to deploy a caching mirror of http://rubygems.org, the following pillar is required:
```
geminabox:
  config:
    rubygems_proxy: True
    allow_remote_failure: True
```

Additional configuration is available, including the interface/port that the application listens on, filesystem paths and logging.

See `example.pillar` for the available options.
