FEATURES

## Start from scratch

- Clone the repository https://github.com/ned1313/env0-environment-outputs
- Login to your azure account `az login` and select a subscription
- Run `terramate create –all-terraform` to onboard Terramate stacks to root modules
- Give the stacks a meaningful `description` and `name` in the `stacks.tm.hcl` files, this will later help you to identify stacks in Terramate Cloud properly
- Create a directory `.tf_plugin_cache_dir` at the root level for provider caching (mkdir ..tf_plugin_cache_dir && touch .tf_plugin_cache_dir/.gitkeep)
- Register for a Terramate Cloud account at https://cloud.terramate.io and create an organization
- Login with the CLI using `terramate cloud login`.
- Create `terramate.tm.hcl` as mentioned below to configure the project
- Start deploying / syncing operations

## Start with the fork

- Clone the fork/updated code https://github.com/soerenmartius/terramate-azure-demo
- Login to your azure account `az login` and select a subscription
- See all stacks in your `terramate list` (can also be used with filters such as change detection and tags `terramate list --changed --tags kubernetes,terraform`)
- Accept invitation to Terramate Cloud ACcounts
- Login with the CLI using `terramate cloud login`.
- Create `terramate.tm.hcl` to configure your Terramate project (Terramate uses HCL for configuration, but yml and env variables are supported also). Suffix `.tm.hcl` and `.tm` are accepted. All Terramate configuration files in the same directory are merged, similar to what Terraform does with `.tf` files.
- `terramate fmt` will format all your Terraform configuration files recursively throughout the hierachy

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

## Stacks Basics

Stacks are a at the most basic form just a directory with a `stack.tm.hcl`. They are used to group infrastructure code, configuratin and state (often managed remote) and can be executed in an isolated manner.

Stacks can either be nested to work with an implicit order of execution, e.g.
```sh
network/
  aks/
  flux/
```

Or by using `before` and `after` to configure the [explicit order of execution](https://terramate.io/docs/cli/stacks/configuration#explicit-order-of-execution)

## Orchestration Basics

When running commands such as `terramate run`, Terramate creates a DAG of stack that can be filted with e.g. change detection or tags.

- Understand the run order with `terramate list –run-order` (also accepts filters)
- Understand what stacks contain changes in the current PR, branch or range of commits `terramate list --changed`
- Run commands in the DAG of stacks using `terramate run -- <CMD>`

## Outputs Examples

In `example_outputs/`, we are using Terramate code generation to generate output dependencies among stacks using the [outputs sharing feature](https://terramate.io/docs/cli/orchestration/outputs-sharing#setup-outputs-sharing-backends) in the CLI.
This will generate `outputs` and `variables` allowing users to stay in a native environment.

- Run `terramate run -X -- terraform init` to download dependencies
- Run a plan in all stacks with enabled output sharing and mocking
  ```sh
  terramate run -X \
    --enable-sharing \
    --mock-on-fail \
    -- \
    terraform plan -out out.tfplan
  ```
- Deploy the infrastructure sequentially (network -> aks -> flux)
  ```sh
  terramate run \
    -X \
    --sync-deployment \
    --terraform-plan-file=out.tfplan \
    -- \
    terraform apply -input=false -auto-approve -lock-timeout=5m out.tfplan
  ```
This will make the deployment observability for all stacks available at https://cloud.terramate.io/o/sm-azure-demo/deployments/
  - understand what plans have been applied
  - who deployed when
  - health checks are optional drift detection checks that can be run and synced after each deployment to understand if a stack has drifted right away. This is especially helpful when looking at partially applied plans as it helps to understand the desired plan vs what was actually applied

- Run a drift check and sync to Terramate Cloud (can also run in parallel in stacks that aren't dependent on each other using the `--parallel <THREADS>` flag)
  ```sh
  terramate run \
   -X \
   --enable-sharing \
   --mock-on-fail \
   --sync-drift-status \
   --terraform-plan-file drift.tfplan \
   --continue-on-error \
   -- \
   terraform plan -out drift.tfplan -input=false -detailed-exitcode -lock=false
  ```

- Dashboard now shows an overview of all stacks: https://cloud.terramate.io/o/sm-azure-demo/dashboard
- Stacks list is available at https://cloud.terramate.io/o/sm-azure-demo/stacks?page=1 (see how the `id`, `name` and `description` are synced from CLI, This also works with optional configuration parameters such as `tags`)
- E.g. look at what resources a stack manages: https://cloud.terramate.io/o/sm-azure-demo/stacks/5498143?page=1#resources
- Resource browser, CIS Policy checks, etc. is available at https://cloud.terramate.io/o/sm-azure-demo/resources?page=1
  
This works because Terramate CLI is syncing [sanitized plans](https://terramate.io/docs/security/#plan-sanitization) to Terramate Cloud. Plans are sanitized on the client side - no credentials or sensitive values are synced to Terramate Cloud.

- Query all `drifted` stack with `terramate list --status drifted`
- Reconcile drift with `terramate run --status drifted -- terraform apply` (can be used in workflows to automatically reconcile drift after drift detection in combination with tags to decide what stacks should be reconciled automatically, e.g. `terramate run --status drifted --tags reconcile -- terraform apply`)

- Destroy all infrastructure 
  ```sh
  terramate run \
    -X \
    --reverse \
    --enable-sharing \
    --mock-on-fail \
    -- \
    terraform destroy -auto-approve
  ```

## Data Sources Example
