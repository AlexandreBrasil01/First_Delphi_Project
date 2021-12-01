unit fConsultaCliente;

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
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  fCadastroCliente,
  dConexao,
  uCliente,
  uConfig,
  fFiltroCliente;

type
  TfrmConsultaCliente = class(Tform)
    pnlTitulo: TPanel;
    pnlBotoes: TPanel;
    pnlGrid: TPanel;
    grdConsulta: TDBGrid;
    btnAtualizar: TButton;
    btnIncluir: TButton;
    btnAlterar: TButton;
    btnExcluir: TButton;
    btnRelat: TButton;
    pnlPesquisa: TPanel;
    edtPesquisar: TEdit;
    cbxFiltro: TComboBox;
    btnVisualizar: TButton;
    btnSair: TButton;
    procedure btnAtualizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtPesquisarChange(Sender: TObject);
    procedure cbxFiltroChange(Sender: TObject);
    procedure grdConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnVisualizarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnRelatClick(Sender: TObject);
  private
    { Private declarations }
    procedure CarregaClientes;
    procedure Incluir;
    procedure Alterar;
    procedure Excluir;
    procedure Visualizar;
    procedure SetaVisibleBtnCliente;
  public
    { Public declarations }
  end;

var
  frmConsultaCliente: TfrmConsultaCliente;

implementation

{$R *.dfm}

procedure TfrmConsultaCliente.SetaVisibleBtnCliente;
begin
  lConfig.CarregaRestricoesBanco;
  if lConfig.INCLUIR < lConfig.CONFIGNACESSO then
  begin
    btnIncluir.visible := false;
  end;
  if lConfig.ALTERAR < lConfig.CONFIGNACESSO then
  begin
    btnAlterar.visible := false;
  end;
  if lConfig.EXCLUIR < lConfig.CONFIGNACESSO then
  begin
    btnExcluir.visible := false;
  end;
  if lConfig.VISUALIZAR < lConfig.CONFIGNACESSO then
  begin
    btnVisualizar.visible := false;
  end;
  if lConfig.RELATORIO < lConfig.CONFIGNACESSO then
  begin
    btnRelat.visible := false;
  end;
end;

procedure TfrmConsultaCliente.CarregaClientes;
begin
  dtmconexao.qryConsultaClientes.close;
  dtmconexao.qryConsultaClientes.sql.clear;
  dtmconexao.qryConsultaClientes.sql.Add(' select * from CLIENTE ');

  if edtPesquisar.Text <> emptyStr then
  begin

    case cbxFiltro.ItemIndex of
      0:
        begin
          dtmconexao.qryConsultaClientes.sql.Add
            ('WHERE ID LIKE ' + QuotedStr('%' + edtPesquisar.Text + '%'));
        end;
      1:
        begin
          dtmconexao.qryConsultaClientes.sql.Add('WHERE NOME LIKE ' +
            QuotedStr('%' + edtPesquisar.Text + '%'));
        end;
      2:
        begin
          dtmconexao.qryConsultaClientes.sql.Add
            ('WHERE CPF LIKE ' + QuotedStr('%' + edtPesquisar.Text + '%'));
          dtmconexao.qryConsultaClientes.sql.Add
            ('OR CNPJ LIKE ' + QuotedStr('%' + edtPesquisar.Text + '%'));
        end;
      3:
        begin
          dtmconexao.qryConsultaClientes.sql.Add(' WHERE EMAIL LIKE ' +
            QuotedStr('%' + edtPesquisar.Text + '%'));
        end;
    end;
  end;
  dtmconexao.qryConsultaClientes.open;
end;

procedure TfrmConsultaCliente.cbxFiltroChange(Sender: TObject);
begin
  // se for index = 0 recebe numbersonly = true;  se não, recebe   numbersonly = false
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

procedure TfrmConsultaCliente.edtPesquisarChange(Sender: TObject);
begin
  CarregaClientes;
end;

procedure TfrmConsultaCliente.grdConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if gdSelected in State then
  begin
    grdConsulta.Canvas.brush.Color := StringToColor(lConfig.CONFIGCOR);
    grdConsulta.Canvas.font.Color := clwhite;
  end;
  grdConsulta.DefaultDrawDataCell(Rect, Column.Field, State);
end;

procedure TfrmConsultaCliente.Incluir;
var
  lFormulario: TfrmCadastroCliente;
begin
  lFormulario := TfrmCadastroCliente.Create(nil);
  try
    lFormulario.TipoRotina := 'Incluir';
    // função retorna proximo id no meu edit ID
    lFormulario.edtID.Text := TCliente.GeraProximoID.tostring;
    lFormulario.ShowModal;
  finally
    lFormulario.Free;
  end;
  CarregaClientes;
end;

procedure TfrmConsultaCliente.Alterar;
var
  lCliente: TCliente;
  lFormulario: TfrmCadastroCliente;
