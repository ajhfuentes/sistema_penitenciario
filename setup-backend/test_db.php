<?php

require 'vendor/autoload.php';

use Illuminate\Database\Capsule\Manager as Capsule;
use Dotenv\Dotenv;

$dotenv = Dotenv::createImmutable(__DIR__);
$dotenv->load();

$capsule = new Capsule;
$capsule->addConnection([
    'driver' => 'pgsql',
    'host' => $_ENV['DB_HOST'],
    'port' => $_ENV['DB_PORT'],
    'database' => $_ENV['DB_DATABASE'],
    'username' => $_ENV['DB_USERNAME'],
    'password' => $_ENV['DB_PASSWORD'],
    'charset' => 'utf8',
    'prefix' => '',
    'schema' => 'public',
]);

$capsule->setAsGlobal();
$capsule->bootEloquent();

// Probar conexión
try {
    $result = Capsule::select('SELECT COUNT(*) as total FROM reclusos');
    echo "✅ Conexión exitosa!\n";
    echo "Total reclusos: " . $result[0]->total . "\n";
    
    $users = Capsule::select('SELECT id, name, email, rol FROM users');
    echo "\nUsuarios registrados:\n";
    foreach ($users as $user) {
        echo "  - {$user->name} ({$user->email}) - Rol: {$user->rol}\n";
    }
} catch (Exception $e) {
    echo "❌ Error: " . $e->getMessage() . "\n";
}
