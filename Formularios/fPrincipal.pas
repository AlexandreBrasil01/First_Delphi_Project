unit fPrincipal;

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
  Vcl.Menus,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  FireDAC.Comp.Client,
  fConsultaCliente,
  fConsultaUsuario,
  fConsultaProduto,
  fConsultaUnidade,
  fConsultaFPagamento,
  fConsultaVendedor,
  Vcl.Buttons,
  fConsultaVenda,
  fFiltroUsuario,
  fRelatorioUsuario,
  fFiltroCliente,
  fFiltroVendedor,
  fFiltroProduto,
  fRelatorioUnidade,
  fRelatorioFPagamento,
  uConfig,
  fConfig,
  fConsultaDefault;

type
  TfrmPrincipal = class(TForm)
    pnlTitulo: TPanel;
    pnlCentral: TPanel;
    pnlRodape: TPanel;
    mnuPrincipal: TMainMenu;
    Connsulta1: TMenuItem;
    mnuCliente: TMenuItem;
    Relatrios1: TMenuItem;
    Configurao1: TMenuItem;
    mnuUsuario: TMenuItem;
    mnuProduto: TMenuItem;
    mnuUnidade: TMenuItem;
    mnuFPagamento: TMenuItem;
    mnuVendedor: TMenuItem;
    mnuVendas: TMenuItem;
    mnuUsuarioRelat: TMenuItem;
    mnuClienteRelat: TMenuItem;
    mnuVendedorRelat: TMenuItem;
    mnuProdutoRelat: TMenuItem;
    mnuUnidadeRelat: TMenuItem;
    mnuFPagamentoRelat: TMenuItem;
    mnuVendaRelat: TMenuItem;
    procedure mnuClienteClick(Sender: TObject);
    procedure mnuUsuarioClick(Sender: TObject);
    procedure mnuProdutoClick(Sender: TObject);
    procedure mnuUnidadeClick(Sender: TObject);
    procedure mnuFPagamentoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnuVendedorClick(Sender: TObject);
    procedure mnuVendasClick(Sender: TObject);
    procedure mnuUsuarioRelatClick(Sender: TObject);
    procedure mnuClienteRelatClick(Sender: TObject);
    procedure mnuVendedorRelatClick(Sender: TObject);
    procedure mnuProdutoRelatClick(Sender: TObject);
    procedure mnuUnidadeRelatClick(Sender: TObject);
    procedure mnuFPagamentoRelatClick(Sender: TObject);
    procedure mnuVendaRelatClick(Sender: TObject);
    procedure Configurao1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    FId: integer;
    FNAcesso: integer;
    FLogin: String;
    FSenha: String;
    FCor: String;
    procedure PintaPainelComCorUsuario(pPanel: TPanel);
    procedure SetaVisibleBtnCliente;
  public
    { Public declarations }
    property Id: integer read FId write FId;
    property Login: String read FLogin write FLogin;
    property Senha: String read FSenha write FSenha;
    property NAcesso: integer read FNAcesso write FNAcesso;
    property Cor: String read FCor write FCor;

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.SetaVisibleBtnCliente;
begin
  lConfig.CarregaRestricoesBanco;
  // restrições das Consultas
  if lConfig.FORMUSUARIO < lConfig.CONFIGNACESSO then
  begin
    mnuUsuario.Enabled := false;
  end;
  if lConfig.FORMCLIENTE < lConfig.CONFIGNACESSO then
  begin
    mnuCliente.Enabled := false;
  end;
  if lConfig.FORMVENDEDOR < lConfig.CONFIGNACESSO then
  begin
    mnuVendedor.Enabled := false;
  end;
  if lConfig.FORMPRODUTO < lConfig.CONFIGNACESSO then
  begin
    mnuProduto.Enabled := false;
  end;
  if lConfig.FORMUNIDADE < lConfig.CONFIGNACESSO then
  begin
    mnuUnidade.Enabled := false;
  end;
  if lConfig.FORMFPAGAMENTO < lConfig.CONFIGNACESSO then
  begin
    mnuFPagamento.Enabled := false;
  end;
  if lConfig.FORMVENDA < lConfig.CONFIGNACESSO then
  begin
    mnuVendas.Enabled := false;
  end;
  // Restrições dos Relatorios
  if lConfig.RELATORIO < lConfig.CONFIGNACESSO then
  begin
    Relatrios1.Enabled := false;
  end;
end;

procedure TfrmPrincipal.mnuClienteClick(Sender: TObject);
var
  lFormulario: TFrmConsultaCliente;
begin
  lFormulario := TFrmConsultaCliente.Create(nil);
  try
    lFormulario.pnlTitulo.color := StringToColor(Cor);
    lFormulario.pnlBotoes.color := StringToColor(Cor);

    lFormulario.ShowModal;
  finally
    lFormulario.Free;
  end;
end;

procedure TfrmPrincipal.mnuFPagamentoClick(Sender: TObject);
var
  lFormulario: TfrmConsultaFPagamento;
