unit unClasses;
// nestaq unit estão implementadas as classes de dados da aplicação
// Produtos, clientes, pedidos_dados_gerais e pedidos_produtos modeladas na base de dados


interface

uses
Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, unDM;

// classe para tabela de produtos
type
   Tproduto = class(tobject)
      Codigo      :   integer;
      Descricao   :   string;
      PrecoVenda  :   single;

      function getProduto(icod : integer) : boolean;
end;

// classe para tabela de clientes
type
   Tcliente = class(tobject)
      Codigo      :   integer;
      Nome        :   string;
      Cidade      :   string;
      UF          :   string;


      lista       :   Tstringlist;
      constructor create;
      destructor destroy;

end;


// classe para tabela de pedidos_dados_gerais
type
   Tpedidos = class(tobject)

      Numero      :   integer;
      Data        :   Tdate;
      Cliente     :   integer;
      ValorTotal  :   single;

      function inserir : boolean;

end;

// classe pedidos_produtos
type
    Tpedido_produtos = class(tobject)
      numero : integer;
      produto : integer;
      quantidade : integer;
      valor_unitario : single;
      valor_total : ssingle;

      function inserir : boolean;
    end;


implementation




// Métodos da classe cliente
constructor Tcliente.create;
begin
   self.lista := Tstringlist.Create;
end;

destructor Tcliente.destroy;
begin
  self.lista.Destroy;
end;


// Métodos classe produto
function Tproduto.getProduto(icod: integer): Boolean;
begin

end;



// Métods classe pedidos dados gerais
function Tpedidos.inserir: Boolean;
begin
  //
end;


// método classe pedidos_produtos
function Tpedido_produtos.inserir: Boolean;
begin

end;

end.
