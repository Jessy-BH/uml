<?php

class Waiter {
  private array $tables = [];
  public function __construct(private string $name) {}

  public function addTable(Table $table) {
    if (count($this->tables) >= 4) {
      throw new Exception("Error Processing Request");
      return;
    }

    array_push($this->tables, $table);
    $table->addWaiter($this);
  }

  public function getTables(): array {
    return $this->tables;
  }
}

class Table {
  private array $waiters = [];
  public function __construct(private int $id) {}

  public function addWaiter(Waiter $waiter) {
    array_push($this->waiters, $waiter);
  }

  public function getId(): int {
    return $this->id;
  }

  public function getTables(): array {
    return $this->tables;
  }
}

$t1 = new Table(1);
$t2 = new Table(2);
$t3 = new Table(3);
$t4 = new Table(4);
$t5 = new Table(5);

$jean = new Waiter('Jean');
$luc = new Waiter('Luc');

$jean->addTable($t1);
$jean->addTable($t2);
$luc->addTable($t3);
$luc->addTable($t4);
$luc->addTable($t5);

var_dump($jean->getTables());
var_dump($luc->getTables());