<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
class TestDBConnection extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
        protected $signature = 'db:test';

    /**
     * The console command description.
     *
     * @var string
     */
      protected $description = 'Test database connection';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        //
        try {
            DB::connection()->getPdo();
            $this->info("Conexión exitosa a la base de datos: " . DB::connection()->getDatabaseName());
        } catch (\Exception $e) {
            $this->error("Error al conectar a la base de datos: " . $e->getMessage());
        }
    }
}
