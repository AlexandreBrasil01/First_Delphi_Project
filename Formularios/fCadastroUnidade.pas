unit fCadastroUnidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  fCadastroDefault, Vcl.StdCtrls, Vcl.ExtCtrls, uUnidade;

type
  TfrmCadastroUnidade = class(TfmrCadastroDefault)
    lblID: TLabel;
    lblDescricao: TLabel;
    edtID: TEdit;
    edtDescricao: TEdit;
    edtUnidade: TEdit;
    lblUnidade: TLabel;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure IncluirUnidade;
    procedure AlterarUnidade;
  public
    { Public declarations }
    TipoRotina: String;
  end;

var
  frmCadastroUnidade: TfrmCadastroUnidade;

implementation

{$R *.dfm}

procedure TfrmCadastroUnidade.IncluirUnidade;
var
  lUnidade: TUnidade;
begin
  lUnidade := TUnidade.Create;
  try
    lUnidade.DESCRICAO := edtDescricao.Text;
    lUnidade.UNIDADE := edtUnidade.Text;
    lUnidade.Incluir(true);
  finally
    lUnidade.Free;
  end;
end;

procedure TfrmCadastroUnidade.AlterarUnidade;
var
  lUnidade: TUnidade;
begin
  lUnidade := TUnidade.Create;
  try
    lUnidade.DESCRICAO := edtDescricao.Text;
    lUnidade.UNIDADE := edtUnidade.Text;
    lUnidade.Alterar(true);
  finally
    lUnidade.Free;
  end;
end;

procedure TfrmCadastroUnidade.btnSalvarClick(Sender: TObject);
var
  lUnidade: TUnidade;
begin
  lUnidade := TUnidade.Create;
  try
    if trim(edtDescricao.Text) = emptystr then
    begin
      ShowMessage
        ('A Unidade precisa de uma Descrição para a conclusão do cadastro.');
      edtDescricao.SetFocus;
    end
    else if trim(edtUnidade.Text) = emptystr then
    begin
      ShowMessage
        ('É necessário uma unidade de medida para a conclusão do cadastro.');
      edtUnidade.SetFocus;
    end
    else if TipoRotina = 'Incluir' then
    begin
      IncluirUnidade;
      close;
    end
    else if TipoRotina = 'Alterar' then
    begin
      AlterarUnidade;
      close;
    end;
  finally
    lUnidade.Free;
  end;
end;

procedure TfrmCadastroUnidade.FormShow(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmCadastroUnidade.btnSairClick(Sender: TObject);
begin
  close;
end;

end.
