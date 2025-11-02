```
workflow:
  rules:
    - if: '$CI_PIPELINE_SOURCE == "merge_request_event"'
      when: always
    - if: '$CI_COMMIT_BRANCH == "main"'
      when: always
    - when: never
```
Run pipeline when:

A merge request is created, or

Code is pushed to main

Otherwise → skip pipeline




# Common GitLab CI/CD $CI_ Variables

Here is a list of the most commonly used predefined GitLab CI/CD variables:

| Variable | Meaning | Example Use |
|----------|---------|-------------|
| $CI_COMMIT_BRANCH | Name of the branch that triggered the pipeline | if: '$CI_COMMIT_BRANCH == "main"' |
| $CI_COMMIT_TAG | Tag that triggered the pipeline (if any) | if: '$CI_COMMIT_TAG =~ /^v\d+\.\d+\.\d+$/' |
| $CI_PIPELINE_SOURCE | What triggered the pipeline | push, merge_request_event, schedule, web, api |
| $CI_JOB_NAME | The name of the current job | echo "This job is $CI_JOB_NAME" |
| $CI_JOB_STAGE | The stage of the current job | echo "Stage: $CI_JOB_STAGE" |
| $CI_PROJECT_NAME | The project name | echo "Project: $CI_PROJECT_NAME" |
| $CI_PROJECT_PATH | Full path of the project | group/project-name |
| $CI_PROJECT_DIR | Full path to where the project is cloned on runner | cd $CI_PROJECT_DIR |
| $CI_PIPELINE_ID | Unique ID of the pipeline | echo "Pipeline ID: $CI_PIPELINE_ID" |
| $CI_PIPELINE_IID | Pipeline number within project | echo "Pipeline #$CI_PIPELINE_IID" |
| $CI_JOB_ID | Unique ID of the job | echo "Job ID: $CI_JOB_ID" |
| $CI_COMMIT_SHA | SHA of the commit that triggered the pipeline | echo "Commit SHA: $CI_COMMIT_SHA" |
| $CI_COMMIT_MESSAGE | Commit message | echo "Message: $CI_COMMIT_MESSAGE" |
| $CI_REGISTRY | GitLab Container Registry URL | docker login $CI_REGISTRY |
| $CI_ENVIRONMENT_NAME | Environment of the job | echo "Deploying to $CI_ENVIRONMENT_NAME" |

**Notes:**
- You can combine variables in `rules` or `script`.
- There are also `$CI_RUNNER_*` and `$CI_PROJECT_*` variables.
- You can define your own custom variables in GitLab UI or `.gitlab-ci.yml`.
