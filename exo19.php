<?php

class Technician {
  private array $subordinates = [];
  private string $superior = null;

  public function __construct() {}

  public function addSubordinate(Technician $subordinate) {
    if ($subordinate, $this->$subordinates) {
      throw new Exception("Error Processing Request", 1);
      return;
    }

    array_push($this->$subordinates, $subordinate);
  }

  public function removeSubordinate(Technician $subordinate): bool {
    $key = array_search($subordinate, $this->subordinates, true);

    if ($key !== false) {
      unset($this->subordinates[$key]);
      return true;
    }

    return false;
  }

  public function getSubordinates(): array {
    return $this->$subordinates;
  }
}