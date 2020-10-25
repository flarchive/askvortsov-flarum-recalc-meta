# Flarum Recalculate Metadata

![License](https://img.shields.io/badge/license-MIT-blue.svg) [![Latest Stable Version](https://img.shields.io/packagist/v/askvortsov/flarum-recalc-meta.svg)](https://packagist.org/packages/askvortsov/flarum-recalc-meta)

A [Flarum](http://flarum.org) extension. Sometimes, metadata counts get out of sync. This extension adds 3 commands to update them:

- `php flarum recalculate_stats:discussions` recalculates first post, last post, comment count, and participant count metadata for each discussion.
- `php flarum recalculate_stats:tags` discussion count, comment count, and last posted discussion for each tag. This should ONLY be used if the askvortsov/categories discussion is installed.
- `php flarum recalculate_stats:users` recalculates user discussion and post count for each user.


Please note that these commands can be **very slow** on large databases. This should not be used on extremely large databases.

### Installation

Install manually with composer:

```sh
composer require askvortsov/flarum-recalc-meta
```

### Updating

```sh
composer update askvortsov/flarum-recalc-meta
```

### Links

- [Packagist](https://packagist.org/packages/askvortsov/flarum-recalc-meta)
