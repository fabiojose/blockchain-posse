var Posse = artifacts.require("Posse");

contract("Posse", function(accounts){

  const OBJETO = {
    id       : 1000,
    nome     : 'Honda Civic',
    descricao: 'Automóvel xxx, chassi xxxx, ano/modelo 2010/2011'
  };

  // Valor em ETH
  const valor = 50;

  // Valor em WEI
  const valor_wei = web3.toWei(valor, "ether");

  const dono      = accounts[1];
  const comprador = accounts[2];
  const doacao    = accounts[3];

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

  it("objeto deve possuir o preço igual a " + valor + " ETH", function(){
    
    var posse;
    return Posse.new(OBJETO.id, OBJETO.nome, OBJETO.descricao, {from: dono}).then(function(instancia){
      posse = instancia;
    }).then(function(){
      posse.preco(valor_wei, {from: dono});
      return posse.valor();
    }).then(function(_valor){
      assert.equal(valor_wei.toString(), _valor.toString(), "O valor do objeto está incorreto");
    });

  });

  it("após comprar, o novo dono deverá ser a conta " + comprador, function(){
    
    var posse;
    return Posse.new(OBJETO.id, OBJETO.nome, OBJETO.descricao, {from: dono}).then(function(instancia){
      posse = instancia;
    }).then(function(){
      return posse.liberar({from: dono});
    }).then(function(){
      return posse.preco(valor_wei, {from: dono});
    }).then(function(){
      return posse.comprar({from: comprador, value: valor_wei});
    }).then(function(){
      return posse.dono();
    }).then(function(_dono){
      assert.equal(comprador, _dono, "O dono do objeto está incorreto");
    });

  });

  it("após doar, o novo dono deverá ser a conta " + doacao, function(){
    
    var posse;
    return Posse.new(OBJETO.id, OBJETO.nome, OBJETO.descricao, {from: dono}).then(function(instancia){
      posse = instancia;
    }).then(function(){
      return posse.liberar({from: dono});
    }).then(function(){
      return posse.preco(valor_wei, {from: dono});
    }).then(function(){
      return posse.doar(doacao, {from: dono});
    }).then(function(){
      return posse.dono();
    }).then(function(_dono){
      assert.equal(_dono, doacao, "O dono do objeto está incorreto");
    });

  });

});
