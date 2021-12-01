unit fLogin;

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
  FireDAC.Comp.Client,
  dConexao,
  fPrincipal,
  System.ImageList,
  Vcl.ImgList,
  uConfig;

type
  TfrmLogin = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    edtSenha: TEdit;
    edtLogin: TEdit;
    lblSenha: TLabel;
    lblLogin: TLabel;
    btnConfirmar: TButton;
    btnSair: TButton;
    imgSenha: TImageList;
    btnMostraSenha: TButton;
    procedure btnSairClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnMostraSenhaClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}
{ TfrmLogin }

procedure TfrmLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  edtLogin.SetFocus;
end;

procedure TfrmLogin.btnConfirmarClick(Sender: TObject);
var
  lConfig: TConfig;
  lFormulario: TfrmPrincipal;
  begin
  lConfig := TConfig.Create;
  lFormulario := TfrmPrincipal.Create(nil);
  try
    if Trim(edtLogin.Text) = emptyStr then
    begin
      ShowMessage('O campo usuário precisa ser preenchido.');
      edtLogin.SetFocus;
    end
    else if Trim(edtSenha.Text) = emptyStr then
    begin
      ShowMessage('O campo Senha precisa ser preenchido.');
      edtSenha.SetFocus;
    end
    else if lConfig.ValidaLogin(edtLogin.Text, edtSenha.Text) then
    begin
      lFormulario.Login := edtLogin.Text;
      lFormulario.Senha := edtSenha.Text;
      lFormulario.ShowModal;
      Close;
    end
    else
    begin
      ShowMessage('Usuário ou Senha está incorreto.');
      edtSenha.SetFocus;
    end;

  finally
    lConfig.Free;
    lFormulario.Free;
  end;
end;

procedure TfrmLogin.btnMostraSenhaClick(Sender: TObject);
begin
  if edtSenha.PasswordChar = '*' then
  begin
    btnMostraSenha.ImageIndex := 0;
    edtSenha.PasswordChar := #0;
  end
  else if edtSenha.PasswordChar = #0 then
  begin
    btnMostraSenha.ImageIndex := 1;
    edtSenha.PasswordChar := '*';
  end;
end;

procedure TfrmLogin.btnSairClick(Sender: TObject);
begin
  Close;
end;

end.
