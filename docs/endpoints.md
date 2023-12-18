# openapi endpoints

most of the API endpoint docs for csharp jellyfin are [auto
generated](https://api.jellyfin.org/openapi/api.html) and lack meaningful documentation.

This documents them as they are implemented.

## Activity Log

## API Key

## Artists

## Audio

## Branding

## Channels

## Client Log

## Collection

## Configuration

## Dashboard

## Devices

## DisplayPreferences

## DLNA

## Environment

## Filter

## Genres

## HLS

## Image

## Image By Name

## Instant Mix

## Item

## Library

## Live TV

## Localization

## Media Info

## Movies

## Music Genres

## Notifications

## Package

## Persons

## Playlists

## Play State

## Plugins

## Quick Connect

## Remote Image

## Scheduled Tasks

## Search

## Session

## Startup

## Studios

## Subtitle

## Suggestions

## Sync Play

## System

### GET /System/Info/Public

the first API call the webui calls. returns a JSON object.

```
{
"LocalAddress": "string",
"ServerName": "string",
"Version": "string",
"ProductName": "string",
"OperatingSystem": "string",
"Id": "string",
"StartupWizardCompleted": true
}
```

## Time Sync

## TMDB

## Trialers

## TV Shows

## Universal Audio

## User

### GET /Users

returns a JSON encoded list of users to log in with.

query parameters:

- isHidden (boolean)

if set to true the list will include users who are hidden from the login page, but only if
authorization was provided for a user which is able to see those accounts.

- isDisabled (boolean)

if set to true the list will include users who's logins have been disabled.

each user is a JSON object with the following members:

`Name`

`ServerId`

`ServerName`

`Id`

`PrimaryImageTag`

`HasPassword`

`HasConfiguredPassword`

`HasConfigredEasyPassword`

`EnableAutoLogin`

`LastLoginDate`

`LastActivityDate`

`Configuration`

`Policy`

`PrimaryImageAspectRatio`

## User Library

## User Views

## Video Attachments

## Videos
