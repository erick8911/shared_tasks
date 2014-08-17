# SharedTasks

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'shared_tasks'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shared_tasks

## Usage

Generate migration and shared_tasks folder

    $ rails g shared_tasks:install

Create a new task

    $ rails g shared_tasks:shared_task new_task_name

Run tasks

    $ rake shared_task:tasks

Run single task

    $ rake shared_task:task[file_name, task_name]




## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
