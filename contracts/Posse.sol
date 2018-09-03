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

  /// indica se o objeto está a venda
  bool public avenda;

  /// Evento lançado quando o objeto é liberado para venda
  event VendaLiberada(uint id, string objeto);

  /// Evento lançado toda vez que o preço for atualizado
  event PrecoAtualizado(uint id, string objeto, uint valor);

  /// Evento lançado toda vez que a posse for vendida para novo dono
  event Comprada(address novo, uint valor);

  /// Construtor do contrato de Posse.
  ///  *ATENÇÃO* Apenas um construtor é permitido.
  constructor(uint objetoID, string objetoNome, string objetoDescricao) public {

    /// Criar uma instância de Objeto
    objeto = Objeto(objetoID, objetoNome, objetoDescricao);

    /// Atribuir o dono atual do objeto utilizando o atributo sender
    dono = msg.sender;

    /// Inicialmente o objeto não está disponível para venda
    avenda = false;
  }

  /// Liberar a venda do objeto
  function liberar() public {
    
    /// Somente o dono do objeto pode liberar a venda
    require(msg.sender == dono, "Somente o dono pode liberar a venda do objeto");

    /// Liberar a venda
    avenda = true;

    /// Lançar evento sobre liberação da venda
    emit VendaLiberada(objeto.id, objeto.nome);
  }

  /// Atribuir o preço de venda do objeto
  function preco(uint _valor) public payable {

    /// Somente o dono do objeto pode atribuir preço
    require(msg.sender == dono, "Somente o dono pode modificar o preço do objeto");

    /// Atribuir novo valor
    valor = _valor;

    /// Lançar evento sobre a ataulização de preço
    emit PrecoAtualizado(objeto.id, objeto.nome, valor);
  }

  /// Comprar a posse do objeto
  function comprar() public payable {

    /// O objeto deve estar com a venda liberada
    require(avenda, "Objeto não está à venda");
    
    /// O valor da compra deve ser idêntico ao valor do objeto
    require(msg.value == valor, "O valor da compra está errado");

    /// Transferir o valor pago ao antigo dono
    dono.transfer(msg.value);

    /// Atribuir novo dono
    dono = msg.sender;

    /// Objeto volta a bloquear sua venda
    avenda = false;

    /// Lançar evento sobre a venda da posse
    emit Comprada(msg.sender, msg.value);
  }
}
