unit fCadastroUsuario;

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
  fCadastroDefault,
  uUsuario,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  uHelpersImagensBase64;

type
  TfrmCadastroUsuario = class(TfmrCadastroDefault)
    lblID: TLabel;
    edtID: TEdit;
    lblNome: TLabel;
    lblLogIn: TLabel;
    lblSenha: TLabel;
    lblEmail: TLabel;
    lblNivelAceso: TLabel;
    edtNome: TEdit;
    edtLogin: TEdit;
    edtSenha: TEdit;
    edtEmail: TEdit;
    edtNivelAcesso: TEdit;
    pnlImagem: TPanel;
    imgUsuario: TImage;
    procedure btnSairClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    function ValidaEmail: boolean;
    function ValidaLogin: boolean;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure IncluirUsuario;
    procedure AlterarUsuario;
  public
    { Public declarations }
    TipoRotina: String;
    oldEmail: String;
    oldLogin: String;
  end;

var
  frmCadastroUsuario: TfrmCadastroUsuario;

implementation

{$R *.dfm}

function TfrmCadastroUsuario.ValidaLogin: boolean;
var
  lUsuario: TUsuario;
begin
  result := true;

  lUsuario := TUsuario.Create;
  try
    if oldLogin <> edtLogin.Text then
    begin
      if lUsuario.VerificaUnique('LOGIN', edtLogin.Text) then
      begin
        result := false;
      end;
    end;
  finally
    lUsuario.Free;
  end;
end;

function TfrmCadastroUsuario.ValidaEmail: boolean;
var
  lUsuario: TUsuario;
begin
  result := true;

  lUsuario := TUsuario.Create;
  try
    if oldEmail <> edtEmail.Text then
    begin
      if lUsuario.VerificaUnique('EMAIL', edtEmail.Text) then
      begin
        result := false;
      end;
    end;
  finally
    lUsuario.Free;
  end;

end;

procedure TfrmCadastroUsuario.IncluirUsuario;
var
  lUsuario: TUsuario;
begin
  lUsuario := TUsuario.Create;
  try
    lUsuario.NOME := edtNome.Text;
    lUsuario.LOGIN := edtLogin.Text;
    lUsuario.SENHA := edtSenha.Text;
    lUsuario.NIVELACESSO := StrToInt(edtNivelAcesso.Text);
    lUsuario.EMAIL := edtEmail.Text;
    lUsuario.FOTO := imgUsuario.Base64;
    lUsuario.Incluir(true);
  finally
    lUsuario.Free;
  end;
end;

procedure TfrmCadastroUsuario.AlterarUsuario;
var
  lUsuario: TUsuario;
begin
  lUsuario := TUsuario.Create;
  try
    lUsuario.NOME := edtNome.Text;
    lUsuario.LOGIN := edtLogin.Text;
    lUsuario.SENHA := edtSenha.Text;
    lUsuario.NIVELACESSO := StrToInt(edtNivelAcesso.Text);
    lUsuario.EMAIL := edtEmail.Text;
    lUsuario.FOTO := imgUsuario.Base64;
    lUsuario.Alterar(true);
  finally
    lUsuario.Free;
  end;
end;

procedure TfrmCadastroUsuario.btnSalvarClick(Sender: TObject);
var
  lUsuario: TUsuario;
begin
  lUsuario := TUsuario.Create;
  try
    if trim(edtNome.Text) = emptyStr then
    begin
      showmessage
        ('O campo Nome precisa ser preenchido para a conclusão do cadastro.');
      edtNome.SetFocus;
    end
    else if trim(edtEmail.Text) = emptyStr then
    begin
      showmessage
        ('O campo E-mail precisa ser preenchido para a conclusão do cadastro.');
      edtEmail.SetFocus;
    end
    else if trim(edtNivelAcesso.Text) = emptyStr then
    begin
      showmessage
        ('O usuário precisa de um Nível de acesso para a conclusão do cadastro.');
      edtNivelAcesso.SetFocus;
    end
    else if trim(edtLogin.Text) = emptyStr then
    begin
      showmessage
        ('O usuário precisa de um Login para a conclusão do cadastro.');
      edtLogin.SetFocus;
    end
    else if trim(edtSenha.Text) = emptyStr then
    begin
      showmessage
        ('O usuário precisa de uma Senha para a conclusão do cadastro.');
      edtSenha.SetFocus;
    end
    else if TipoRotina = 'Incluir' then
    begin
      if lUsuario.VerificaUnique('EMAIL', edtEmail.Text) then
      begin
        MessageDlg('Este Email ja está em uso, tente outro', mtError,
          [mbOK], 0);
        edtEmail.SetFocus;
      end
      else if lUsuario.VerificaUnique('LOGIN', edtLogin.Text) then
      begin
        MessageDlg('Este Login ja está em uso, tente outro', mtError,
          [mbOK], 0);
        edtLogin.SetFocus;
      end
      else
      begin
        IncluirUsuario;
        close;
      end;
    end
    else if TipoRotina = 'Alterar' then
    begin
      if not(ValidaEmail) then
      begin
        MessageDlg('Este Email ja está em uso, tente outro', mtError,
          [mbOK], 0);
        edtEmail.SetFocus;
      end
      else if not(ValidaLogin) then
      begin
        MessageDlg('Este Login ja está em uso, tente outro', mtError,
          [mbOK], 0);
        edtLogin.SetFocus;
      end
      else
      begin
        AlterarUsuario;
        close;
      end;
    end;
  finally
    lUsuario.Free;
  end;
end;

procedure TfrmCadastroUsuario.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure TfrmCadastroUsuario.FormShow(Sender: TObject);
begin
  WindowState := wsMaximized;
  if TipoRotina = 'Incluir' then
  begin
    imgUsuario.Popup;
    edtNome.SetFocus;
  end
  else if TipoRotina = 'Alterar' then
  begin
    imgUsuario.Popup;
    edtNome.SetFocus;
  end
  else
  begin
    btnsair.SetFocus;
  end;
  imgUsuario.Stretch := false;
  imgUsuario.Proportional := false;
  imgUsuario.Center := true;
end;

end.
