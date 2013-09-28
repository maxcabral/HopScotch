Lackey
=====
An Open Source backend/API generation service, geared towards Hackathons and other programming competitions.

This is free software. You can redistribute it and/or modify
it under the same terms as Perl itself (GPL or Artistic Licenses).

Goals
=====
Lackey is an attempt to greatly reduce the amount of repetitive work that has to be done to create a working project that needs to connect to a Database through an API.
Most mobile devices can not connect directly to a database, nor can AJAX Frontend frameworks. This ultimately leads to one or two developers spending a day (or more) creating an API server.

This project aims to alleviate the following headaches:
- Inability to connect to existing backend/platform as a services solutions due to poor/restricted internet connections.
- The hassle of dealing with MySQL security features on a DHCP network (Grants, Server IP, etc).
- The time spent creating a basic API.
- Time spent determining what fields are necessary (by providing "canned" schemas/code for things like authentication, user profiles, shopping cart systems, etc)
- The need to update code to deal with schema changes.
- The inability to change the behavior of a closed backend/platform as a service.
