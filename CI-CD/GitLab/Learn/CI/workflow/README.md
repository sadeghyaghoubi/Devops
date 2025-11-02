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