begin
  // Crio cadastro cliente e a classe cliente
  lFormulario := TfrmCadastroCliente.Create(nil);
  lCliente := TCliente.Create;
  try
    // Alimento id cliente para carregar na classe cliente
    lCliente.ID := dtmconexao.qryConsultaClientes.FieldByName('ID').AsInteger;
    lCliente.carrega; // aqui carrega propriedades do cliente na classe

    // aqui carrega propriedades da imagem do cliente na classe
    lCliente.CarregaImagem(lFormulario.imgCliente);

    lFormulario.TipoRotina := 'Alterar';
    // Abaixo uso classe cliente para alimentar os edit do cadastro
    lFormulario.edtID.Text := lCliente.ID.tostring;
    lFormulario.edtNome.Text := lCliente.NOME;
    lFormulario.edtEmail.Text := lCliente.EMAIL;
    lFormulario.edtCep.Text := lCliente.CEP;
    lFormulario.edtCidade.Text := lCliente.CIDADE;
    lFormulario.edtBairro.Text := lCliente.BAIRRO;
    lFormulario.edtEndereco.Text := lCliente.ENDERECO;

    if lCliente.FISICOOUJURIDICO = ('F') then
    begin
      lFormulario.edtCpfCnpj.Text := lCliente.CPF;
      lFormulario.cbxTipoFisJur.ItemIndex := 0;
    end
    else
    begin
      lFormulario.edtCpfCnpj.Text := lCliente.CNPJ;
      lFormulario.cbxTipoFisJur.ItemIndex := 1;
    end;

    lFormulario.ShowModal; // Abro tela cadastro cliente
  finally
    // Libero da memoria o que usei
    lFormulario.Free;
    lCliente.Free;

    CarregaClientes; // Pós alterações carrego grid de novo
  end;
end;

procedure TfrmConsultaCliente.Excluir;
var
  lCliente: TCliente;
begin
  lCliente := TCliente.Create;
  try
    lCliente.ID := dtmconexao.qryConsultaClientesID.AsInteger;
    lCliente.carrega;
    lCliente.Excluir(true);
  finally
    lCliente.Free;
  end;
  CarregaClientes;
end;

procedure TfrmConsultaCliente.Visualizar;
var
  lCliente: TCliente;
  lFormulario: TfrmCadastroCliente;
begin
  // Crio cadastro cliente e a classe cliente
  lFormulario := TfrmCadastroCliente.Create(nil);
  lCliente := TCliente.Create;
  try
    // Alimento id cliente para carregar na classe cliente
    lCliente.ID := dtmconexao.qryConsultaClientes.FieldByName('ID').AsInteger;
    lCliente.carrega; // aqui carrega propriedades do cliente na classe
    lCliente.CarregaImagem(lFormulario.imgCliente);

    // Abaixo uso classe cliente para alimentar os edit do cadastro
    lFormulario.TipoRotina := 'Visualizar';
    lFormulario.edtID.Text := lCliente.ID.tostring;
    lFormulario.edtNome.Text := lCliente.NOME;
    lFormulario.edtEmail.Text := lCliente.EMAIL;
    lFormulario.edtCep.Text := lCliente.CEP;
    lFormulario.edtCidade.Text := lCliente.CIDADE;
    lFormulario.edtBairro.Text := lCliente.BAIRRO;
    lFormulario.edtEndereco.Text := lCliente.ENDERECO;

    if lCliente.FISICOOUJURIDICO = ('F') then
    begin
      lFormulario.edtCpfCnpj.Text := lCliente.CPF;
      lFormulario.cbxTipoFisJur.ItemIndex := 0;
    end
    else
    begin
      lFormulario.edtCpfCnpj.Text := lCliente.CNPJ;
      lFormulario.cbxTipoFisJur.ItemIndex := 1;
    end;

    lFormulario.edtID.ReadOnly := true;
    lFormulario.edtNome.ReadOnly := true;
    lFormulario.edtEmail.ReadOnly := true;
    lFormulario.edtCep.ReadOnly := true;
    lFormulario.edtCidade.ReadOnly := true;
    lFormulario.edtBairro.ReadOnly := true;
    lFormulario.edtEndereco.ReadOnly := true;
    lFormulario.edtCpfCnpj.ReadOnly := true;
    lFormulario.cbxTipoFisJur.Enabled := false;

    lFormulario.btnSalvar.visible := false;

    lFormulario.ShowModal; // Abro tela cadastro cliente
  finally
    // Libero da memoria o que usei
    lFormulario.Free;
    lCliente.Free;
  end;
end;

procedure TfrmConsultaCliente.btnAtualizarClick(Sender: TObject);
begin
  if dtmconexao.qryConsultaClientes.RecordCount > 0 then
  begin
    CarregaClientes;
  end
  else
  begin
    ShowMessage('Não há registros para serem carregados.');
  end;
end;

procedure TfrmConsultaCliente.btnIncluirClick(Sender: TObject);
begin
  Incluir;
end;

procedure TfrmConsultaCliente.btnAlterarClick(Sender: TObject);
begin
  if dtmconexao.qryConsultaClientes.RecordCount > 0 then
  begin
    Alterar;
  end
  else
  begin
    ShowMessage('Não há registros para serem alterados.');
  end;
end;

procedure TfrmConsultaCliente.btnExcluirClick(Sender: TObject);
begin
  if dtmconexao.qryConsultaClientes.RecordCount > 0 then
  begin
    Excluir;
  end
  else
  begin
    ShowMessage('Não há registros para serem excluídos.');
  end;
end;

procedure TfrmConsultaCliente.btnVisualizarClick(Sender: TObject);
begin
  if dtmconexao.qryConsultaClientes.RecordCount > 0 then
  begin
    Visualizar;
  end
  else
  begin
    ShowMessage('Não há registros para serem visualizados.');
  end;
end;

procedure TfrmConsultaCliente.btnRelatClick(Sender: TObject);
var
  lFormulario: TfrmfiltroCliente;
begin
  lFormulario := TfrmfiltroCliente.Create(nil);
  try
    lFormulario.ShowModal;

  finally
    lFormulario.Free;
  end;
end;

procedure TfrmConsultaCliente.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure TfrmConsultaCliente.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmConsultaCliente.FormShow(Sender: TObject);
begin
  WindowState := wsMaximized;
  CarregaClientes;
  SetaVisibleBtnCliente;
  edtPesquisar.SetFocus;
end;

end.
