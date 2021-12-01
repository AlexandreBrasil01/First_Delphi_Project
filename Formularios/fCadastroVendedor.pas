unit fCadastroVendedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  fCadastroDefault, Vcl.StdCtrls, Vcl.ExtCtrls, uVendedor,
  uHelpersImagensBase64;

type
  TfrmCadastroVendedor = class(TfmrCadastroDefault)
    edtBairro: TEdit;
    edtCidade: TEdit;
    edtCep: TEdit;
    edtEndereco: TEdit;
    edtEmail: TEdit;
    edtNome: TEdit;
    edtId: TEdit;
    lblId: TLabel;
    lblNome: TLabel;
    lblEmail: TLabel;
    lblEndereco: TLabel;
    lblBairro: TLabel;
    lblCep: TLabel;
    lblCidade: TLabel;
    pnlImagem: TPanel;
    imgVendedor: TImage;
    procedure btnSairClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure IncluirVendedor;
    procedure AlterarVendedor;
  public
    { Public declarations }
    TipoRotina: String;
  end;

var
  frmCadastroVendedor: TfrmCadastroVendedor;

implementation

{$R *.dfm}

procedure TfrmCadastroVendedor.IncluirVendedor;
var
  lVendedor: TVendedor;
begin
  lVendedor := TVendedor.Create;
  try
    lVendedor.NOME := edtNome.Text;
    lVendedor.EMAIL := edtEmail.Text;
    lVendedor.CEP := edtCep.Text;
    lVendedor.CIDADE := edtCidade.Text;
    lVendedor.BAIRRO := edtBairro.Text;
    lVendedor.ENDERECO := edtEndereco.Text;
    lVendedor.FOTO := imgVendedor.Base64;
    lVendedor.Incluir(true);
  finally
    lVendedor.Free;
  end;
end;

procedure TfrmCadastroVendedor.AlterarVendedor;
var
  lVendedor: TVendedor;
begin
  lVendedor := TVendedor.Create;
  try
    lVendedor.ID := strtoint(edtId.Text);
    lVendedor.NOME := edtNome.Text;
    lVendedor.EMAIL := edtEmail.Text;
    lVendedor.CEP := edtCep.Text;
    lVendedor.CIDADE := edtCidade.Text;
    lVendedor.BAIRRO := edtBairro.Text;
    lVendedor.ENDERECO := edtEndereco.Text;
    lVendedor.FOTO := imgVendedor.Base64;
    lVendedor.Alterar(true);
  finally
    lVendedor.Free;
  end;
end;

procedure TfrmCadastroVendedor.btnSalvarClick(Sender: TObject);
begin
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
  else if trim(edtCep.Text) = emptyStr then
  begin
    showmessage
      ('O campo CEP precisa ser preenchido para a conclusão do cadastro.');
    edtCep.SetFocus;
  end
  else if Length(edtCep.Text) < 8 then
  begin
    showmessage
      ('O campo CEP precisa ser preenchido para a conclusão do cadastro.');
    edtCep.SetFocus;
  end
  else if trim(edtCidade.Text) = emptyStr then
  begin
    showmessage
      ('O campo Cidade precisa ser preenchido para a conclusão do cadastro.');
    edtCep.SetFocus;
  end
  else if trim(edtBairro.Text) = emptyStr then
  begin
    showmessage
      ('O campo Bairro precisa ser preenchido para a conclusão do cadastro.');
    edtBairro.SetFocus;
  end
  else if trim(edtEndereco.Text) = emptyStr then
  begin
    showmessage
      ('O campo Endereço precisa ser preenchido para a conclusão do cadastro.');
    edtEndereco.SetFocus;
  end
  else if TipoRotina = 'Incluir' then
  begin
    IncluirVendedor;
    Close;
  end
  else if TipoRotina = 'Alterar' then
  begin
    AlterarVendedor;
    Close;
  end;
end;

procedure TfrmCadastroVendedor.FormShow(Sender: TObject);
begin
  WindowState := wsMaximized;
  imgVendedor.Stretch := false;
  imgVendedor.Proportional := true;
  imgVendedor.Center := true;

  if TipoRotina = 'Incluir' then
  begin
    imgVendedor.Popup;
    edtNome.SetFocus;
  end
  else if TipoRotina = 'Alterar' then
  begin
    imgVendedor.Popup;
    edtNome.SetFocus;
  end
  else
  begin
    btnSair.SetFocus;
  end;
end;

procedure TfrmCadastroVendedor.btnSairClick(Sender: TObject);
begin
  Close;
end;

end.
