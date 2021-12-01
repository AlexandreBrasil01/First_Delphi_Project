unit fFiltroVenda;

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
  fRelatorioVenda;

type
  TfrmFiltroVenda = class(TfrmFiltroDefault)
    procedure btnVisualizarClick(Sender: TObject);
  private
    { Private declarations }
    FRelatorio: TfrmRelatorioVenda;
    FID: integer;
  public
    { Public declarations }
    property ID: integer read FID write FID;
    procedure ImprimeRelatorio;
  end;

var
  frmFiltroVenda: TfrmFiltroVenda;

implementation

{$R *.dfm}

procedure TfrmFiltroVenda.btnVisualizarClick(Sender: TObject);
begin
  ImprimeRelatorio;
end;

procedure TfrmFiltroVenda.ImprimeRelatorio;
  procedure CarregarQueryVendaRelatorio;
  begin
    FRelatorio.DataSource1.DataSet := FRelatorio.qryRelatorio;
    FRelatorio.rlpRelatorio.datasource := FRelatorio.DataSource1;

    FRelatorio.qryRelatorio.close;
    FRelatorio.qryRelatorio.SQL.clear;
    FRelatorio.qryRelatorio.SQL.Add('  SELECT                        ');
    FRelatorio.qryRelatorio.SQL.Add('  V.ID                          ');
    FRelatorio.qryRelatorio.SQL.Add(', V.FK_CLIENTE                  ');
    FRelatorio.qryRelatorio.SQL.Add(', C.NOME NCliente               ');
    FRelatorio.qryRelatorio.SQL.Add(', V.FK_VENDEDOR                 ');
    FRelatorio.qryRelatorio.SQL.Add(', VN.NOME NVendedor             ');
    FRelatorio.qryRelatorio.SQL.Add(', V.FK_FORMAPAGAMENTO           ');
    FRelatorio.qryRelatorio.SQL.Add(', FP.DESCRICAO                  ');
    FRelatorio.qryRelatorio.SQL.Add(', V.OBS                         ');
    FRelatorio.qryRelatorio.SQL.Add(', V.DESCONTO                    ');
    FRelatorio.qryRelatorio.SQL.Add(', V.TOTAL                       ');
    FRelatorio.qryRelatorio.SQL.Add(', V.EMISSAO                     ');
    FRelatorio.qryRelatorio.SQL.Add(', V.DATA_VENCIMENTO             ');
    FRelatorio.qryRelatorio.SQL.Add('from VENDA V                    ');
    FRelatorio.qryRelatorio.SQL.Add(' inner join CLIENTE C           ');
    FRelatorio.qryRelatorio.SQL.Add(' on V.FK_CLIENTE = C.ID         ');
    FRelatorio.qryRelatorio.SQL.Add('inner join VENDEDOR VN          ');
    FRelatorio.qryRelatorio.SQL.Add(' on V.FK_VENDEDOR = VN.ID       ');
    FRelatorio.qryRelatorio.SQL.Add('inner join FORMAPAGAMENTO FP    ');
    FRelatorio.qryRelatorio.SQL.Add(' on V.FK_FORMAPAGAMENTO = FP.ID ');
    FRelatorio.qryRelatorio.SQL.Add(' WHERE V.ID = :ID               ');
    FRelatorio.qryRelatorio.ParamByName('ID').AsInteger := FID;
    FRelatorio.qryRelatorio.Open;
  end;

  procedure CarregarQueryItemVendaRelatorio;
  begin
    FRelatorio.DataSource2.DataSet := FRelatorio.qryDetalhe;
    FRelatorio.rlpRelatorio.datasource := FRelatorio.DataSource2;

    FRelatorio.qryDetalhe.close;
    FRelatorio.qryDetalhe.SQL.clear;
    FRelatorio.qryDetalhe.SQL.Add('  SELECT                   ');
    FRelatorio.qryDetalhe.SQL.Add('  IT.ID                    ');
    FRelatorio.qryDetalhe.SQL.Add(', IT.FK_VENDA              ');
    FRelatorio.qryDetalhe.SQL.Add(', IT.FK_PRODUTO            ');
    FRelatorio.qryDetalhe.SQL.Add(', P.DESCRICAO              ');
    FRelatorio.qryDetalhe.SQL.Add(', P.FOTO                   ');
    FRelatorio.qryDetalhe.SQL.Add(', IT.EMISSAO               ');
    FRelatorio.qryDetalhe.SQL.Add(', IT.QUANTIDADE            ');
    FRelatorio.qryDetalhe.SQL.Add(', IT.VALOR                 ');
    FRelatorio.qryDetalhe.SQL.Add(', IT.DESCONTO              ');
    FRelatorio.qryDetalhe.SQL.Add('from VENDA_ITEM IT         ');
    FRelatorio.qryDetalhe.SQL.Add(' inner join PRODUTO P      ');
    FRelatorio.qryDetalhe.SQL.Add(' on IT.FK_PRODUTO = P.ID   ');
    FRelatorio.qryDetalhe.SQL.Add(' WHERE IT.FK_VENDA = :ID   ');
    FRelatorio.qryDetalhe.ParamByName('ID').AsInteger := FID;
    FRelatorio.qryDetalhe.Open;
  end;

begin
  FRelatorio := TfrmRelatorioVenda.create(nil);
  try
    CarregarQueryVendaRelatorio;
    CarregarQueryItemVendaRelatorio;
    FRelatorio.rlpRelatorio.preview;
  finally
    FRelatorio.Free;
  end;
end;

end.
