### Terraform-IAC

Isolating state files

There are two ways you could isolate state files:
1) Isolation via workspaces: useful for quick, isolated tests on the same configuration.
2) Isolation via file layout: useful for production use-cases where you need strong separation between environments.
