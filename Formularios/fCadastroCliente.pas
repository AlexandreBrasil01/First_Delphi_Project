unit fCadastroCliente;

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
  dConexao,
  uCliente,
  uHelpersImagensBase64;

type
  TfrmCadastroCliente = class(TForm)
    pnlTitulo: TPanel;
    pnlGrid: TPanel;
    pnlBotoes: TPanel;
    edtEmail: TEdit;
    btnSalvar: TButton;
    btnSair: TButton;
    edtNome: TEdit;
    edtCpfCnpj: TEdit;
    lblNome: TLabel;
    lblEmail: TLabel;
    cbxTipoFisJur: TComboBox;
    lblCpfCnpj: TLabel;
    lblEndereco: TLabel;
    lblBairro: TLabel;
    lblCep: TLabel;
    lblCidade: TLabel;
    edtCep: TEdit;
    edtCidade: TEdit;
    edtBairro: TEdit;
    edtEndereco: TEdit;
    edtID: TEdit;
    lblID: TLabel;
    pnlImagem: TPanel;
    imgCliente: TImage;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cbxTipoFisJurChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtNomeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    procedure IncluirCliente;
    procedure AlterarCliente;

  public
    { Public declarations }
    TipoRotina: String;
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

{$R *.dfm}
{ TfrmCadastroCliente }

procedure TfrmCadastroCliente.cbxTipoFisJurChange(Sender: TObject);
begin
  edtCpfCnpj.clear;
  if cbxTipoFisJur.ItemIndex = 0 then
  begin
    lblCpfCnpj.Caption := 'CPF';
    edtCpfCnpj.MaxLength := 11;
  end
  else if cbxTipoFisJur.ItemIndex = 1 then
  begin
    lblCpfCnpj.Caption := 'CNPJ';
    edtCpfCnpj.MaxLength := 14;
  end;
end;

procedure TfrmCadastroCliente.edtNomeKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['a' .. 'z', #32, #8]) then
    Key := #0;
  if Key in ['.'] then
    Key := #44;
end;

procedure TfrmCadastroCliente.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmCadastroCliente.IncluirCliente;
var
  lCliente: TCliente;
begin
  lCliente := TCliente.Create;
  try
    lCliente.NOME := edtNome.Text;
    lCliente.EMAIL := edtEmail.Text;
    case cbxTipoFisJur.ItemIndex of
      0:
        begin
          lCliente.CPF := edtCpfCnpj.Text;
          lCliente.CNPJ := emptyStr;
          lCliente.FISICOOUJURIDICO := 'F';
        end;
      1:
        begin
          lCliente.CPF := emptyStr;
          lCliente.CNPJ := edtCpfCnpj.Text;
          lCliente.FISICOOUJURIDICO := 'J';
        end;
    end;
    lCliente.CEP := edtCep.Text;
    lCliente.CIDADE := edtCidade.Text;
    lCliente.BAIRRO := edtBairro.Text;
    lCliente.ENDERECO := edtEndereco.Text;
    lCliente.FOTO := imgCliente.Base64;
    lCliente.Incluir(true);
  finally
    lCliente.Free;
  end;
end;

procedure TfrmCadastroCliente.AlterarCliente;
var
  lCliente: TCliente;
begin
  lCliente := TCliente.Create;
  try
    lCliente.Id := StrToInt(edtID.Text);
    lCliente.NOME := edtNome.Text;
    lCliente.EMAIL := edtEmail.Text;
    case cbxTipoFisJur.ItemIndex of
      0:
        begin
          lCliente.CPF := edtCpfCnpj.Text;
          lCliente.CNPJ := emptyStr;
          lCliente.FISICOOUJURIDICO := 'F';
        end;
      1:
        begin
          lCliente.CPF := emptyStr;
          lCliente.CNPJ := edtCpfCnpj.Text;
          lCliente.FISICOOUJURIDICO := 'J';
        end;
    end;
    lCliente.CEP := edtCep.Text;
    lCliente.CIDADE := edtCidade.Text;
    lCliente.BAIRRO := edtBairro.Text;
    lCliente.ENDERECO := edtEndereco.Text;
    lCliente.FOTO := imgCliente.Base64;
    lCliente.Alterar(true);
  finally
    lCliente.Free;
  end;
end;

procedure TfrmCadastroCliente.btnSalvarClick(Sender: TObject);
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
  else if Length(edtCep.Text) < 8 then
  begin
    showmessage('Este CEP é invalido, favor conferir digitação.');
    edtCep.SetFocus;
  end
  else if cbxTipoFisJur.ItemIndex = 0 then
  begin
    if trim(edtCpfCnpj.Text) = emptyStr then
    begin
      showmessage
        ('O campo CPF precisa ser preenchido para a conclusão do cadastro.');
      edtCpfCnpj.SetFocus;
    end
    else if not(TCliente.ValidaCPF(edtCpfCnpj.Text)) then
    begin
      showmessage('Este CPF é inválido, favor conferir digitação!');
      edtCpfCnpj.SetFocus;
    end
    else
    begin
      begin
        if TipoRotina = 'Incluir' then
        begin
          IncluirCliente;
        end
        else if TipoRotina = 'Alterar' then
        begin
          AlterarCliente;
        end;
        close;
      end;
    end;
  end
  else if cbxTipoFisJur.ItemIndex = 1 then
  begin
    if trim(edtCpfCnpj.Text) = emptyStr then
    begin
      showmessage
        ('O campo CNPJ precisa ser preenchido para a conclusão do cadastro.');
      edtCpfCnpj.SetFocus;
    end
    else if not(TCliente.ValidaCNPJ(edtCpfCnpj.Text)) then
    begin
      showmessage('Este CNPJ é inválido, favor conferir digitação!');
      edtCpfCnpj.SetFocus;
    end
    else
    begin
      begin
        if TipoRotina = 'Incluir' then
        begin
          IncluirCliente;
        end
        else if TipoRotina = 'Alterar' then
        begin
          AlterarCliente;
        end;
        close;
      end;
    end;
  end;
end;

procedure TfrmCadastroCliente.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure TfrmCadastroCliente.FormShow(Sender: TObject);
begin
  WindowState := wsMaximized;

  if TipoRotina = 'Incluir' then
  begin
    imgCliente.Popup;
    edtNome.SetFocus;
  end
  else if TipoRotina = 'Alterar' then
  begin
    imgCliente.Popup;
    edtNome.SetFocus;
  end
  else
  begin
    btnSair.SetFocus;
  end;

  if cbxTipoFisJur.ItemIndex = 0 then
  begin
    lblCpfCnpj.Caption := 'CPF';
    edtCpfCnpj.MaxLength := 11;
  end
  else if cbxTipoFisJur.ItemIndex = 1 then
  begin
    lblCpfCnpj.Caption := 'CNPJ';
    edtCpfCnpj.MaxLength := 14;
  end;
  imgCliente.Stretch := false;
  imgCliente.Proportional := false;
  imgCliente.Center := true;
end;

end.
