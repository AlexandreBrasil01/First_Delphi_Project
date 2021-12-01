unit fConsultaVendedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  fConsultaDefault, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  dConexao, uVendedor, fCadastroVendedor, fFiltroVendedor;

type
  TfrmConsultaVendedor = class(TfrmConsultaDefault)
    procedure cbxFiltroChange(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnVisualizarClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtPesquisarChange(Sender: TObject);
    procedure btnRelatClick(Sender: TObject);
  private
    { Private declarations }
    procedure CarregaVendedor;
    procedure Incluir;
    procedure Alterar;
    procedure Excluir;
    procedure Visualizar;
  public
    { Public declarations }
  end;

var
  frmConsultaVendedor: TfrmConsultaVendedor;
  ID: String;

implementation

{$R *.dfm}
{ TfrmConsultaVendedor }

procedure TfrmConsultaVendedor.CarregaVendedor;
begin
  dtmconexao.qryConsultaVendedor.Close;
  dtmconexao.qryConsultaVendedor.sql.clear;
  dtmconexao.qryConsultaVendedor.sql.Add(' select * from VENDEDOR ');

  if edtPesquisar.Text <> emptyStr then
  begin

    case cbxFiltro.ItemIndex of
      0:
        begin
          dtmconexao.qryConsultaVendedor.sql.Add
            ('WHERE ID LIKE ' + QuotedStr('%' + edtPesquisar.Text + '%'));
        end;
      1:
        begin
          dtmconexao.qryConsultaVendedor.sql.Add('WHERE NOME LIKE ' +
            QuotedStr('%' + edtPesquisar.Text + '%'));
        end;
      2:
        begin
          dtmconexao.qryConsultaVendedor.sql.Add(' WHERE EMAIL LIKE ' +
            QuotedStr('%' + edtPesquisar.Text + '%'));
        end;
      3:
        begin
          dtmconexao.qryConsultaVendedor.sql.Add('WHERE CIDADE LIKE ' +
            QuotedStr('%' + edtPesquisar.Text + '%'));
        end;
    end;
  end;
  dtmconexao.qryConsultaVendedor.open;
end;

procedure TfrmConsultaVendedor.cbxFiltroChange(Sender: TObject);
begin
  case cbxFiltro.ItemIndex of
    0:
      begin
        edtPesquisar.NumbersOnly := true;
        edtPesquisar.clear;
        edtPesquisar.SetFocus;
      end;
    1:
      begin
        edtPesquisar.NumbersOnly := false;
        edtPesquisar.clear;
        edtPesquisar.SetFocus;
      end;
    2:
      begin
        edtPesquisar.NumbersOnly := false;
        edtPesquisar.clear;
        edtPesquisar.SetFocus;
      end;
    3:
      begin
        edtPesquisar.NumbersOnly := false;
        edtPesquisar.clear;
        edtPesquisar.SetFocus;
      end;
  end;
end;

procedure TfrmConsultaVendedor.Incluir;
var
  lFormulario: tfrmCadastroVendedor;
begin
  lFormulario := tfrmCadastroVendedor.Create(nil);
  try
    lFormulario.TipoRotina := 'Incluir';
    // função retorna proximo id no meu edit ID
    lFormulario.edtID.Text := TVendedor.GeraProximoID.tostring;
    lFormulario.ShowModal;
  finally
    lFormulario.Free;
  end;
  CarregaVendedor;
end;

procedure TfrmConsultaVendedor.Alterar;
var
  lVendedor: TVendedor;
  lFormulario: tfrmCadastroVendedor;
begin
  lFormulario := tfrmCadastroVendedor.Create(nil);
  lVendedor := TVendedor.Create;
  try
    lVendedor.ID := dtmconexao.qryConsultaVendedor.FieldByName('ID').AsInteger;
    lVendedor.Carrega;

    lVendedor.CarregaImagem(lFormulario.imgVendedor);

    lFormulario.TipoRotina := 'Alterar';

    lFormulario.edtID.Text := lVendedor.ID.tostring;
    lFormulario.edtNome.Text := lVendedor.NOME;
    lFormulario.edtEmail.Text := lVendedor.EMAIL;
    lFormulario.edtCep.Text := lVendedor.CEP;
    lFormulario.edtCidade.Text := lVendedor.CIDADE;
    lFormulario.edtBairro.Text := lVendedor.BAIRRO;
    lFormulario.edtEndereco.Text := lVendedor.ENDERECO;

    lFormulario.ShowModal;
  finally
    lFormulario.Free;
    lVendedor.Free;

    CarregaVendedor;
  end;
end;

procedure TfrmConsultaVendedor.Excluir;
begin
  var
    lVendedor: TVendedor;
  begin
    lVendedor := TVendedor.Create;
    try
      lVendedor.ID := dtmconexao.qryConsultaVendedorID.AsInteger;
      lVendedor.Carrega;
      lVendedor.Excluir(true);
    finally
      lVendedor.Free;
    end;
    CarregaVendedor;
  end;
end;

procedure TfrmConsultaVendedor.Visualizar;
var
  lVendedor: TVendedor;
  lFormulario: tfrmCadastroVendedor;
begin
  lFormulario := tfrmCadastroVendedor.Create(nil);
  lVendedor := TVendedor.Create;
  try
    lVendedor.ID := dtmconexao.qryConsultaVendedor.FieldByName('ID').AsInteger;
    lVendedor.Carrega;

    lVendedor.CarregaImagem(lFormulario.imgVendedor);

    lFormulario.TipoRotina := 'Visualizar';

    lFormulario.edtID.Text := lVendedor.ID.tostring;
    lFormulario.edtNome.Text := lVendedor.NOME;
    lFormulario.edtEmail.Text := lVendedor.EMAIL;
    lFormulario.edtCep.Text := lVendedor.CEP;
    lFormulario.edtCidade.Text := lVendedor.CIDADE;
    lFormulario.edtBairro.Text := lVendedor.BAIRRO;
    lFormulario.edtEndereco.Text := lVendedor.ENDERECO;

    lFormulario.edtNome.ReadOnly := true;
    lFormulario.edtEmail.ReadOnly := true;
    lFormulario.edtCep.ReadOnly := true;
    lFormulario.edtCidade.ReadOnly := true;
    lFormulario.edtBairro.ReadOnly := true;
    lFormulario.edtEndereco.ReadOnly := true;

    lFormulario.btnSalvar.Visible := false;

    lFormulario.ShowModal;
  finally
    lFormulario.Free;
    lVendedor.Free;

    CarregaVendedor;
  end;
end;

procedure TfrmConsultaVendedor.btnAtualizarClick(Sender: TObject);
begin
  if dtmconexao.qryConsultaVendedor.RecordCount > 0 then
  begin
    CarregaVendedor;
  end
  else
  begin
    ShowMessage('Não há registros para serem carregados.');
  end;
end;

procedure TfrmConsultaVendedor.btnIncluirClick(Sender: TObject);
begin
  Incluir;
end;

procedure TfrmConsultaVendedor.btnRelatClick(Sender: TObject);
var
  lFormulario: TfrmfiltroVendedor;
begin
  lFormulario := TfrmfiltroVendedor.Create(nil);
  try
    lFormulario.ShowModal;

  finally
    lFormulario.Free;
  end;
end;

procedure TfrmConsultaVendedor.btnAlterarClick(Sender: TObject);
begin
  if dtmconexao.qryConsultaVendedor.RecordCount > 0 then
  begin
    Alterar;
  end
  else
  begin
    ShowMessage('Não há registros para serem alterados.');
  end;
end;

procedure TfrmConsultaVendedor.btnExcluirClick(Sender: TObject);
begin
  if dtmconexao.qryConsultaVendedor.RecordCount > 0 then
  begin
    Excluir;
  end
  else
  begin
    ShowMessage('Não há registros para serem excluídos.');
  end;
end;

procedure TfrmConsultaVendedor.btnVisualizarClick(Sender: TObject);
begin
  if dtmconexao.qryConsultaVendedor.RecordCount > 0 then
  begin
    Visualizar;
  end
  else
  begin
    ShowMessage('Não há registros para serem visualizados.');
  end;
end;

procedure TfrmConsultaVendedor.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConsultaVendedor.edtPesquisarChange(Sender: TObject);
begin
  CarregaVendedor;
end;

procedure TfrmConsultaVendedor.FormShow(Sender: TObject);
begin
  inherited;
  CarregaVendedor;
  edtPesquisar.SetFocus;
end;

end.
