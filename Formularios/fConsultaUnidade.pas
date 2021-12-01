unit fConsultaUnidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  fConsultaDefault, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.ExtCtrls, dConexao, fCadastroUnidade, uUnidade, fFiltroUnidade;

type
  TfrmConsultaUnidade = class(TfrmConsultaDefault)
    procedure cbxFiltroChange(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtPesquisarChange(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnVisualizarClick(Sender: TObject);
    procedure btnRelatClick(Sender: TObject);
  private
    { Private declarations }
    procedure CarregaUnidade;
    procedure Incluir;
    procedure Alterar;
    procedure Excluir;
    procedure Visualizar;
  public
    { Public declarations }
  end;

var
  frmConsultaUnidade: TfrmConsultaUnidade;
  ID: String;

implementation

{$R *.dfm}

procedure TfrmConsultaUnidade.CarregaUnidade;
begin
  dtmConexao.qryConsultaUnidade.close;
  dtmConexao.qryConsultaUnidade.SQL.Clear;
  dtmConexao.qryConsultaUnidade.SQL.Add(' select * from UNIDADE ');

  if edtPesquisar.Text <> emptyStr then
  begin
    case cbxFiltro.ItemIndex of
      0:
        begin
          dtmConexao.qryConsultaUnidade.SQL.Add
            ('WHERE ID LIKE ' + QuotedStr('%' + edtPesquisar.Text + '%'));
        end;
      1:
        begin
          dtmConexao.qryConsultaUnidade.SQL.Add('WHERE UNIDADE LIKE ' +
            QuotedStr('%' + edtPesquisar.Text + '%'));
        end;
    end;
  end;
  dtmConexao.qryConsultaUnidade.open;
end;

procedure TfrmConsultaUnidade.cbxFiltroChange(Sender: TObject);
begin
  case cbxFiltro.ItemIndex of
    0:
      begin
        edtPesquisar.NumbersOnly := true;
        edtPesquisar.Clear;
      end;
    1:
      begin
        edtPesquisar.NumbersOnly := false;
        edtPesquisar.Clear;
      end;
  end;
end;

procedure TfrmConsultaUnidade.edtPesquisarChange(Sender: TObject);
begin
  CarregaUnidade;
end;

procedure TfrmConsultaUnidade.Incluir;
var
  lFormulario: TfrmCadastroUnidade;
begin
  lFormulario := TfrmCadastroUnidade.Create(nil);
  try
    lFormulario.TipoRotina := 'Incluir';
    // função retorna proximo id no meu edit ID
    lFormulario.edtID.Text := TUnidade.GeraProximoID.tostring;
    lFormulario.ShowModal;
    CarregaUnidade;
  finally
    lFormulario.Free;
  end;
end;

procedure TfrmConsultaUnidade.Alterar;
var
  // Crio cadastro usuario e a classe unidade
  lFormulario: TfrmCadastroUnidade;
  lUnidade: TUnidade;
begin
  // Alimento id usuario para carregar na classe unidade
  lFormulario := TfrmCadastroUnidade.Create(nil);
  // aqui carrega propriedades da Unidade na classe
  lUnidade := TUnidade.Create;
  try
    // Abaixo uso classe unidade para alimentar os edit do cadastro
    lUnidade.ID := dtmConexao.qryConsultaUnidade.FieldByName('ID').AsInteger;
    lUnidade.Carrega;

    lFormulario.edtID.Text := lUnidade.ID.tostring;
    lFormulario.edtDescricao.Text := lUnidade.DESCRICAO;
    lFormulario.edtUnidade.Text := lUnidade.UNIDADE;

    lFormulario.TipoRotina := 'Alterar';
    lFormulario.ShowModal;
  finally
    lFormulario.Free;
    lUnidade.Free;
    CarregaUnidade;
  end;
end;

procedure TfrmConsultaUnidade.Excluir;
var
  lUnidade: TUnidade;
begin
  lUnidade := TUnidade.Create;
  try
    lUnidade.ID := dtmConexao.qryConsultaUnidadeID.AsInteger;
    lUnidade.Carrega;
    lUnidade.Excluir(true);
  finally
    lUnidade.Free;
  end;
  CarregaUnidade;
end;

procedure TfrmConsultaUnidade.Visualizar;
var
  lFormulario: TfrmCadastroUnidade;
  lUnidade: TUnidade;
begin
  lFormulario := TfrmCadastroUnidade.Create(nil);
  lUnidade := TUnidade.Create;
  try
    lUnidade.ID := dtmConexao.qryConsultaUnidade.FieldByName('ID').AsInteger;
    lUnidade.Carrega;

    lFormulario.TipoRotina := 'Visualizar';
    lFormulario.edtID.Text := lUnidade.ID.tostring;
    lFormulario.edtDescricao.Text := lUnidade.DESCRICAO;
    lFormulario.edtUnidade.Text := lUnidade.UNIDADE;

    lFormulario.edtDescricao.ReadOnly := true;
    lFormulario.edtUnidade.ReadOnly := true;
    lFormulario.btnSalvar.Visible := false;

    lFormulario.ShowModal;
  finally
    lFormulario.Free;
    lUnidade.Free;
    CarregaUnidade;
  end;
end;

procedure TfrmConsultaUnidade.btnAtualizarClick(Sender: TObject);
begin
  if dtmConexao.qryConsultaUnidade.RecordCount > 0 then
  begin
    CarregaUnidade;
  end
  else
  begin
    ShowMessage('Não há registros para serem carregados.');
  end;
end;

procedure TfrmConsultaUnidade.btnIncluirClick(Sender: TObject);
begin
  Incluir;
end;

procedure TfrmConsultaUnidade.btnRelatClick(Sender: TObject);
var
  lFormulario: TfrmfiltroUnidade;
begin
  lFormulario := TfrmfiltroUnidade.Create(nil);
  try
    lFormulario.ShowModal;

  finally
    lFormulario.Free;
  end;
end;

procedure TfrmConsultaUnidade.btnAlterarClick(Sender: TObject);
begin
  if dtmConexao.qryConsultaUnidade.RecordCount > 0 then
  begin
    Alterar;
  end
  else
  begin
    ShowMessage('Não há registros para serem alterados.');
  end;
end;

procedure TfrmConsultaUnidade.btnExcluirClick(Sender: TObject);
begin
  if dtmConexao.qryConsultaUnidade.RecordCount > 0 then
  begin
    Excluir;
  end
  else
  begin
    ShowMessage('Não há registros para serem excluídos.');
  end;
end;

procedure TfrmConsultaUnidade.btnVisualizarClick(Sender: TObject);
begin
  if dtmConexao.qryConsultaUnidade.RecordCount > 0 then
  begin
    Visualizar;
    btnSair.SetFocus;
  end
  else
  begin
    ShowMessage('Não há registros para serem visualizados.');
  end;
end;

procedure TfrmConsultaUnidade.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure TfrmConsultaUnidade.FormShow(Sender: TObject);
begin
  inherited;
  CarregaUnidade;
end;

end.