begin
  lFormulario := TfrmConsultaFPagamento.Create(nil);
  try
    lFormulario.pnlTitulo.color := StringToColor(Cor);
    lFormulario.pnlBotoes.color := StringToColor(Cor);

    lFormulario.ShowModal;
  finally
    lFormulario.Free;
  end;
end;

procedure TfrmPrincipal.mnuUsuarioClick(Sender: TObject);
var
  lFormulario: TfrmConsultaUsuario;
begin
  lFormulario := TfrmConsultaUsuario.Create(nil);
  try
    lFormulario.pnlTitulo.color := StringToColor(Cor);
    lFormulario.pnlBotoes.color := StringToColor(Cor);

    lFormulario.ShowModal;
  finally
    lFormulario.Free;
  end;
end;

procedure TfrmPrincipal.mnuVendedorClick(Sender: TObject);
var
  lFormulario: TfrmConsultaVendedor;
begin
  lFormulario := TfrmConsultaVendedor.Create(nil);
  try
    lFormulario.pnlTitulo.color := StringToColor(Cor);
    lFormulario.pnlBotoes.color := StringToColor(Cor);

    lFormulario.ShowModal;
  finally
    lFormulario.Free;
  end;
end;

procedure TfrmPrincipal.mnuVendasClick(Sender: TObject);
var
  lFormulario: TfrmConsultaVenda;
begin
  lFormulario := TfrmConsultaVenda.Create(nil);
  try
    lFormulario.pnlTitulo.color := StringToColor(Cor);
    lFormulario.pnlBotoes.color := StringToColor(Cor);

    lFormulario.ShowModal;
  finally
    lFormulario.Free;
  end;
end;

procedure TfrmPrincipal.mnuProdutoClick(Sender: TObject);
var
  lFormulario: TfrmConsultaProduto;
begin
  lFormulario := TfrmConsultaProduto.Create(nil);
  try
    lFormulario.pnlTitulo.color := StringToColor(Cor);
    lFormulario.pnlBotoes.color := StringToColor(Cor);

    lFormulario.ShowModal;
  finally
    lFormulario.Free;
  end;
end;

procedure TfrmPrincipal.mnuUnidadeClick(Sender: TObject);
var
  lFormulario: TfrmConsultaUnidade;
begin
  lFormulario := TfrmConsultaUnidade.Create(nil);
  try
    lFormulario.pnlTitulo.color := StringToColor(Cor);
    lFormulario.pnlBotoes.color := StringToColor(Cor);

    lFormulario.ShowModal;
  finally
    lFormulario.Free;
  end;
end;

procedure TfrmPrincipal.mnuUsuarioRelatClick(Sender: TObject);
var
  lFormulario: TfrmFiltroUsuario;
begin
  lFormulario := TfrmFiltroUsuario.Create(nil);
  try
    lFormulario.pnlTitulo.color := StringToColor(Cor);
    lFormulario.pnlBotoes.color := StringToColor(Cor);

    lFormulario.ShowModal;
  finally
    lFormulario.Free;
  end;
end;

procedure TfrmPrincipal.mnuClienteRelatClick(Sender: TObject);
var
  lFormulario: TfrmFiltroCliente;
begin
  lFormulario := TfrmFiltroCliente.Create(nil);
  try
    lFormulario.pnlTitulo.color := StringToColor(Cor);
    lFormulario.pnlBotoes.color := StringToColor(Cor);

    lFormulario.ShowModal;
  finally
    lFormulario.Free;
  end;
end;

procedure TfrmPrincipal.mnuVendedorRelatClick(Sender: TObject);
var
  lFormulario: TfrmFiltroVendedor;
begin
  lFormulario := TfrmFiltroVendedor.Create(nil);
  try
    lFormulario.pnlTitulo.color := StringToColor(Cor);
    lFormulario.pnlBotoes.color := StringToColor(Cor);

    lFormulario.ShowModal;
  finally
    lFormulario.Free;
  end;
end;

procedure TfrmPrincipal.mnuProdutoRelatClick(Sender: TObject);
var
  lFormulario: TfrmFiltroProduto;
begin
  lFormulario := TfrmFiltroProduto.Create(nil);
  try
    lFormulario.pnlTitulo.color := StringToColor(Cor);
    lFormulario.pnlBotoes.color := StringToColor(Cor);

    lFormulario.ShowModal;
  finally
    lFormulario.Free;
  end;
end;

procedure TfrmPrincipal.mnuUnidadeRelatClick(Sender: TObject);
var
  lRelatorio: TfrmRelatorioUnidade;
