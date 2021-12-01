unit fFiltroVendedor;

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
  fRelatorioVendedor;

type
  TfrmFiltroVendedor = class(TfrmFiltroDefault)
    rdgFiltro: TRadioGroup;
    rdgBusca: TRadioGroup;
    edtBusca: TEdit;
    procedure btnVisualizarClick(Sender: TObject);
    procedure cbxListaTodosClick(Sender: TObject);
    procedure cbxListaTodosEnter(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    { Private declarations }
    FRelatorio: TfrmRelatorioVendedor;
  public
    { Public declarations }
  end;

var
  frmFiltroVendedor: TfrmFiltroVendedor;

implementation

{$R *.dfm}

procedure TfrmFiltroVendedor.btnLimparClick(Sender: TObject);
begin
  edtBusca.Text := emptyStr;
  rdgBusca.ItemIndex := -1;
  rdgFiltro.ItemIndex := -1;
end;

procedure TfrmFiltroVendedor.btnVisualizarClick(Sender: TObject);
begin
  FRelatorio := TfrmRelatorioVendedor.create(nil);
  try

    if (cbxListaTodos.Checked = false) and (trim(edtBusca.Text) = emptyStr) then
    begin
      ShowMessage
        ('Se não quiser listar todos os Vendedores é preciso uma especificação.');
    end
    else
    begin
      FRelatorio.DataSource1.DataSet := FRelatorio.qryRelatorio;
      FRelatorio.rlpRelatorio.datasource := FRelatorio.DataSource1;

      FRelatorio.qryRelatorio.close;
      FRelatorio.qryRelatorio.SQL.clear;
      FRelatorio.qryRelatorio.SQL.Add('SELECT * FROM VENDEDOR');

      case rdgBusca.ItemIndex of
        0:
          begin
            FRelatorio.qryRelatorio.SQL.Add('WHERE NOME LIKE' +
              QuotedStr('%' + edtBusca.Text + '%'));
          end;
        1:
          begin
            FRelatorio.qryRelatorio.SQL.Add('WHERE EMAIL LIKE' +
              QuotedStr('%' + edtBusca.Text + '%'));
          end;
        2:
          begin
            FRelatorio.qryRelatorio.SQL.Add('WHERE CIDADE LIKE' +
              QuotedStr('%' + edtBusca.Text + '%'));
          end;
      end;

      case rdgFiltro.ItemIndex of
        0:
          begin
            FRelatorio.qryRelatorio.SQL.Add('ORDER BY NOME');
          end;
        1:
          begin
            FRelatorio.qryRelatorio.SQL.Add('ORDER BY EMAIL');
          end;
        2:
          begin
            FRelatorio.qryRelatorio.SQL.Add('ORDER BY CIDADE');
          end;
      end;

      FRelatorio.qryRelatorio.Open;

      FRelatorio.rlpRelatorio.preview;
    end;
  finally
    FRelatorio.Free;
  end;
end;

procedure TfrmFiltroVendedor.cbxListaTodosClick(Sender: TObject);
begin
  if cbxListaTodos.Checked then
  begin
    rdgBusca.Enabled := false;
    rdgBusca.ItemIndex := -1;
    edtBusca.Enabled := false;
  end
  else
  begin
    rdgBusca.Enabled := true;
    edtBusca.Enabled := true;
  end;
end;

procedure TfrmFiltroVendedor.cbxListaTodosEnter(Sender: TObject);
begin
  if cbxListaTodos.Checked then
  begin
    rdgBusca.Enabled := false;
    rdgBusca.ItemIndex := -1;
    edtBusca.Enabled := false;
  end
  else
  begin
    rdgBusca.Enabled := true;
    edtBusca.Enabled := true;
  end;
end;

end.
