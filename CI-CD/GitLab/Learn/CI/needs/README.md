needs use when you have 2 job in one stage and you want to if job 1 success , run job 2

.gitlab-ci.yml

```
stages:
  - pipeline

build-job:
  stage: pipeline
  script:
    - echo "Building the project..."
    - mkdir build
    - echo "Build complete." > build/result.txt
  artifacts:
    paths:
      - build/
    expire_in: 1 hour

test-job:
  stage: pipeline
  needs: [build-job]   # test-job depends on build-job, even in same stage
  script:
    - echo "Running tests after build..."
    - cat build/result.txt
    - echo "Tests passed successfully!"

```