begin
  lRelatorio := TfrmRelatorioUnidade.Create(nil);
  try
    lRelatorio.DataSource1.DataSet := lRelatorio.qryRelatorio;
    lRelatorio.rlpRelatorio.datasource := lRelatorio.DataSource1;

    lRelatorio.qryRelatorio.close;
    lRelatorio.qryRelatorio.SQL.clear;
    lRelatorio.qryRelatorio.SQL.Add('SELECT * FROM UNIDADE');

    lRelatorio.qryRelatorio.Open;

    lRelatorio.rlpRelatorio.preview;
  finally
    lRelatorio.Free;
  end;
end;

procedure TfrmPrincipal.mnuFPagamentoRelatClick(Sender: TObject);
var
  lRelatorio: TfrmRelatorioFPagamento;
begin
  lRelatorio := TfrmRelatorioFPagamento.Create(nil);
  try
    lRelatorio.DataSource1.DataSet := lRelatorio.qryRelatorio;
    lRelatorio.rlpRelatorio.datasource := lRelatorio.DataSource1;

    lRelatorio.qryRelatorio.close;
    lRelatorio.qryRelatorio.SQL.clear;
    lRelatorio.qryRelatorio.SQL.Add('SELECT * FROM FORMAPAGAMENTO');

    lRelatorio.qryRelatorio.Open;

    lRelatorio.rlpRelatorio.preview;
  finally
    lRelatorio.Free;
  end;
end;

procedure TfrmPrincipal.mnuVendaRelatClick(Sender: TObject);
var
  lFormulario: TfrmConsultaVenda;
begin
  lFormulario := TfrmConsultaVenda.Create(nil);
  try

    lFormulario.btnIncluir.visible := false;
    lFormulario.btnAlterar.visible := false;
    lFormulario.btnExcluir.visible := false;
    lFormulario.btnVisualizar.visible := false;
    lFormulario.btnAtualizar.visible := false;
    lFormulario.btnRelat.Caption := 'Selecionar';
    lFormulario.btnSair.Caption := 'Cancelar';
    lFormulario.btnRelat.SetFocus;
    lFormulario.ShowModal;
  finally
    lFormulario.Free;
  end;
end;

procedure TfrmPrincipal.Configurao1Click(Sender: TObject);
var
  lFormulario: TfrmConfig;
begin
  lFormulario := TfrmConfig.Create(nil);
  try
    lFormulario.Login := FLogin;
    lFormulario.Senha := FSenha;

    lConfig.CarregaUsuarioAcessando(FLogin, FSenha);
    lConfig.CarregaRestricoesBanco;

    lFormulario.ColorBox.Selected := StringToColor(Cor);
    lFormulario.pnlTitulo.color := StringToColor(Cor);
    lFormulario.pnlBotoes.color := StringToColor(Cor);
    lFormulario.pnlTituloModulos.color := StringToColor(Cor);
    lFormulario.pnlModulos.color := StringToColor(Cor);
    lFormulario.pnlCRUD.color := StringToColor(Cor);

    lFormulario.edtNAcessoModulos.Text := IntToStr(lConfig.MODULO);
    lFormulario.edtModUsuario.Text := IntToStr(lConfig.FORMUSUARIO);
    lFormulario.edtModCliente.Text := IntToStr(lConfig.FORMCLIENTE);
    lFormulario.edtModVendedor.Text := IntToStr(lConfig.FORMVENDEDOR);
    lFormulario.edtModProduto.Text := IntToStr(lConfig.FORMPRODUTO);
    lFormulario.edtModUnidade.Text := IntToStr(lConfig.FORMUNIDADE);
    lFormulario.edtModFPagamento.Text := IntToStr(lConfig.FORMFPAGAMENTO);
    lFormulario.edtModVenda.Text := IntToStr(lConfig.FORMVENDA);

    lFormulario.edtIncluir.Text := IntToStr(lConfig.INCLUIR);
    lFormulario.edtAlterar.Text := IntToStr(lConfig.ALTERAR);
    lFormulario.edtExcluir.Text := IntToStr(lConfig.EXCLUIR);
    lFormulario.edtVisualizar.Text := IntToStr(lConfig.VISUALIZAR);
    lFormulario.edtRelatorio.Text := IntToStr(lConfig.RELATORIO);

    lFormulario.ShowModal;

    lConfig.CarregaUsuarioAcessando(FLogin, FSenha);
    Cor := lConfig.CONFIGCOR;
    pnlTitulo.color := StringToColor(Cor);
    pnlRodape.color := StringToColor(Cor);

  finally
    lFormulario.Free;
  end;
end;

procedure TfrmPrincipal.PintaPainelComCorUsuario(pPanel: TPanel);
begin
  pPanel.color := StringToColor(FCor);
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  WindowState := wsMaximized;
  lConfig.CarregaUsuarioAcessando(FLogin, FSenha);
  FId := lConfig.CONFIGID;
  FNAcesso := lConfig.CONFIGNACESSO;
  FCor := lConfig.CONFIGCOR;
  SetaVisibleBtnCliente;
  PintaPainelComCorUsuario(pnlTitulo);
  PintaPainelComCorUsuario(pnlRodape);
end;

procedure TfrmPrincipal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

end.
