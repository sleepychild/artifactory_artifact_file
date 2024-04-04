# artifactory_artifact_file

A very simple concourse resource.
It just tracks for versioned files in a jfrog / artifactory repo path and can get a file.

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
