# Note
to avoid conflict always use `git pull --rebase origin development` and `rubocop --auto-correct` before pushing and pull request


# Enviroment
make .env on root of project
use `postgresql` as main database
```
DB_NAME={your_db_name}
DB_USER={your_db_user}
DB_PASSWORD={your_db_paswsword}
DB_HOST={your_db_host}
GCS_PROJECT_ID="gcs-project-id"
GCS_BUCKET_NAME="bucket-name"
GCS_CREDENTIALS="path to credentials file"
RAILS_SERVE_STATIC_FILES=true
DEBUGGING=false
```
_`nb always check wiki for .env update`_

# Instalation

```
use rvm for dinamic ruby version
bundle install
rake db:create
rake db:migrate
rake db:seed
```

Have fun!
# Opsional
```
rails generate doorkeeper:migration
```