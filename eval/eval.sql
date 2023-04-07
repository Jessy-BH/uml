-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 07 avr. 2023 à 13:09
-- Version du serveur : 5.7.36
-- Version de PHP : 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `isco`
--

-- --------------------------------------------------------

--
-- Structure de la table `affaires`
--

DROP TABLE IF EXISTS `affaires`;
CREATE TABLE IF NOT EXISTS `affaires` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `raison_sociale` varchar(30) NOT NULL,
  `siret` int(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `devis`
--

DROP TABLE IF EXISTS `devis`;
CREATE TABLE IF NOT EXISTS `devis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `statut` enum('creation','vie de solution','En-cours signature','refus signature','signe','commande') NOT NULL DEFAULT 'creation',
  `created_at` date NOT NULL,
  `offer` varchar(30) NOT NULL,
  `id_affaire` int(11) NOT NULL,
  `id_itc` int(11) NOT NULL,
  `id_client` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_affaire` (`id_affaire`),
  KEY `id_itc` (`id_itc`),
  KEY `id_client` (`id_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `devis_prestations`
--

DROP TABLE IF EXISTS `devis_prestations`;
CREATE TABLE IF NOT EXISTS `devis_prestations` (
  `id_devis` int(11) NOT NULL,
  `id_prestation` int(11) NOT NULL,
  KEY `id_devis` (`id_devis`),
  KEY `id_prestation` (`id_prestation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `devis_products`
--

DROP TABLE IF EXISTS `devis_products`;
CREATE TABLE IF NOT EXISTS `devis_products` (
  `id_devis` int(11) NOT NULL,
  `id_product` int(11) NOT NULL,
  KEY `id_devis` (`id_devis`),
  KEY `id_product` (`id_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `interlocuteurs`
--

DROP TABLE IF EXISTS `interlocuteurs`;
CREATE TABLE IF NOT EXISTS `interlocuteurs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `civilite` varchar(30) NOT NULL,
  `name` varchar(30) NOT NULL,
  `mail` varchar(30) NOT NULL,
  `tel_fixe` varchar(30) NOT NULL,
  `tel_mobile` varchar(30) NOT NULL,
  `id_client` int(8) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_client` (`id_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `itcs`
--

DROP TABLE IF EXISTS `itcs`;
CREATE TABLE IF NOT EXISTS `itcs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_responsable` int(11) NOT NULL,
  `firstname` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_responsable` (`id_responsable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `prestations`
--

DROP TABLE IF EXISTS `prestations`;
CREATE TABLE IF NOT EXISTS `prestations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `intitule` varchar(30) NOT NULL,
  `ref_catalogue` int(30) NOT NULL,
  `code_ean` int(30) NOT NULL,
  `ref_constructeur` varchar(30) NOT NULL,
  `prestataire` varchar(30) NOT NULL,
  `coef` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `intitule` varchar(255) NOT NULL,
  `ref_catalogue` int(30) NOT NULL,
  `code_ean` int(30) NOT NULL,
  `ref_constructeur` varchar(30) NOT NULL,
  `fournisseur` varchar(30) NOT NULL,
  `coef` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `responsables`
--

DROP TABLE IF EXISTS `responsables`;
CREATE TABLE IF NOT EXISTS `responsables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `mail` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `affaires`
--
ALTER TABLE `affaires`
  ADD CONSTRAINT `affaires_ibfk_1` FOREIGN KEY (`id`) REFERENCES `devis` (`id_affaire`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `clients`
--
ALTER TABLE `clients`
  ADD CONSTRAINT `clients_ibfk_1` FOREIGN KEY (`id`) REFERENCES `devis` (`id_client`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `clients_ibfk_2` FOREIGN KEY (`id`) REFERENCES `interlocuteurs` (`id_client`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `devis`
--
ALTER TABLE `devis`
  ADD CONSTRAINT `devis_ibfk_1` FOREIGN KEY (`id`) REFERENCES `devis_prestations` (`id_devis`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `devis_ibfk_2` FOREIGN KEY (`id`) REFERENCES `devis_products` (`id_devis`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `itcs`
--
ALTER TABLE `itcs`
  ADD CONSTRAINT `itcs_ibfk_1` FOREIGN KEY (`id`) REFERENCES `devis` (`id_itc`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `prestations`
--
ALTER TABLE `prestations`
  ADD CONSTRAINT `prestations_ibfk_1` FOREIGN KEY (`id`) REFERENCES `devis_prestations` (`id_prestation`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`id`) REFERENCES `devis_products` (`id_product`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `responsables`
--
ALTER TABLE `responsables`
  ADD CONSTRAINT `responsables_ibfk_1` FOREIGN KEY (`id`) REFERENCES `itcs` (`id_responsable`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
