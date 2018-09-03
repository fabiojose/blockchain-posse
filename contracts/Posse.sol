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
  Objeto public objeto;

  /// dono do objeto
  address public dono;

  /// valor do objeto
  uint public valor;

  /// Evento lançado toda vez que o preço for atualizado
  event PrecoAtualizado(uint valor);

  /// Evento lançado toda vez que a posse for vendida para novo dono
  event Comprada(address novo, uint valor);

  /// Construtor do contrato de Posse.
  ///  *ATENÇÃO* Apenas um construtor é permitido.
  constructor(uint objetoID, string objetoNome, string objetoDescricao) public {

    /// Criar uma instância de Objeto
    objeto = Objeto(objetoID, objetoNome, objetoDescricao);

    /// Atribuir o dono atual do objeto utilizando o atributo sender
    dono = msg.sender;
  }

  /// Atribuir o preço de venda do objeto
  function preco(uint _valor) public payable {

    /// Somente o dono do objeto pode atribuir preço
    require(msg.sender == dono, "Somente o dono pode modificar o preço do objeto");

    /// Atribuir novo valor
    valor = _valor;

    /// Lançar envento a ataulização de preço
    emit PrecoAtualizado(valor);
  }

  /// Comprar a posse do objeto
  function comprar() public payable {
    
    /// O valor da compra deve ser idêntico ao valor do objeto
    require(msg.value == valor, "O valor da compra está errado");

    /// Atribuir novo dono
    dono = msg.sender;

    /// Lançar evento sobre a venda da posse
    emit Comprada(msg.sender, msg.value);
  }
}
