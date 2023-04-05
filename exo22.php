<?php

class Vehicle {
  public function __construct(
    private string $name,
    private string $engine = null,
    private string $chassis = null
  ) {}

  public function setEngine(Engine $engine) {
    if($engine !== null) {
      $this->engine = $engine;
    }
    return $this;
  }
  public function setChassis(Chassis $chassis) {
    if($chassis !== null) {
      $this->chassis = $chassis;
    }
    return $this;
  }
}

class Chassis {
  public function __construct(private string $name) {}

  public function getChassis() {
    return $this->name;
  }
}

class Engine {
  public function __construct(private string $name) {}

  public function getEngine() {
    return $this->name;
  }
}