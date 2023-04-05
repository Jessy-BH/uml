<?php

class Team {
  private array $players = [];

  public function addPlayer(Player $player) {
    if(in_array($player, $this->players)) {
      throw new Exception("Error Processing Request", 1);
      return;
    }

    array_push($this->players, $player);
  }

  public function removePlayer(Player $player) {
    $key = array_search($subordinate, $this->subordinates, true);

    if ($key !== false) {
      unset($this->subordinates[$key]);
      return true;
    }

    return false;
  }

  public function getPlayers(): array {
    return $this->players;
  }
}

class Player {
  public function __construct(private string $name) {}

  public function getName(): string {
    return $this->name;
  }
}