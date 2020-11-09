<?php

/**
 * Configuration for database connection
 *
 */

$host       = "192.168.14.100";
$username   = "suporte";
$password   = "suporte";
$dbname     = "test";
$dsn        = "mysql:host=$host;dbname=$dbname";
$options    = array(
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
              );
