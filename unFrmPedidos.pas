unit unFrmPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.StdCtrls, Data.DB, unDM, Vcl.DBCtrls, Vcl.Buttons , unDM,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client ;

type
  TFrmPedidos = class(TForm)
    acoes: TActionList;
    pnHead: TPanel;
    pnFoot: TPanel;
    pnCenter: TPanel;
    pnPedidoheader: TPanel;
    ConfigurarAmbiente: TAction;
    lbTitulo: TLabel;
    edcodigoproduto: TEdit;
    lbcodproduto: TLabel;
    edquantidade: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edvalor: TEdit;
    pnCliente: TPanel;
    lbClientePedido: TLabel;
    cbCliente: TComboBox;
    btIncluiProdutoPedido: TBitBtn;
    BitBtn1: TBitBtn;
    grPedido: TStringGrid;
    Fillcombocliente: TAction;
    conexao: TFDConnection;
    TR: TFDTransaction;
    QryCliente: TFDQuery;
    LimparCamposPedido: TAction;
    IncluiProdutoGrid: TAction;
    ValidarCamposProduto: TAction;
    btSair: TBitBtn;
    Encerrar: TAction;
    pnRodapeGrid: TPanel;
    Label4: TLabel;
    lbTotalItens: TLabel;
    Label6: TLabel;
    lbTotalValor: TLabel;
    btFecharPedido: TBitBtn;
    btPesquisarPedido: TBitBtn;
    ExcluirPedidoGrid: TAction;
    PesquisarPedidoCliente: TAction;
    AtualizaTotalGrid: TAction;
    FecharPedido: TAction;
    qryPedidos: TFDQuery;
    procedure FormCreate(Sender: TObject);
    procedure ConfigurarAmbienteExecute(Sender: TObject);
    procedure FillcomboclienteExecute(Sender: TObject);
    procedure LimparCamposPedidoExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure IncluiProdutoGridExecute(Sender: TObject);
    procedure ValidarCamposProdutoExecute(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure EncerrarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ExcluirPedidoGridExecute(Sender: TObject);
    procedure edcodigoprodutoChange(Sender: TObject);
    procedure btIncluiProdutoPedidoClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure AtualizaTotalGridExecute(Sender: TObject);
    procedure btFecharPedidoClick(Sender: TObject);
    procedure FecharPedidoExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;



var
  FrmPedidos: TFrmPedidos;
  G_validado : boolean;

implementation

{$R *.dfm}

procedure TFrmPedidos.ValidarCamposProdutoExecute(Sender: TObject);
begin
   // faz a validação dos dados digitados do produto a ser incluído no grid

   try
      // valida cód do produto
      if trim(self.edcodigoproduto.text) <> ''   then
      begin
         // verifica se o código digitado existe na tabela
         G_validado := true;
      end
      else
         begin
                        beep;
            self.edcodigoproduto.SetFocus;
            raise Exception.Create('Preencha o campo CÓDIGO DO PRODUTO !');
         end;


      // valida quantidade

      // recupera o valor unitário


   except
       on E: Exception do   ShowMessage('Erro validando campos: ' + E.Message );
   end;
end;

procedure TFrmPedidos.FecharPedidoExecute(Sender: TObject);
var
   ix : integer;
   sSql : string;
   sdata : Tdate;
   sValor : single;
   scod : integer;
begin
    //
    try
       self.conexao.StartTransaction;
       if self.grPedido.RowCount = 1 then
        begin
           showmessage('Antes de fechar o pedido, informe pelo menos um produto !');
           exit;
        end;
        sSql := 'INSERT INTO `pedidos_dados_gerais`(`num_pedido`, `data_emissao`, `cod_cliente`, `valor_total`) VALUES ';
        ix := 1;
        while self.grPedido.cells[ix,0] <> ''  do
        begin
           sSQL := SSql + self.grPedido.cells[        end;


    except
       on E: Exception do ShowMessage('Erro ' + E.Message );
    end;
    ix := 1;

end;

procedure TFrmPedidos.AtualizaTotalGridExecute(Sender: TObject);
var
   ix , somaitem: integer;
   somavalor : single;
begin
   // atualiza rodapé do grido com total de itens e valores
   {try
      somaitem := 0;
      somavalor := 0.0;
      ix := 1;
      while (trim(self.grPedido.cells[ix,0]) <> '') and (ix <= self.grPedido.rowcount - 1) do
      begin
         if trim(grpedido.cells[ix,0]) <> ''  then
         begin
            somaitem := somaitem + strtoint(self.grPedido.cells[ix,3]);
            somavalor := somavalor + strtofloat(self.grPedido.cells[ix,4]);
         end;
         ix := ix +1;
      end;
      self.lbTotalItens.Caption:= format('%10.10d',[somaitem]);
      self.lbTotalValor.Caption := format('%20.2f',[somavalor])
   except
        on E: Exception do   ShowMessage('Erro calculando totais: ' + E.Message );
   end;}

end;

procedure TFrmPedidos.BitBtn1Click(Sender: TObject);
begin
   self.ExcluirPedidoGrid.Execute;
end;

procedure TFrmPedidos.btFecharPedidoClick(Sender: TObject);
begin
   //
   self.FecharPedido.Execute;
end;

procedure TFrmPedidos.btIncluiProdutoPedidoClick(Sender: TObject);
begin
   self.IncluiProdutoGrid.Execute;
end;

procedure TFrmPedidos.btSairClick(Sender: TObject);
begin
   //
   self.Encerrar.Execute;
end;

procedure TFrmPedidos.ConfigurarAmbienteExecute(Sender: TObject);
begin
   //  seta cabeçalho do grid
   //código do produto, descrição do produto, quantidade, vlr. unitário e vlr. Total
   self.grPedido.Visible := false;
   self.grPedido.Cols[0].Text   := 'Código do Produto';
   self.grPedido.Cols[1].Text   := 'Descrição  do Produto';
   self.grPedido.Cols[2].Text   := 'Quantidade Pedida';
   self.grPedido.Cols[3].Text   := 'Valor Unitário (R$)';
   self.grPedido.Cols[4].Text   := 'Valor Total (R$) ';
   // ajusta largura das colunas do grid
   self.grPedido.ColWidths[0] := 160;
   self.grPedido.ColWidths[1] := 380;
   self.grPedido.ColWidths[2] := 140;
   self.grPedido.ColWidths[3] := 170;
   self.grPedido.ColWidths[4] := 185;
   self.grPedido.ColAlignments[3] :=  taRightJustify;
   self.grPedido.ColAlignments[4] :=  taRightJustify;
   self.grPedido.Visible := true;
   self.grPedido.RowCount := 2;
   G_validado := false;
   self.Fillcombocliente.Execute;

   self.LimparCamposPedido.Execute;

   self.btPesquisarPedido.Enabled := false;
   application.ProcessMessages;

end;

procedure TFrmPedidos.edcodigoprodutoChange(Sender: TObject);
begin
  if (trim(self.edcodigoproduto.Text) = '') then
      self.btPesquisarPedido.Enabled := true
   else
      self.btPesquisarPedido.Enabled := false;

end;

procedure TFrmPedidos.EncerrarExecute(Sender: TObject);
begin
   beep;
   if MessageDlg('Deseja realmente sair do Sistema?', mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
      application.Terminate;

end;

procedure TFrmPedidos.ExcluirPedidoGridExecute(Sender: TObject);
var
  ix, linha : Integer;
begin
  linha := self.grPedido.Row;
  if linha = 0 then
     exit;

  if (self.grPedido.Row = self.grPedido.RowCount - 1) then
      self.grPedido.RowCount := self.grPedido.RowCount - 1
  else
  begin
    for ix := linha to self.grPedido.RowCount - 1 do
      self.grPedido.Rows[ix] := self.grPedido.Rows[ix + 1];

    self.grPedido.RowCount := self.grPedido.RowCount - 1;
  end;
  self.AtualizaTotalGrid.Execute;
end;


procedure TFrmPedidos.FillcomboclienteExecute(Sender: TObject);
var
   sNome, sSql : string;
begin
    // recupera uma lista de nomes de todos os clientes para a combox do form
   try
     if conexao.Connected then
     begin
        sSql := 'Select * from clientes order by nome';
        QryCliente.sql.Text := sSql;
        QryCliente.Open ;
        QryCliente.Last;
        QryCliente.First ;
        while not QryCliente.Eof do
        begin
           sNome := QryCliente.FieldByName('nome').AsString;
           self.cbCliente.Items.Add(sNome);
           QryCliente.Next;
        end;
        self.cbCliente.ItemIndex := -1;
     end;
   except
      on E: Exception do
         ShowMessage('>>> Erro ' + E.Message );

   end;
end;


procedure TFrmPedidos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   self.Encerrar.Execute;
end;

procedure TFrmPedidos.FormCreate(Sender: TObject);
begin
   self.ConfigurarAmbiente.Execute;
end;

procedure TFrmPedidos.FormShow(Sender: TObject);
begin
   self.edcodigoproduto.SetFocus;
end;

procedure TFrmPedidos.IncluiProdutoGridExecute(Sender: TObject);
var
   ix    : integer;
begin
    //
    self.ValidarCamposProduto.Execute;

    if G_validado  then
    begin
       ix := self.grPedido.RowCount - 1;
       if ix = 0 then ix := 1;

       self.grPedido.RowCount := self.grPedido.RowCount +1;

       self.grPedido.cells[0,ix ] := '999';
       self.grPedido.cells[1,ix ] := 'Descrição do produto';
       self.grPedido.cells[2,ix ] := '100';
       self.grPedido.cells[3,ix ] := '20,00';
       self.grPedido.cells[4,ix ] := '2000,00';
       application.ProcessMessages;
       self.AtualizaTotalGrid.Execute;
       G_validado := false;
    end;
end;

procedure TFrmPedidos.LimparCamposPedidoExecute(Sender: TObject);
begin
   self.edcodigoproduto.Text := '';
   self.edquantidade.Text    := '0';
   self.edvalor.Text         := '0';
end;

end.
