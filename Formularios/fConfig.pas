unit fConfig;

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
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  uConfig;

type
  TfrmConfig = class(TForm)
    pnlTitulo: TPanel;
    pnlBotoes: TPanel;
    Panel2: TPanel;
    btnSalvar: TButton;
    btnCancelar: TButton;
    pgcConfig: TPageControl;
    tbsGeral: TTabSheet;
    tbsModulo: TTabSheet;
    pnlModulos: TPanel;
    Label2: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    edtModUsuario: TEdit;
    edtModCliente: TEdit;
    edtModVendedor: TEdit;
    edtModProduto: TEdit;
    edtModUnidade: TEdit;
    edtModFPagamento: TEdit;
    edtModVenda: TEdit;
    pnlCRUD: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edtIncluir: TEdit;
    edtAlterar: TEdit;
    edtExcluir: TEdit;
    edtVisualizar: TEdit;
    edtRelatorio: TEdit;
    pnlTituloModulos: TPanel;
    Panel4: TPanel;
    ColorBox: TColorBox;
    Label1: TLabel;
    edtNAcessoModulos: TEdit;
    btnConfirmaModulo: TButton;
    btnConfirmaCRUD: TButton;
    btnAplicar: TButton;
    lblRestringeModulo: TLabel;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnConfirmaModuloClick(Sender: TObject);
    procedure edtModUsuarioExit(Sender: TObject);
    procedure edtModClienteExit(Sender: TObject);
    procedure edtModVendedorExit(Sender: TObject);
    procedure edtModProdutoExit(Sender: TObject);
    procedure edtModUnidadeExit(Sender: TObject);
    procedure edtModFPagamentoExit(Sender: TObject);
    procedure edtModVendaExit(Sender: TObject);
    procedure edtIncluirExit(Sender: TObject);
    procedure edtAlterarExit(Sender: TObject);
    procedure edtExcluirExit(Sender: TObject);
    procedure edtVisualizarExit(Sender: TObject);
    procedure edtRelatorioExit(Sender: TObject);
    procedure btnConfirmaCRUDClick(Sender: TObject);
    procedure btnAplicarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
    FLogin: String;
    FSenha: String;
    procedure NaoDeixaCampoEmBranco(pEdit: TEdit);
    procedure RestringeAcessoModulos;
  public
    { Public declarations }
    property Login: String read FLogin write FLogin;
    property Senha: String read FSenha write FSenha;
  end;

var
  frmConfig: TfrmConfig;

implementation

{$R *.dfm}

procedure TfrmConfig.RestringeAcessoModulos;
begin
  if lConfig.MODULO < lConfig.CONFIGNACESSO then
  begin
    tbsModulo.TabVisible := false;
    lblRestringeModulo.visible := false;
    edtNAcessoModulos.visible := false;
  end;
end;

procedure TfrmConfig.btnAplicarClick(Sender: TObject);
begin
  pnlTitulo.Color := ColorBox.selected;
  pnlBotoes.Color := ColorBox.selected;
  pnlTituloModulos.Color := ColorBox.selected;
  pnlModulos.Color := ColorBox.selected;
  pnlCRUD.Color := ColorBox.selected;

  lConfig.MODULO := StrToInt(edtNAcessoModulos.Text);
end;

procedure TfrmConfig.btnCancelarClick(Sender: TObject);
begin
  close;
end;

procedure TfrmConfig.btnConfirmaCRUDClick(Sender: TObject);
begin
  lConfig.Incluir := StrToInt(edtIncluir.Text);
  lConfig.Alterar := StrToInt(edtAlterar.Text);
  lConfig.Excluir := StrToInt(edtExcluir.Text);
  lConfig.Visualizar := StrToInt(edtVisualizar.Text);
  lConfig.Relatorio := StrToInt(edtRelatorio.Text);
  btnSalvar.SetFocus;
end;

procedure TfrmConfig.btnConfirmaModuloClick(Sender: TObject);
begin
  lConfig.FORMUSUARIO := StrToInt(edtModUsuario.Text);
  lConfig.FORMCLIENTE := StrToInt(edtModCliente.Text);
  lConfig.FORMVENDEDOR := StrToInt(edtModVendedor.Text);
  lConfig.FORMPRODUTO := StrToInt(edtModProduto.Text);
  lConfig.FORMUNIDADE := StrToInt(edtModUnidade.Text);
  lConfig.FORMFPAGAMENTO := StrToInt(edtModFPagamento.Text);
  lConfig.FORMVENDEDOR := StrToInt(edtModVendedor.Text);
  lConfig.FORMVENDA := StrToInt(edtModVenda.Text);
  edtIncluir.SetFocus;
end;

procedure TfrmConfig.btnSalvarClick(Sender: TObject);
begin
  lConfig.CarregaCorProBanco(pnlTitulo.Color);
  lConfig.SobeRestricoesBanco(true);
  close;
end;

procedure TfrmConfig.NaoDeixaCampoEmBranco(pEdit: TEdit);
begin
  if pEdit.Text = EmptyStr then
  begin
    ShowMessage('Não podem haver campos em branco');
    pEdit.Text := '0';
    pEdit.SetFocus;
  end;
end;

procedure TfrmConfig.edtIncluirExit(Sender: TObject);
begin
  NaoDeixaCampoEmBranco(edtIncluir);
end;

procedure TfrmConfig.edtAlterarExit(Sender: TObject);
begin
  NaoDeixaCampoEmBranco(edtAlterar);
end;

procedure TfrmConfig.edtExcluirExit(Sender: TObject);
begin
  NaoDeixaCampoEmBranco(edtExcluir);
end;

procedure TfrmConfig.edtVisualizarExit(Sender: TObject);
begin
  NaoDeixaCampoEmBranco(edtVisualizar);
end;

procedure TfrmConfig.edtRelatorioExit(Sender: TObject);
begin
  NaoDeixaCampoEmBranco(edtRelatorio);
end;

procedure TfrmConfig.edtModClienteExit(Sender: TObject);
begin
  NaoDeixaCampoEmBranco(edtModCliente);
end;

procedure TfrmConfig.edtModFPagamentoExit(Sender: TObject);
begin
  NaoDeixaCampoEmBranco(edtModFPagamento);
end;

procedure TfrmConfig.edtModProdutoExit(Sender: TObject);
begin
  NaoDeixaCampoEmBranco(edtModProduto);
end;

procedure TfrmConfig.edtModUnidadeExit(Sender: TObject);
begin
  NaoDeixaCampoEmBranco(edtModUnidade);
end;

procedure TfrmConfig.edtModUsuarioExit(Sender: TObject);
begin
  NaoDeixaCampoEmBranco(edtModUsuario);
end;

procedure TfrmConfig.edtModVendaExit(Sender: TObject);
begin
  NaoDeixaCampoEmBranco(edtModVenda);
end;

procedure TfrmConfig.edtModVendedorExit(Sender: TObject);
begin
  NaoDeixaCampoEmBranco(edtModVendedor);
end;

procedure TfrmConfig.FormShow(Sender: TObject);
begin
  WindowState := wsMaximized;
  pgcConfig.ActivePage := tbsGeral;
  RestringeAcessoModulos;
  lConfig.CarregaUsuarioAcessando(FLogin, FSenha);
end;

procedure TfrmConfig.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

end.
