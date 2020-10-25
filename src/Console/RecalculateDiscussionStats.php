<?php

/*
 * This file is part of askvortsov/flarum-categories
 *
 *  Copyright (c) 2020 Alexander Skvortsov.
 *
 *  For detailed copyright and license information, please view the
 *  LICENSE file that was distributed with this source code.
 */

namespace Askvortsov\FlarumRecalcMeta\Console;

use Flarum\Console\AbstractCommand;
use Illuminate\Contracts\Container\Container;
use Illuminate\Database\ConnectionInterface;

class RecalculateDiscussionStats extends AbstractCommand
{
    protected $container;
    protected $database;

    public function __construct(Container $container, ConnectionInterface $database)
    {
        parent::__construct();
        $this->container = $container;
        $this->database = $database;
    }

    /**
     * {@inheritdoc}
     */
    protected function configure()
    {
        $this
            ->setName('recalculate_stats:discussions')
            ->setDescription('Recalculate first/last post, comment count for all discussions');
    }

    /**
     * {@inheritdoc}
     */
    protected function fire()
    {
        $this->info('Starting...');

        $config = $this->container->make('flarum.config');

        $prefix = $config['database']['prefix'];

        $query = file_get_contents(dirname(__FILE__, 3). '/sql/update_discussion_stats.sql');

        $query = str_replace('[PREFIX]', $prefix, $query);

        $result = $this->database->getPdo()->exec($query);

        echo json_encode($result);
    }
}
