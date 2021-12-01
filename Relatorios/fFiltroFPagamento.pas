unit fFiltroFPagamento;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  fFiltroDefault,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  fRelatorioFPagamento;

type
  TfrmFiltroFPagamento = class(TfrmFiltroDefault)
    procedure btnVisualizarClick(Sender: TObject);
  private
    { Private declarations }
    FRelatorio: TfrmRelatorioFPagamento;
  public
    { Public declarations }
    procedure ImprimeRelatorio;
  end;

var
  frmFiltroFPagamento: TfrmFiltroFPagamento;

implementation

{$R *.dfm}

procedure TfrmFiltroFPagamento.btnVisualizarClick(Sender: TObject);
begin
  ImprimeRelatorio;
end;

procedure TfrmFiltroFPagamento.ImprimeRelatorio;
  procedure CarregaQryRelatorio;
  begin
    FRelatorio.DataSource1.DataSet := FRelatorio.qryRelatorio;
    FRelatorio.rlpRelatorio.datasource := FRelatorio.DataSource1;

    FRelatorio.qryRelatorio.close;
    FRelatorio.qryRelatorio.SQL.clear;
    FRelatorio.qryRelatorio.SQL.Add('SELECT * FROM FORMAPAGAMENTO');

    FRelatorio.qryRelatorio.Open;
  end;

begin
  FRelatorio := TfrmRelatorioFPagamento.create(nil);
  try
    CarregaQryRelatorio;
    FRelatorio.rlpRelatorio.preview;
  finally
    FRelatorio.free;
  end;

end;

end.
