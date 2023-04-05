<?php

class Vehicule {

    public function __construct(private array $technicians = []) {
    }



    public function addTechnician(Technician $technician) :  bool  {

        if(!in_array($technician, $this->technicians, true)) {
            $this->technicians[] = $technician;
            return true;
        }
        return false;
    }

    public function removeTechnician(Technician $technician) : bool {

        $key = array_search($technician, $this->technicians, true);
        if($key !== false) {
            unset($this->technicians[$key]);
            return true;
        }
        return false;
    }

    public function setTechnicians(array $technicians) : self {

    foreach($technicians as $technician) {
        $this->addTechnician($technician);
        }
        return $this;
    }

    public function getTechnicians() : array {

        return $this->technicians;
    }
}




class Technician {

    public function __construct(private array $vehicules = []) {
        $this->setVehicules($vehicules);
    }

    public function addVehicule(Vehicule $vehicule) : bool {

        if(!in_array($vehicule, $this->vehicules, true)) {
            // Ajout d'un vehicule au technicien
            $this->vehicules[] = $vehicule;
            // Ajout du technicien au vehicule
            $vehicule->addTechnician($this);
            return true;
        }
        return false;
    }

    public function removeVehicule(Vehicule $vehicule) : bool {

        $key = array_search($vehicule, $this->vehicules, true);
        if($key !== false) {
            // Suppression du vehicule du technicien
            unset($this->vehicules[$key]);
            // Suppression du technicien du vehicule
            $vehicule->removeTechnician($this);
            return true;
        }
        return false;
    }

    public function setVehicules(array $vehicules) : self {

        // mise a jour des items de la collection avant qu'elle ne soit écrasée par la nouvelle collection
        foreach($this->vehicules as $vehicule) {
            $vehicule->removeTechnician($this);
        }

        // Vider la collection en cours pour la remplacer par la nouvelle collection
        $this->vehicules = [];

        // écrase la collection en cours avec la nouvelle collection
        foreach($vehicules as $vehicule) {
            $this->addVehicule($vehicule);
        }

        
        return $this;
    }

    public function getVehicules() : array {

        return $this->vehicules;
    }
}