unit fFiltroUnidade;

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
  fRelatorioUnidade;

type
  TfrmFiltroUnidade = class(TfrmFiltroDefault)
    procedure btnVisualizarClick(Sender: TObject);
  private
    { Private declarations }
    FRelatorio: TfrmRelatorioUnidade;
  public
    { Public declarations }
  end;

var
  frmFiltroUnidade: TfrmFiltroUnidade;

implementation

{$R *.dfm}

procedure TfrmFiltroUnidade.btnVisualizarClick(Sender: TObject);
begin
  FRelatorio := TfrmRelatorioUnidade.create(nil);
  try
    FRelatorio.DataSource1.DataSet := FRelatorio.qryRelatorio;
    FRelatorio.rlpRelatorio.datasource := FRelatorio.DataSource1;

    FRelatorio.qryRelatorio.close;
    FRelatorio.qryRelatorio.SQL.clear;
    FRelatorio.qryRelatorio.SQL.Add('SELECT * FROM UNIDADE');

    FRelatorio.qryRelatorio.Open;

    FRelatorio.rlpRelatorio.preview;
  finally
    FRelatorio.free;
  end;
end;

end.
