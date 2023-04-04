<?php

class Technician {

    private string $name;
    private ?Vehicule $vehicule = null;

    public function __construct(string $name) {
        $this->name = $name;
    }

    public function setVehicule(?Vehicule $vehicule) : Technician {

        if($this->vehicule !== null) {
            $this->vehicule->delTechnician($this);
        }

        // Pour automatiser la mise à jour des liens bidirectionnels: 
        // Si le technicien est déjà lié à un véhicule, on le délie
        if($vehicule !== null) {
            $vehicule->addTechnician($this);
        }

        $this->vehicule = $vehicule;
        return $this;
    }

    public function getVehicle() : ?Vehicule {
        return $this->vehicle;
    }
}


class Vehicule {

    private string $registerNumber;
    
    /**
     * @var array Les technicians
     */
    private array $technicians = [];

    public function __construct(string $registerNumber) {
        $this->registerNumber = $registerNumber;
    }
    
    /**
     * Add a technician
     */
    public function addTechnician(Technician $technician): Vehicule
    {
        array_push($this->technicians, $technician);
        return $this;
    }

    /**
     * Remove a technician
     */
    public function delTechnician(Technician $technician): Vehicule
    {
        $key = array_search($technician, $this->technicians);
        unset($this->technicians[$key]);
        return $this;
    }

    public function getTechnicians() : array {
        return $this->technicians;
    }
}



$vA = new Vehicule('AA-666-AA');
$vB = new Vehicule('BB-666-BB');

$paul = new Technician('Paul');
$juliette = new Technician('Juliette');
$jalila = new Technician('Jalila');

$paul->setVehicule($vA);
$juliette->setVehicule($vA);
$jalila->setVehicule($vB);
var_dump($vA);
var_dump($vB);
$paul->setVehicule($vB);

$vA->delTechnician($paul);
var_dump($vA);
