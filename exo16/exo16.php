<?php

class Waiter {
  private array $tables = [];
  public function __construct(private string $name) {}

  public function addTable(Table $table) {
    if (count($this->tables) > 3) {
      throw new Exception("Error Processing Request");
      return;
    }

    array_push($this->tables, $table);
  }

  public function removeTable(Table $table) {
    if (count($this->tables) === 0) {
      throw new Exception("Error Processing Request");
      return;
    }

    $key = array_search($table, $this->tables, true);
    unset($this->tables[$key]);
  }
}

class Table {
  public function __construct(private int $id) {}

  public function getIt(): int {
    return $this->id;
  }
}

$t1 = new Table(1);
$t2 = new Table(2);
$t3 = new Table(3);
$t4 = new Table(4);
$t5 = new Table(5);

$jean = new Waiter('Jean');

$jean->addTable($t1);
$jean->addTable($t2);
$jean->addTable($t3);
$jean->addTable($t4);

var_dump($jean);

// Error

$jean->addTable($t5);

var_dump($jean);