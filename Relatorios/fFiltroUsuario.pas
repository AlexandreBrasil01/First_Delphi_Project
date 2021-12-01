unit fFiltroUsuario;

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
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  fRelatorioUsuario;

type
  TfrmFiltroUsuario = class(TfrmFiltroDefault)
    rdgFiltro: TRadioGroup;
    rdgBusca: TRadioGroup;
    edtBusca: TEdit;
    procedure btnVisualizarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure rdgBuscaClick(Sender: TObject);
    procedure cbxListaTodosClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure cbxListaTodosEnter(Sender: TObject);
  private
    { Private declarations }
    FRelatorio: TfrmRelatorioUsuario;
  public
    { Public declarations }
  end;

var
  frmFiltroUsuario: TfrmFiltroUsuario;

implementation

{$R *.dfm}

procedure TfrmFiltroUsuario.btnLimparClick(Sender: TObject);
begin
  edtBusca.Text := emptyStr;
  rdgBusca.ItemIndex := -1;
  rdgFiltro.ItemIndex := -1;
end;

procedure TfrmFiltroUsuario.btnVisualizarClick(Sender: TObject);
begin
  FRelatorio := TfrmRelatorioUsuario.create(nil);
  try
    if (cbxListaTodos.Checked = false) and (trim(edtBusca.Text) = emptyStr) then
    begin
      ShowMessage
        ('Se não quiser listar todos os Usuarios é preciso uma especificação.');
    end
    else
    begin
      FRelatorio.DataSource1.DataSet := FRelatorio.qryRelatorio;
      FRelatorio.rlpRelatorio.datasource := FRelatorio.DataSource1;

      FRelatorio.qryRelatorio.close;
      FRelatorio.qryRelatorio.SQL.clear;
      FRelatorio.qryRelatorio.SQL.Add('SELECT * FROM USUARIO');

      case rdgBusca.ItemIndex of
        0:
          begin
            FRelatorio.qryRelatorio.SQL.Add('WHERE NOME LIKE' +
              QuotedStr('%' + edtBusca.Text + '%'));
          end;
        1:
          begin
            FRelatorio.qryRelatorio.SQL.Add('WHERE LOGIN LIKE' +
              QuotedStr('%' + edtBusca.Text + '%'));
          end;
        2:
          begin
            FRelatorio.qryRelatorio.SQL.Add('WHERE NIVELACESSO LIKE' +
              QuotedStr('%' + edtBusca.Text + '%'));
          end;
      end;

      case rdgFiltro.ItemIndex of
        0:
          begin
            FRelatorio.qryRelatorio.SQL.Add('ORDER BY ID');
          end;
        1:
          begin
            FRelatorio.qryRelatorio.SQL.Add('ORDER BY NOME');
          end;
        2:
          begin
            FRelatorio.qryRelatorio.SQL.Add('ORDER BY LOGIN');
          end;
        3:
          begin
            FRelatorio.qryRelatorio.SQL.Add('ORDER BY NIVELACESSO');
          end;
      end;

      FRelatorio.qryRelatorio.Open;

      FRelatorio.rlpRelatorio.preview;
    end;

  finally
    FRelatorio.Free;
  end;
end;

procedure TfrmFiltroUsuario.cbxListaTodosClick(Sender: TObject);
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

procedure TfrmFiltroUsuario.cbxListaTodosEnter(Sender: TObject);
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

procedure TfrmFiltroUsuario.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmFiltroUsuario.rdgBuscaClick(Sender: TObject);
begin
  edtBusca.SetFocus;
  edtBusca.Text := emptyStr;
  case rdgBusca.ItemIndex of
    0:
      begin
        edtBusca.NumbersOnly := false;
        edtBusca.MaxLength := -1;
      end;
    1:
      begin
        edtBusca.NumbersOnly := false;
        edtBusca.MaxLength := -1;
      end;
    2:
      begin
        edtBusca.NumbersOnly := true;
        edtBusca.MaxLength := 1;
      end;
  end;
end;

end.
