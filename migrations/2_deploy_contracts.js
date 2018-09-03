"use strict";

var Posse = artifacts.require("./Posse.sol");

module.exports = function(deployer, network, accounts){

  deployer.deploy(Posse, 2000, "Objeto 2000", "Descrição Objeto 2000");

};
