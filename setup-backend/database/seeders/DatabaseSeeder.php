<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Unificación: Laravel ejecutará este orden secuencialmente
        $this->call([
            DatabaseTestSeeder::class,
            // Puedes agregar aquí otros seeders si los separas a futuro
        ]);
    }
}

