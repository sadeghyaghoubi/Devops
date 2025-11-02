```
test-job:
  stage: test
  script:
    - pytest
  except:
    - main

```
Run tests on all branches except main.
