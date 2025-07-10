# TaskFlow: Collaborative Task Management

## Quickstart

The procedure is quite straightforward:
* `docker-compose build && docker-compose up -d`
* wait 5-7 minutes
* open http://localhost:8080 in your browser
* login as a test user (see below) or register a new one

I recommend you to open Tasks tab then read discussions (notes) at tasks already in progress or done.

## Test users

* Michael Tikhonenko <ardolynk75@gmail.com>
* Charley Shurrocks <cshurrocks0@pinterest.com>
* Natalya Chang <nchang0@sciencedirect.com>
* Jolee Josowitz <jjosowitz1@cpanel.net>
* Annecorinne Ricardot <aricardot2@example.com>
* Mikkel Scarce <mscarce3@china.com.cn>
* Brian Raper <braper4@1688.com>

Each of them has the same password `test123`.

## Permissions

Each user can:

* Create a new project becoming its owner
* Browse all projects and tasks
* Comment any task with a note

Project owner can:

* Update or delete a project
* Add, update and remove project tasks
* Assign any user to the task

An assignee has a permission to change task status.

Warning: deleting tasks now cause the cascade removal of notes, deleting projects erases tasks along with their notes.

## TODOs

* Archiving data instead of irreversible removal
* Better styling
* Simple audit log (who did what)
* Charts/analytics (e.g. task status breakdown)
* ...and many more - it's now rather the academic project than the product for real life
