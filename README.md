Steps:

## Prepare the project
- Clone the repository https://github.com/soerenmartius/terramate-azure-demo
- Login to your azure account `az login` and select a subscription
- Run `terramate create –all-terraform` to onboard Terramate stacks to root modules
- Give the stacks a meaningful `description` and `name` in the `stacks.tm.hcl` files, this will later help you to identify stacks in Terramate Cloud properly
Create a directory `.tf_plugin_cache_dir` at the root level for provider caching (mkdir ..tf_plugin_cache_dir && touch .tf_plugin_cache_dir/.gitkeep)
- Register for a Terramate Cloud account at https://cloud.terramate.io and create an organization
- Create `terramate.tm.hcl` to configure your Terramate project (Terramate uses HCL for configuration, but yml and env variables are supported also). Suffix `.tm.hcl` and `.tm` are accepted. All Terramate configuration files in the same directory are merged, similar to what Terraform does with `.tf` files.

```hcl
# terramate.tm.hcl
terramate {
  required_version = ">= 0.11.1"

  # required_version_allow_prereleases = true

  config {
    # Optionally disable safe guards
    # Learn more: https://terramate.io/docs/cli/orchestration/safeguards
    # disable_safeguards = [
    #   "git-untracked",
    #   "git-uncommitted",
    #   "git-out-of-sync",
    #   "outdated-code",
    # ]

    # Configure the namespace of your Terramate Cloud organization
    cloud {
      organization = "<TERRAMATE-CLOUD-ORGANIZATION-NAMESPACE>"
    }

    # git {
    #   default_remote = "origin"
    #   default_branch = "main"
    # }

    run {
      env {
        TF_PLUGIN_CACHE_DIR = "${terramate.root.path.fs.absolute}/.tf_plugin_cache_dir"
      }
    }

    # Enable Experiments
    experiments = [
      "scripts",
      "outputs-sharing",
    ]
  }
}
```



Stacks can either be nested to work with an implicit order of execution, e.g.
network/
  aks/
  flux/
Understand the run order with `terramate list –run-order`
Or by using `before` and `after` to configure the explicit order of execution 
`terramate fmt` will format all your Terraform configuration files recursively throughout the hierachy
Run `terraform init` in a single stack `terramate run -X -C network -- terraform init` (-X will ignore the safeguards in Terramate. You can also configure those in your `terramate.tm.hcl`
Run `terraform init` in all stacks using the configured order of execution
Run `terraform plan`
