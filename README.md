# Badges

More advanced badges for your projects using Travis or Sauce Labs.

[See it in action over at the `script-atomic-onload` project.](https://github.com/exogen/script-atomic-onload)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

## Contents

- [Badges](#badges)
- [Web Service](#web-service)
  - [Endpoints](#endpoints)
    - [`/browsers`](#browsers)
    - [`/sauce/:user`](#sauceuser)
    - [`/size/:source/:path`](#sizesourcepath)
    - [`/travis/:user/:repo`](#travisuserrepo)
    - [`/travis/:user/:repo/sauce/:sauceUser`](#travisuserreposaucesauceuser)
- [Deployment](#deployment)
  - [Heroku](#heroku)
  - [Anywhere else](#anywhere-else)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Badges

**File size for any file on GitHub or npm**

[![Builder package.json size](https://badges.herokuapp.com/size/github/FormidableLabs/builder/master/package.json)](https://github.com/FormidableLabs/builder)

[![Victory size](https://badges.herokuapp.com/size/npm/victory/dist/victory.min.js?gzip=true)](https://www.npmjs.com/package/victory)

**Slice your Travis build matrix by environment**

![TEST_LOADER=jquery](https://badges.herokuapp.com/travis/FormidableLabs/script-atomic-onload?branch=master&env=TEST_LOADER=little-loader&label=TEST_LOADER=little-loader)

![TEST_LOADER=little-loader](https://badges.herokuapp.com/travis/FormidableLabs/script-atomic-onload?branch=master&env=TEST_LOADER=jquery&label=TEST_LOADER=jquery)

**Browser support matrix from Sauce Labs**

[![Browser Status](https://badges.herokuapp.com/sauce/wml-little-loader)](https://saucelabs.com/u/wml-little-loader)

Beautiful _and_ customizable!

- `?labels=none`

  [![Browser Status](https://badges.herokuapp.com/sauce/wml-little-loader?labels=none)](https://saucelabs.com/u/wml-little-loader)

- `?logos=none`

  [![Browser Status](https://badges.herokuapp.com/sauce/wml-little-loader?logos=none)](https://saucelabs.com/u/wml-little-loader)

- `?logos=none&labels=longName`

  [![Browser Status](https://badges.herokuapp.com/sauce/wml-little-loader?logos=none&labels=longName)](https://saucelabs.com/u/wml-little-loader)

Using something other than Sauce Labs? Just construct a URL with results from
your browser tests.

- `browsers?firefox=20,26&iexplore=!8,-9,10`

  ![Browser Status](https://badges.herokuapp.com/browsers?firefox=20,26&iexplore=!8,-9,10)

## Web Service

Deployed at: `https://badges.formidable.com/`

You may also run your own instance using this package. See the **Deployment** section.

### Endpoints

#### `/browsers`

Render browser matrix badge based on support specified in the query
parameters, for cases where your testing is done with a service other than
Sauce Labs (otherwise use the `/sauce` endpoint), or you don’t have CI and
just want to show your intended support.

**Query parameters**

- `android`,
  `firefox`,
  `googlechrome`,
  `iexplore`,
  `ipad`,
  `iphone`,
  `microsoftedge`,
  `opera`,
  `safari`

  A comma-separated list of version numbers that were tested for the given
  browser, e.g. `firefox=20,26`.

  Prefix a version number to indicate status:

  - **`+`** or no prefix: Passed.
  - **`-`**: Failed.
  - **`!`**: Error.

- `logos`,
  `labels`,
  `versionDivider`,
  `style`

  Same as the `/sauce/:user` endpoint below.

#### `/sauce/:user`

Render browser support matrix badge for the Sauce Labs account at `:user`.

**Query parameters**

- `build`

  Build number, it should match the `build` string of one or more jobs. By
  default, try to find the most recent build. The build can be from any CI
  service, not just Travis.

  Sauce Labs’ API doesn’t allow filtering by build, so finding the jobs for a
  build can be a bit of a hassle:

  - If the requested build is not in the first 500 results returned by the
    API, then you should specify `from` and `to` to limit the query window
    to the time span of the build.
  - If no `from` is given, then stop fetching more jobs from the API when a
    different build number is encountered.

  Jobs with a `null` value for `build` are never included.

- `name`

  Name filter, it should match a whitespace separated substring in the `name`
  of one or more jobs. Only jobs matching the filter will be included in the
  result.

- `tag`

  Tag filter, it should match a string in the `tags` array of one or more
  jobs. Only jobs matching the filter will be included in the result.

- `from`

  Start time (Unix epoch) of the window in which to find jobs. Passed along
  to the Sauce Labs API.

- `to`

  End time (Unix epoch) of the window in which to find jobs. Passed along to
  the Sauce Labs API.

- `skip`

  Number of initial jobs to skip. Passed along to the Sauce Labs API.

- `source`

  Data source from which to render results, defaults to `svg`.

  - **api**: Fetch results from the Sauce Labs API. This allows you to specify
    any of the above query parameters for filtering jobs.
  - **svg**: Fetch Sauce Labs’ own browser matrix SVG widget and transform it
    into our slimmer, beautified version. If you aren’t using any of the
    options above, and just want the same results as their own widget would
    render, use this. If you try specifying any of the options above, the
    server will automatically change `source` to `api`. This is probably much
    faster than talking to the API, but it’s a bit more fragile since their
    SVG output could change.

- `logos`

  How to render browser logos, defaults to **inside**.

  - **inside** or **true**: Show logos in the label part of the badge.
  - **none** or **false**: Don’t show logos.

- `labels`

  How to render browser labels, defaults to **shortName**.

  - **shortName** or **true**: Short names, e.g. "Chrome", "FF", "IE".
  - **name**: Medium names, e.g. "Chrome", "Firefox", "Internet Explorer".
  - **longName**: Long names, e.g. "Google Chrome", "Mozilla Firefox",
    "Microsoft Internet Explorer".
  - **sauceName**: Browser identifiers used by Sauce Labs, e.g.
    "googlechrome", "firefox", "iexplore".
  - **none** or **false**: Don’t show labels.

- `versionDivider`

  How to render the divider between browser version numbers, defaults to
  **none**.

  - **none** or **false**: Don’t show a divider.
  - **line** or **true**: Show a subtle beveled line between version numbers.

- `style`

  Badge style, defaults to **flat**. Styles match
  [shields.io](http://shields.io/).

  - **flat**: Round and smooth.
  - **flat-square**: Square and flat.

#### `/size/:source/:path`

Render a file size badge for any file on GitHub or npm.

- `:source` can be `github` or `npm`.
- `:path` can be any valid `raw.githubusercontent.com` or `unpkg.com` path
  (when `:source` is `github` or `npm`, respectively).

**Query parameters**

- `gzip`

  Whether to show the gzip-compressed size, defaults to **false**.

  - **true**: Show compressed size.
  - **false**: Show uncompressed size.

- `label`

  Custom badge label, by default it will be "size" or "size (gzip)".

- `color`

  Color name or value to pass along to [shields.io](http://shields.io/),
  defaults to **brightgreen**. Note that the default may change to **blue** in
  the future, as is somewhat conventional for purely informational,
  non-qualitative badges like this one.

- `style`

  Style to pass along to [shields.io](http://shields.io/).

#### `/travis/:user/:repo`

Render build status badge for the Travis project at `:user/:repo`, counting
only build jobs that match the given `env` filter.

The default endpoint used to communicate with the Travis API is determined by
the server’s `TRAVIS_ENDPOINT` environment variable. You can force the public
`api.travis-ci.com` or `api.travis-ci.org` endpoints by beginning the URL with
`/travis.com` or `/travis.org`, respectively.

**Query parameters**

- `branch`

  Git branch, defaults to **master**.

- `env`

  Environment filter, it should match a `VAR=value` line in the `env`
  section of your build matrix. All jobs in the build matching the filter
  will be aggregated into one final status, similar to how Travis determines
  an overall build status. If no filter is given, all jobs in the build are
  included (even if they are Allowed Failures).

- `label`

  Text label to render on the left side of the badge, defaults to the repo
  name.

- `style`

  Style to pass along to [shields.io](http://shields.io/).

#### `/travis/:user/:repo/sauce/:sauceUser`

Render browser support matrix badge for the Travis project at `:user/:repo`,
getting Sauce Labs results from `:sauceUser` (defaults to `:user`).

You can also use the `/sauce/:user` endpoint, but this way ensures that we
only consider Sauce Labs jobs that match up with the latest Travis build
number for the given `branch`, and also makes the correct jobs easier to find
since Travis provides the time span of the build.

The default endpoint used to communicate with the Travis API is determined by
the server’s `TRAVIS_ENDPOINT` environment variable. You can force the public
`api.travis-ci.com` or `api.travis-ci.org` endpoints by beginning the URL with
`/travis.com` or `/travis.org`, respectively.

**Query parameters**

- `branch`

  Git branch of the Travis build, defaults to **master**.

- `name`,
  `tag`,
  `logos`,
  `labels`,
  `versionDivider`,
  `style`

  Same as the `/sauce/:user` endpoint above.

## Infra

The infrastructure for this project is automated through CI/CD. Pull requests receive comments when they pass CI that give links to both a PR preview environment and to CodePipeline for manually approving production deploys.

The project uses [GitHub Flow](https://guides.github.com/introduction/flow/). After testing an artifact in a PR environment, we deploy that same artifact to production _from_ the branch rather than from merge to `master`. It's important to be aware that an artifact built from `master` post-merge may not be exactly the same as the artifact deployed from the branch.

We use "support tiers" for managing resources shared across PR environments and for emulating multi-account isolation of prod and nonprod via IAM in a single account. These "tiers" are the only manual setup required to launch this project. In the future, we may support, and migrate to, multiple AWS accounts.

### Initial setup

- Set up your AWS credentials. We recommend [aws-vault](https://github.com/99designs/aws-vault).
- Ask @tptee or @ryan-roemer for Fastly, Sauce, and Github credentials.
- Create the nonprod tier with the below command:

```bash
FASTLY_API_TOKEN=redacted \
SAUCE_ACCESS_KEY=redacted \
GITHUB_TOKEN=redacted \
SERVICE_NAME=badges \
TIER=nonprod \
terragrunt apply --terragrunt-working-dir terraform/admin
```

- Create the prod tier by repeating the previous command with `TIER=prod`.
- Open a PR and watch the magic happen!

### Deploying from a pull request (Formidables only)

- Log in to the Formidable AWS account.
- Open a pull request and wait for the CI check to complete.
- When CI completes, it posts a comment with links to the PR environment and the deployment pipeline. Verify your changes in the PR environment, then click the link to the pipeline page.
- On the pipeline page, you'll see an approval step for deploying to production. Click "Review" and then "Approve" in the modal that pops up.
- After the pipeline deploys to production, it posts a link to production in the PR. Verify your changes in prod.
- Merge the pull request!
