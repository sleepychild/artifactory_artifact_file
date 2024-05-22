# artifactory_artifact_file

A very simple concourse resource.
It just tracks for versioned files in a jfrog / artifactory repo path and can get the newest file.
It also creates a `metadata.json` with the reported artifactory file perticulars (repo , path created when and by who, size and checksums).

## Usage

```yaml
---
resource_types:
  - name: artifactory_artifact_file
    type: registry-image
    source:
      repository: ((the_image_you_build_with_the_docker_file))
      tag: ((the_tag_you_tagged_it_with))
resources:
  - name: example_resource_name
    type: artifactory_artifact_file
    source:
      artifactory_url: ((artifactory_url))
      artifactory_repo: ((artifactory_repo))
      artifactory_path: ((artifactory/path))
      artifactory_token: ((artifactory_token))
      log_level: ((log_level)) # OPTIONAL
      dry_run: ((dry_run)) # OPTIONAL
jobs:
  - name: check_file
    plan:
    - get: example_resource_name
      trigger: true
    - task: check_file
      config:
        platform: linux
        image_resource:
          type: registry-image
          source:
            repository: alpine
        inputs:
          - name: example_resource_name
        run:
          path: ls
          args: 
            - -alh
            - example_resource_name
```

## Params

> Note: url / uri elements should be set without leading or trailing `/`

### artifactory_url

This would be something like `https://something.jfrog.io`.

### artifactory_repo

This would be the name of the repository where the files are stored.

### artifactory_path

This is the sub-folder within the repo where the versioned files are located.

### artifactory_token

This is your artifactory access token. This is the `Authorization: Bearer <TOKEN>` thing.

### dry_run (optional)

If you just want to check for a new file and get the metadata without downloading.