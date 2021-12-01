unit fConsultaUsuario;

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
  fConsultaDefault,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  fCadastroUsuario,
  dConexao,
  uUsuario,
  fFiltroUsuario;

type
  TfrmConsultaUsuario = class(TfrmConsultaDefault)
    procedure cbxFiltroChange(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure edtPesquisarChange(Sender: TObject);
    procedure btnVisualizarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnRelatClick(Sender: TObject);

  private
    { Private declarations }
    procedure CarregaUsuarios;
    procedure Incluir;
    procedure Alterar;
    procedure Excluir;
    procedure Visualizar;
  public
    { Public declarations }
  end;

var
  frmConsultaUsuario: TfrmConsultaUsuario;
  ID: String;

implementation

{$R *.dfm}

procedure TfrmConsultaUsuario.CarregaUsuarios;
begin
  dtmConexao.qryConsultaUsuarios.close;
  dtmConexao.qryConsultaUsuarios.sql.clear;
  dtmConexao.qryConsultaUsuarios.sql.Add('select * from USUARIO');
  if edtPesquisar.Text <> emptyStr then
  begin
    case cbxFiltro.ItemIndex of
      0:
        begin
          dtmConexao.qryConsultaUsuarios.sql.Add
            ('WHERE ID LIKE ' + QuotedStr('%' + edtPesquisar.Text + '%'));
        end;
      1:
        begin
          dtmConexao.qryConsultaUsuarios.sql.Add('WHERE NIVELACESSO LIKE ' +
            QuotedStr('%' + edtPesquisar.Text + '%'));
        end;
      2:
        begin
          dtmConexao.qryConsultaUsuarios.sql.Add('WHERE NOME LIKE ' +
            QuotedStr('%' + edtPesquisar.Text + '%'));
        end;
      3:
        begin
          dtmConexao.qryConsultaUsuarios.sql.Add('WHERE LOGIN LIKE ' +
            QuotedStr('%' + edtPesquisar.Text + '%'));
        end;
      4:
        begin
          dtmConexao.qryConsultaUsuarios.sql.Add('WHERE EMAIL LIKE ' +
            QuotedStr('%' + edtPesquisar.Text + '%'));
        end;
    end;
  end;
  dtmConexao.qryConsultaUsuarios.open;
end;

procedure TfrmConsultaUsuario.cbxFiltroChange(Sender: TObject);
begin
  // se for index = 0 recebe numbersonly = true;  se não, recebe   numbersonly = false
  case cbxFiltro.ItemIndex of
    0:
      begin
        edtPesquisar.NumbersOnly := true;
        edtPesquisar.clear;
      end;
    1:
      begin
        edtPesquisar.NumbersOnly := true;
        edtPesquisar.clear;
      end;
    2:
      begin
        edtPesquisar.NumbersOnly := false;
        edtPesquisar.clear;
      end;
    3:
      begin
        edtPesquisar.NumbersOnly := false;
        edtPesquisar.clear;
      end;
    4:
      begin
        edtPesquisar.NumbersOnly := false;
        edtPesquisar.clear;
      end;
  end;
end;

procedure TfrmConsultaUsuario.edtPesquisarChange(Sender: TObject);
begin
  CarregaUsuarios;
end;

procedure TfrmConsultaUsuario.Incluir;
var
  lFormulario: TfrmCadastroUsuario;
begin
  lFormulario := TfrmCadastroUsuario.Create(nil);
  try
    lFormulario.TipoRotina := 'Incluir';
    // função retorna proximo id no meu edit ID
    lFormulario.edtID.Text := TUsuario.GeraProximoID.tostring;
    lFormulario.ShowModal;
    CarregaUsuarios;
  finally
    lFormulario.Free;
  end;
  CarregaUsuarios;
end;

procedure TfrmConsultaUsuario.Alterar;
var
  lUsuario: TUsuario;
  lFormulario: TfrmCadastroUsuario;
begin
  // Crio cadastro usuario e a classe usuario
  lFormulario := TfrmCadastroUsuario.Create(nil);
  lUsuario := TUsuario.Create;
  try
    // Alimento id usuario para carregar na classe usuario
    lUsuario.ID := dtmConexao.qryConsultaUsuarios.FieldByName('ID').AsInteger;
    lUsuario.Carrega; // aqui carrega propriedades do usuario na classe

    lUsuario.CarregaImagem(lFormulario.imgUsuario);

    // Abaixo uso classe usuario para alimentar os edit do cadastro
    lFormulario.TipoRotina := 'Alterar';
    lFormulario.edtID.Text := lUsuario.ID.tostring;
    lFormulario.edtNome.Text := lUsuario.NOME;
    lFormulario.edtLogin.Text := lUsuario.LOGIN;
    lFormulario.edtSenha.Text := lUsuario.SENHA;
    lFormulario.edtEmail.Text := lUsuario.EMAIL;
    lFormulario.edtNivelAcesso.Text := lUsuario.NIVELACESSO.tostring;

    lFormulario.oldEmail := lUsuario.EMAIL;
    lFormulario.oldLogin := lUsuario.LOGIN;

    lFormulario.ShowModal; // Abro tela cadastro usuario
  finally
    // Libero da memoria o que usei
    lFormulario.Free;
    lUsuario.Free;

    CarregaUsuarios; // Pós alterações carrego grid de novo
  end;
end;

procedure TfrmConsultaUsuario.Excluir;
var
  lUsuario: TUsuario;
begin
  lUsuario := TUsuario.Create;
  try
    lUsuario.ID := dtmConexao.qryConsultaUsuariosID.AsInteger;
    lUsuario.Carrega;
    lUsuario.Excluir(true);
  finally
    lUsuario.Free;
  end;
  CarregaUsuarios;
end;

procedure TfrmConsultaUsuario.Visualizar;
var
  lUsuario: TUsuario;
  lFormulario: TfrmCadastroUsuario;
begin
  lFormulario := TfrmCadastroUsuario.Create(nil);
  lUsuario := TUsuario.Create;
  try
    lUsuario.ID := dtmConexao.qryConsultaUsuarios.FieldByName('ID').AsInteger;
    lUsuario.Carrega;

    lUsuario.CarregaImagem(lFormulario.imgUsuario);

    lFormulario.TipoRotina := 'Visualizar';
    lFormulario.edtID.Text := lUsuario.ID.tostring;
    lFormulario.edtNome.Text := lUsuario.NOME;
    lFormulario.edtLogin.Text := lUsuario.LOGIN;
    lFormulario.edtSenha.Text := lUsuario.SENHA;
    lFormulario.edtEmail.Text := lUsuario.EMAIL;
    lFormulario.edtNivelAcesso.Text := lUsuario.NIVELACESSO.tostring;

    lFormulario.oldEmail := lUsuario.EMAIL;
    lFormulario.oldLogin := lUsuario.LOGIN;

    lFormulario.edtNome.ReadOnly := true;
    lFormulario.edtLogin.ReadOnly := true;
    lFormulario.edtSenha.ReadOnly := true;
    lFormulario.edtEmail.ReadOnly := true;
    lFormulario.edtNivelAcesso.ReadOnly := true;
    lFormulario.btnSalvar.Visible := false;

    lFormulario.ShowModal;
  finally

    lFormulario.Free;
    lUsuario.Free;

    CarregaUsuarios;
  end;
end;

procedure TfrmConsultaUsuario.btnAtualizarClick(Sender: TObject);
begin
  if dtmConexao.qryConsultaUsuarios.RecordCount > 0 then
  begin
    CarregaUsuarios;
  end
  else
  begin
    ShowMessage('Não há registros para serem carregados.');
  end;
end;

procedure TfrmConsultaUsuario.btnIncluirClick(Sender: TObject);
begin
  Incluir;
end;

procedure TfrmConsultaUsuario.btnAlterarClick(Sender: TObject);
begin
  if dtmConexao.qryConsultaUsuarios.RecordCount > 0 then
  begin
    Alterar;
  end
  else
  begin
    ShowMessage('Não há registros para serem alterados.');
  end;
end;

procedure TfrmConsultaUsuario.btnExcluirClick(Sender: TObject);
begin
  if dtmConexao.qryConsultaUsuarios.RecordCount > 0 then
  begin
    Excluir;
  end
  else
  begin
    ShowMessage('Não há registros para serem excluídos.');
  end;
end;

procedure TfrmConsultaUsuario.btnVisualizarClick(Sender: TObject);
begin
  if dtmConexao.qryConsultaUsuarios.RecordCount > 0 then
  begin
    Visualizar;
  end
  else
  begin
    ShowMessage('Não há registros para serem visualizados.');
  end;
end;

procedure TfrmConsultaUsuario.btnRelatClick(Sender: TObject);
var
  lFormulario: TfrmFiltroUsuario;
begin
  lFormulario := TfrmFiltroUsuario.Create(nil);
  try
    lFormulario.ShowModal;

  finally
    lFormulario.Free;
  end;
end;

procedure TfrmConsultaUsuario.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure TfrmConsultaUsuario.FormShow(Sender: TObject);
begin
  inherited;
  CarregaUsuarios;
end;

end.
