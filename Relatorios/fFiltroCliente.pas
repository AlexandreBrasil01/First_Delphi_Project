unit fFiltroCliente;

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
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  fRelatorioCliente;

type
  TfrmFiltroCliente = class(TForm)
    Panel1: TPanel;
    cbxListaTodos: TCheckBox;
    rdgFiltro: TRadioGroup;
    pnlBotoes: TPanel;
    btnVisualizar: TButton;
    pnlTitulo: TPanel;
    edtBusca: TEdit;
    rdgBusca: TRadioGroup;
    btnLimpar: TButton;
    RadioGroup1: TRadioGroup;
    procedure btnVisualizarClick(Sender: TObject);
    procedure rdgBuscaClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cbxListaTodosEnter(Sender: TObject);
    procedure cbxListaTodosClick(Sender: TObject);
  private
    { Private declarations }
    FRelatorio: TfrmRelatorioCliente;
  public
    { Public declarations }
  end;

var
  frmFiltroCliente: TfrmFiltroCliente;

implementation

{$R *.dfm}

procedure TfrmFiltroCliente.btnVisualizarClick(Sender: TObject);
begin
  FRelatorio := TfrmRelatorioCliente.create(nil);
  try
    FRelatorio.DataSource1.DataSet := FRelatorio.qryRelatorio;
    FRelatorio.rlpRelatorio.datasource := FRelatorio.DataSource1;

    FRelatorio.qryRelatorio.close;
    FRelatorio.qryRelatorio.SQL.clear;
    FRelatorio.qryRelatorio.SQL.Add('SELECT * FROM CLIENTE');

    case rdgBusca.ItemIndex of
      0:
        begin
          FRelatorio.qryRelatorio.SQL.Add('WHERE ID LIKE' +
            QuotedStr('%' + edtBusca.Text + '%'));
        end;
      1:
        begin
          FRelatorio.qryRelatorio.SQL.Add('WHERE NOME LIKE' +
            QuotedStr('%' + edtBusca.Text + '%'));
        end;
      2:
        begin
          FRelatorio.qryRelatorio.SQL.Add('WHERE FISICOOUJURIDICO LIKE' +
            QuotedStr('%' + edtBusca.Text + '%'));
        end;
      3:
        begin
          FRelatorio.qryRelatorio.SQL.Add('WHERE EMAIL LIKE' +
            QuotedStr('%' + edtBusca.Text + '%'));
        end;
      4:
        begin
          FRelatorio.qryRelatorio.SQL.Add('WHERE CIDADE LIKE' +
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
          FRelatorio.qryRelatorio.SQL.Add('ORDER BY FISICOOUJURIDICO');
        end;
    end;

    FRelatorio.qryRelatorio.Open;

    FRelatorio.rlpRelatorio.preview;
  finally
    FRelatorio.Free;
  end;
end;

procedure TfrmFiltroCliente.btnLimparClick(Sender: TObject);
begin
  edtBusca.Text := emptyStr;
  rdgBusca.ItemIndex := -1;
  rdgFiltro.ItemIndex := -1;
end;

procedure TfrmFiltroCliente.cbxListaTodosClick(Sender: TObject);
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

procedure TfrmFiltroCliente.cbxListaTodosEnter(Sender: TObject);
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

procedure TfrmFiltroCliente.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmFiltroCliente.rdgBuscaClick(Sender: TObject);
begin
  edtBusca.SetFocus;
  case rdgBusca.ItemIndex of
    0:
      begin
        edtBusca.NumbersOnly := true;
      end;
    1:
      begin
        edtBusca.NumbersOnly := false;
      end;
    2:
      begin
        edtBusca.NumbersOnly := false;
        edtBusca.MaxLength := 1;
        if (edtBusca.Text <> 'F') and (edtBusca.Text <> 'J') then
        begin

        end
        else
        begin
          ShowMessage('Somente F ou J são aceitos');
        end;

      end;
    3:
      begin
        edtBusca.NumbersOnly := false;
      end;
    4:
      begin
        edtBusca.NumbersOnly := false;
      end;
  end;
end;

end.
