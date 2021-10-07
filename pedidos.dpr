program pedidos;

uses
  Vcl.Forms,
  unFrmPedidos in 'unFrmPedidos.pas' {FrmPedidos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPedidos, FrmPedidos);
  Application.Run;
end.
