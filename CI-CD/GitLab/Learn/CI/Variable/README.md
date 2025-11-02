# GitLab CI/CD Variables Cheat Sheet

This file contains all types of GitLab CI/CD variables: predefined, custom, environment, and secret variables, with examples and explanations.

---

## 1️⃣ Predefined Variables ($CI_)

Automatically provided by GitLab in every pipeline.

| Variable             | Meaning                            | Example Use                                   |
| -------------------- | ---------------------------------- | --------------------------------------------- |
| $CI_COMMIT_BRANCH    | Branch that triggered the pipeline | if: '$CI_COMMIT_BRANCH == "main"'             |
| $CI_COMMIT_TAG       | Tag that triggered the pipeline    | if: '$CI_COMMIT_TAG =~ /^v\d+.\d+.\d+$/'      |
| $CI_PIPELINE_SOURCE  | What triggered the pipeline        | push, merge_request_event, schedule, web, api |
| $CI_JOB_NAME         | The name of the current job        | echo "Job: $CI_JOB_NAME"                      |
| $CI_JOB_STAGE        | The stage of the current job       | echo "Stage: $CI_JOB_STAGE"                   |
| $CI_PROJECT_NAME     | Project name                       | echo "Project: $CI_PROJECT_NAME"              |
| $CI_PROJECT_PATH     | Full path of project               | echo $CI_PROJECT_PATH                         |
| $CI_PROJECT_DIR      | Full path to cloned repo on runner | cd $CI_PROJECT_DIR                            |
| $CI_PIPELINE_ID      | Unique pipeline ID                 | echo $CI_PIPELINE_ID                          |
| $CI_PIPELINE_IID     | Pipeline number within project     | echo $CI_PIPELINE_IID                         |
| $CI_JOB_ID           | Unique job ID                      | echo $CI_JOB_ID                               |
| $CI_COMMIT_SHA       | Commit SHA                         | echo $CI_COMMIT_SHA                           |
| $CI_COMMIT_MESSAGE   | Commit message                     | echo $CI_COMMIT_MESSAGE                       |
| $CI_REGISTRY         | Container registry URL             | docker login $CI_REGISTRY                     |
| $CI_ENVIRONMENT_NAME | Environment name                   | echo $CI_ENVIRONMENT_NAME                     |

---

## 2️⃣ Custom Variables

User-defined variables, used for configuration, parameters, or secrets.

### a) In `.gitlab-ci.yml`

```yaml
variables:
  MY_ENV: "staging"
  API_KEY: "12345"
```

### b) In GitLab UI

* Project → Settings → CI/CD → Variables → Add Variable
* Example: `DB_PASSWORD = mySecret123` (Masked, Protected)

### c) Runtime variables

```bash
git push origin main -o "variables[DEPLOY_ENV]=production"
```

### Usage in Job

```yaml
build-job:
  script:
    - echo $MY_ENV
    - echo $API_KEY
```

---

## 3️⃣ Environment Variables

Defined for specific environments (staging, production)

```yaml
deploy-job:
  environment:
    name: production
  script:
    - echo "Deploying to $CI_ENVIRONMENT_NAME"
    - echo "DB Password is $DB_PASSWORD"
```

* `$CI_ENVIRONMENT_NAME` → predefined
* `$DB_PASSWORD` → custom secret variable

---

## 4️⃣ Secret Variables

Sensitive data, masked and/or protected.

### How to create

1. GitLab UI → Project → Settings → CI/CD → Variables → Add Variable
2. Key: `DB_PASSWORD`, Value: `mypassword`
3. Optional: Masked + Protected

### Use in Job

```yaml
deploy-job:
  script:
    - ./deploy.sh --password "$DB_PASSWORD"
```

### Tips

* Always **mask** secrets
* Protect for production branches only
* Don’t store secrets in `.gitlab-ci.yml`

---

## 5️⃣ Combine Variables

```yaml
stages:
  - build
  - test
  - deploy

variables:
  APP_ENV: "staging"

build-job:
  stage: build
  script:
    - echo "Building $CI_PROJECT_NAME for $APP_ENV on branch $CI_COMMIT_BRANCH"

test-job:
  stage: test
  script:
    - echo "Running tests for $CI_COMMIT_SHA"

deploy-job:
  stage: deploy
  script:
    - echo "Deploying $CI_PROJECT_NAME to $APP_ENV environment"
```

✅ Use **predefined**, **custom**, and **secret** variables together for dynamic pipelines.

---

**References:**

* [GitLab CI/CD Predefined Variables](https://docs.gitlab.com/ee/ci/variables/predefined_variables.html)
* [GitLab CI/CD Variables](https://docs.gitlab.com/ee/ci/variables/)
