#! /bin/bash

echo '
[
  {
    "name": "Example 1",
    "url": "https://google.com",
    "sec": 10
  },
  {
    "name": "Example 2",
    "url": "https://jira.com",
    "sec": 10
  }
]
' > $BOOT_DIR/$REPO_NAME/tasks.json

echo '
{
  "login": "user-login",
  "password": "user-password"
}
' > $BOOT_DIR/$REPO_NAME/jira-config.json
