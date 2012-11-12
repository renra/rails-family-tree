Family Tree Tracking Application
================================

This application is for now built with the easiest possible user architecture. There are two types of users - admin and viewer - each has their own password. So inviting someone to view the family tree means sending him the viewer login and password common for all users. Only the admin(s) has the right to edit the data.

Problems
========

- What to validate? I will need to distinguish two(or more) people who might have the same name. I want to do that by their date of birth and possibly place of birth, the date primarily. But sometimes you might not be sure about when one of your ancestors was born. In that case fill in the orientation date - a date telling when the person could have been born. It's just a guess to help place the person in the timeline.
