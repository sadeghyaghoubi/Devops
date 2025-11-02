.gitlab-ci.yml
```
stages:
  - pipeline

build-job:
  stage: pipeline
  script:
    - echo "Installing dependencies..."
    - pip install -r requirements.txt
    - echo "Building project..."
    - python3 build.py

test-job:
  stage: pipeline
  needs: [build-job]
  script:
    - echo "Running tests..."
    - pytest tests/
```
