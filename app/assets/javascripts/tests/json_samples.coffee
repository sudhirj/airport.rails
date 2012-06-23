exports.json_samples = {
    event: {
        "org": {
          "gravatar_id": "f96170794b49cf5cc60c5efc69853e59",
          "url": "https://api.github.com/orgs/",
          "id": 460581,
          "login": "runway7"
        },
        "type": "CreateEvent",
        "payload": {
          "master_branch": "master",
          "ref": "gh-pages",
          "ref_type": "branch",
          "description": "The Hacker's Blogging Engine - serves markdown posts hosted on GitHub from Google App Engine."
        },
        "public": true,
        "created_at": "2012-04-03T08:30:27Z",
        "repo": {
          "url": "https://api.github.com/repos/runway7/beacon",
          "id": 2865563,
          "name": "runway7/beacon"
        },
        "actor": {
          "gravatar_id": "4813b578ef6e0ca5ba25a77f57fdb5f1",
          "url": "https://api.github.com/users/sudhirj",
          "id": 21678,
          "login": "sudhirj"
        },
        "id": "1537160551"
    }

    user: {
        "following": 3,
        "type": "User",
        "avatar_url": "https://secure.gravatar.com/avatar/4813b578ef6e0ca5ba25a77f57fdb5f1?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
        "login": "sudhirj",
        "public_repos": 14,
        "blog": "http://www.sudhirjonathan.com/",
        "location": "Chennai, India",
        "url": "https://api.github.com/users/sudhirj",
        "html_url": "https://github.com/sudhirj",
        "company": "http://www.runway7.net",
        "created_at": "2008-08-23T09:47:24Z",
        "email": "sudhir.j@gmail.com",
        "name": "Sudhir Jonathan",
        "hireable": true,
        "gravatar_id": "4813b578ef6e0ca5ba25a77f57fdb5f1",
        "id": 21678,
        "public_gists": 9,
        "followers": 10,
        "bio": ""
    }

    event_without_org: {
        "org": {
          "url": "https://api.github.com/orgs/"
        },
        "type": "IssueCommentEvent",
        "payload": {
          "comment": {
            "created_at": "2012-04-06T15:58:44Z",
            "body": "you should still be able to do `var hbs = require('handlebars'); hbs.stuffhHere()`, require() caches",
            "updated_at": "2012-04-06T15:58:44Z",
            "url": "https://api.github.com/repos/visionmedia/consolidate.js/issues/comments/4997628",
            "id": 4997628,
            "user": {
              "avatar_url": "https://secure.gravatar.com/avatar/f1e3ab214a976a39cfd713bc93deb10f?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
              "gravatar_id": "f1e3ab214a976a39cfd713bc93deb10f",
              "url": "https://api.github.com/users/visionmedia",
              "id": 25254,
              "login": "visionmedia"
            }
          },
          "action": "created",
          "issue": {
            "number": 18,
            "created_at": "2012-04-06T05:40:33Z",
            "pull_request": {
              "diff_url": null,
              "patch_url": null,
              "html_url": null
            },
            "body": "Hi!\r\n\r\nI'm using Handlebars, and I'd like to use partials with it.\r\n\r\nBut to register partials, I must use that kind of code:\r\n\r\n```\r\nHandlebars.registerPartial(\"person\", \"<strong>hello</strong>\");\r\n```\r\n\r\nFor doing this, I need the engine's instance which after checking your code isn't returned in any way.\r\n\r\nDo you have any idea of how I could use it, if there is no way do you think you could make that change? (I also could if you want me to)\r\n\r\nThanks a lot!",
            "title": "Using engine's instance for things such as partials",
            "comments": 3,
            "updated_at": "2012-04-06T15:58:44Z",
            "url": "https://api.github.com/repos/visionmedia/consolidate.js/issues/18",
            "id": 4000335,
            "assignee": null,
            "milestone": null,
            "closed_at": null,
            "user": {
              "avatar_url": "https://secure.gravatar.com/avatar/34dba9091c0a078c3571f776db7d10ce?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
              "gravatar_id": "34dba9091c0a078c3571f776db7d10ce",
              "url": "https://api.github.com/users/tbergeron",
              "id": 70296,
              "login": "tbergeron"
            },
            "labels": [

            ],
            "html_url": "https://github.com/visionmedia/consolidate.js/issues/18",
            "state": "open"
          }
        },
        "public": true,
        "created_at": "2012-04-06T15:58:44Z",
        "repo": {
          "url": "https://api.github.com/repos/visionmedia/consolidate.js",
          "id": 2906168,
          "name": "visionmedia/consolidate.js"
        },
        "actor": {
          "gravatar_id": "f1e3ab214a976a39cfd713bc93deb10f",
          "url": "https://api.github.com/users/visionmedia",
          "id": 25254,
          "login": "visionmedia"
        },
        "id": "1538635440"
    }

    issue: {
        "closed_at": null,
        "created_at": "2012-05-09T14:26:34Z",
        "milestone": null,
        "url": "https://api.github.com/repos/sudhirj/metroman/issues/1",
        "pull_request": {
          "diff_url": null,
          "html_url": null,
          "patch_url": null
        },
        "updated_at": "2012-05-09T14:26:34Z",
        "comments": 0,
        "html_url": "https://github.com/sudhirj/metroman/issues/1",
        "number": 1,
        "state": "open",
        "user": {
          "login": "sudhirj",
          "url": "https://api.github.com/users/sudhirj",
          "avatar_url": "https://secure.gravatar.com/avatar/4813b578ef6e0ca5ba25a77f57fdb5f1?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
          "gravatar_id": "4813b578ef6e0ca5ba25a77f57fdb5f1",
          "id": 21678
        },
        "assignee": null,
        "body": "",
        "id": 4493466,
        "labels": [
          {
            "url": "https://api.github.com/repos/sudhirj/metroman/labels/feature",
            "color": "02e10c",
            "name": "feature"
          }
        ],
        "title": "Add to NPM"
    }

}