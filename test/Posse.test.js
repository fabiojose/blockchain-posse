var Posse = artifacts.require("Posse");

contract("Posse", function(accounts){

  const OBJETO = {
    id       : 1000,
    nome     : 'Honda Civic',
    descricao: 'Automóvel xxx, chassi xxxx, ano/modelo 2010/2011'
  };

  const valor = 50;

  const dono      = accounts[1];
  const comprador = accounts[2];

  it("dono do objeto deve ser a conta " + dono, function(){
    
    var posse;
    return Posse.new(OBJETO.id, OBJETO.nome, OBJETO.descricao, {from: dono}).then(function(instancia){
      posse = instancia;
      return posse.dono();
    }).then(function(_dono){
      assert.equal(dono, _dono, "O dono do objeto está incorreto");
    });

  });

  it("objeto deve possuir o id " + OBJETO.id, function(){
    
    var posse;
    return Posse.new(OBJETO.id, OBJETO.nome, OBJETO.descricao, {from: dono}).then(function(instancia){
      posse = instancia;
      return posse.objeto();
    }).then(function(_objeto){
      assert.equal(OBJETO.id, _objeto[0].toString(), "O ID do objeto está incorreto");
    });

  });
});