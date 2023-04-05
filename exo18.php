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
  }

  public function getTables(): array {
    return $this->tables;
  }
}

class Table {
  public function __construct(private int $id) {}

  public function getId(): int {
    return $this->id;
  }
}