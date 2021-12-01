unit fFiltroProduto;

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
  fRelatorioProduto;

type
  TfrmFiltroProduto = class(TfrmFiltroDefault)
    rdgFiltro: TRadioGroup;
    Panel4: TPanel;
    rdgBusca: TRadioGroup;
    lblMenValor: TLabel;
    lblMaiValor: TLabel;
    edtMenValor: TEdit;
    edtMaiValor: TEdit;
    procedure btnVisualizarClick(Sender: TObject);
    procedure cbxListaTodosClick(Sender: TObject);
    procedure cbxListaTodosEnter(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnLimparClick(Sender: TObject);
  private
    { Private declarations }
    FRelatorio: TfrmRelatorioProduto;
  public
    { Public declarations }
  end;

var
  frmFiltroProduto: TfrmFiltroProduto;

implementation

{$R *.dfm}

procedure TfrmFiltroProduto.btnLimparClick(Sender: TObject);
begin
  rdgFiltro.ItemIndex := -1;
  rdgBusca.ItemIndex := -1;
  edtMenValor.Text := emptystr;
  edtMaiValor.Text := emptystr;
end;

procedure TfrmFiltroProduto.btnVisualizarClick(Sender: TObject);
begin
  FRelatorio := TfrmRelatorioProduto.create(nil);
  try

    FRelatorio.DataSource1.DataSet := FRelatorio.qryRelatorio;
    FRelatorio.rlpRelatorio.datasource := FRelatorio.DataSource1;

    FRelatorio.qryRelatorio.close;
    FRelatorio.qryRelatorio.SQL.clear;
    FRelatorio.qryRelatorio.SQL.Add('   SELECT                  ');
    FRelatorio.qryRelatorio.SQL.Add('   P.id                    ');
    FRelatorio.qryRelatorio.SQL.Add(' , P.descricao             ');
    FRelatorio.qryRelatorio.SQL.Add(' , P.REFERENCIA            ');
    FRelatorio.qryRelatorio.SQL.Add(' , P.CUSTO                 ');
    FRelatorio.qryRelatorio.SQL.Add(' , P.PRECO                 ');
    FRelatorio.qryRelatorio.SQL.Add(' , P.SALDO                 ');
    FRelatorio.qryRelatorio.SQL.Add(' , P.FK_UNIDADE            ');
    FRelatorio.qryRelatorio.SQL.Add(' , U.descricao             ');
    FRelatorio.qryRelatorio.SQL.Add(' , P.PESO                  ');
    FRelatorio.qryRelatorio.SQL.Add(' , P.FOTO                  ');
    FRelatorio.qryRelatorio.SQL.Add(' from PRODUTO P            ');
    FRelatorio.qryRelatorio.SQL.Add(' inner join unidade U      ');
    FRelatorio.qryRelatorio.SQL.Add(' on P.fk_unidade = U.ID    ');

    if cbxListaTodos.Checked = false then
    begin
      case rdgBusca.ItemIndex of
        0:
          begin
            FRelatorio.qryRelatorio.SQL.Add(' WHERE P.CUSTO >= ' +
              QuotedStr('%' + edtMenValor.Text + '%') + ' AND P.CUSTO <= ' +
              QuotedStr('%' + edtMaiValor.Text + '%'));
          end;
        1:
          begin
            FRelatorio.qryRelatorio.SQL.Add(' WHERE P.PRECO >= ' +
              QuotedStr('%' + edtMenValor.Text + '%') + ' AND P.PRECO <= ' +
              QuotedStr('%' + edtMaiValor.Text + '%'));
          end;
        2:
          begin
            FRelatorio.qryRelatorio.SQL.Add(' WHERE P.PESO >= ' +
              QuotedStr('%' + edtMenValor.Text + '%') + ' AND P.PESO <= ' +
              QuotedStr('%' + edtMaiValor.Text + '%'));
          end;
      end;
    end;

    case rdgFiltro.ItemIndex of
      0:
        begin
          FRelatorio.qryRelatorio.SQL.Add(' ORDER BY P.ID ');
        end;
      1:
        begin
          FRelatorio.qryRelatorio.SQL.Add(' ORDER BY P.DESCRICAO ');
        end;
      2:
        begin
          FRelatorio.qryRelatorio.SQL.Add(' ORDER BY U.DESCRICAO ');
        end;
    end;

    FRelatorio.qryRelatorio.Open;
    FRelatorio.rlpRelatorio.preview;
  finally
    FRelatorio.Free;
  end;
end;

procedure TfrmFiltroProduto.cbxListaTodosClick(Sender: TObject);
begin
  if cbxListaTodos.Checked then
  begin
    rdgBusca.Enabled := false;
    rdgBusca.ItemIndex := -1;
    edtMenValor.Enabled := false;
    edtMaiValor.Enabled := false;
    edtMenValor.Text := emptystr;
    edtMaiValor.Text := emptystr;
  end
  else
  begin
    rdgBusca.Enabled := true;
    edtMenValor.Enabled := true;
    edtMaiValor.Enabled := true;
  end;
end;

procedure TfrmFiltroProduto.cbxListaTodosEnter(Sender: TObject);
begin
  if cbxListaTodos.Checked then
  begin
    rdgBusca.Enabled := false;
    rdgBusca.ItemIndex := -1;
    edtMenValor.Enabled := false;
    edtMaiValor.Enabled := false;
  end
  else
  begin
    rdgBusca.Enabled := true;
    edtMenValor.Enabled := true;
    edtMaiValor.Enabled := true;
  end;

end;

procedure TfrmFiltroProduto.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

end.
