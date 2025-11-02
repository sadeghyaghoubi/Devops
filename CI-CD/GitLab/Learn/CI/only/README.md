```
deploy-job:
  stage: deploy
  script:
    - echo "Deploying application..."
  only:
    - main

```

This job will only run when you push changes to the main branch.

If you push to another branch (like dev or feature-x), it will be skipped.
