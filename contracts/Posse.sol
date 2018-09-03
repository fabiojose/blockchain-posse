pragma solidity ^0.4.18;

contract Posse {
  
  /// struct para representar o objeto do contrato de posse
  struct Objeto {
    uint id;
    string nome;
    string descricao;
  }

  /// instância do objeto do contrato de posse
  /// ex: casa, carro, terreno, bicicleta, barco, ...
  Objeto objeto;

  /// valor do objeto
  uint valor;

  /// Construtor do contrato de Posse.
  ///  apenas um construtor é permitido.
  constructor(uint objetoID, string objetoNome, string objetoDescricao) public payable {
    objeto = Objeto(objetoID, objetoNome, objetoDescricao);
  }

  /// Configurar o preço de venda do objeto
  function preco(uint _valor) public payable {
    valor = _valor;
  }
}
