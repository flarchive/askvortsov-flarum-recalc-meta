<?php

/*
 * This file is part of askvortsov/flarum-recalc-meta.
 *
 * Copyright (c) 2020 Alexander Skvortsov.
 *
 * For the full copyright and license information, please view the LICENSE.md
 * file that was distributed with this source code.
 */

namespace Askvortsov\FlarumRecalcMeta;

use Askvortsov\FlarumRecalcMeta\Console\RecalculateDiscussionStats;
use Askvortsov\FlarumRecalcMeta\Console\RecalculateTagStats;
use Askvortsov\FlarumRecalcMeta\Console\RecalculateUserStats;
use Flarum\Extend;

return [
    (new Extend\Console())
        ->command(RecalculateDiscussionStats::class)
        ->command(RecalculateTagStats::class)
        ->command(RecalculateUserStats::class)
];
