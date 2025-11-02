stages:
  - build
  - test
  - deploy

build-job:
  stage: build
  script:
    - echo "Installing dependencies..."
    - pip install -r requirements.txt

test-job:
  stage: test
  script:
    - echo "Running tests..."
    - pytest

deploy-job:
  stage: deploy
  script:
    - echo "Deploying application..."
    - echo "Copying files to server..."
