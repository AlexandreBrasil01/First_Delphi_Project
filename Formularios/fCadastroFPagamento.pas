unit fCadastroFPagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastroDefault, Vcl.StdCtrls,
  Vcl.ExtCtrls, uFPagamento;

type
  TfrmCadastroFPagamento = class(TfmrCadastroDefault)
    edtID: TEdit;
    edtDescricao: TEdit;
    lblDescricao: TLabel;
    lblID: TLabel;
    rdgTipo: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
    procedure IncluirFPagamento;
    procedure AlterarFPagamento;
  public
    { Public declarations }
    TipoRotina: String;
  end;

var
  frmCadastroFPagamento: TfrmCadastroFPagamento;

implementation

{$R *.dfm}

procedure TfrmCadastroFPagamento.IncluirFPagamento;
var
  lFPagamento: TFPagamento;
begin
  lFPagamento := TFPagamento.Create;
  try
    lFPagamento.ID := StrToInt(edtID.Text);
    lFPagamento.DESCRICAO := edtDescricao.Text;
    case rdgTipo.ItemIndex of
      0:
        begin
          lFPagamento.TIPO := 'A';
        end;
      1:
        begin
          lFPagamento.TIPO := 'P';
        end;
    end;
    lFPagamento.Incluir(true);
  finally
    lFPagamento.Free;
  end;
end;

procedure TfrmCadastroFPagamento.AlterarFPagamento;
var
  lFPagamento: TFPagamento;
begin
  lFPagamento := TFPagamento.Create;
  try
    lFPagamento.ID := StrToInt(edtID.Text);
    lFPagamento.DESCRICAO := edtDescricao.Text;
    case rdgTipo.ItemIndex of
      0:
        begin
          lFPagamento.TIPO := 'A';
        end;
      1:
        begin
          lFPagamento.TIPO := 'P';
        end;
    end;
    lFPagamento.Alterar(true);
  finally
    lFPagamento.Free;
  end;
end;

procedure TfrmCadastroFPagamento.btnSalvarClick(Sender: TObject);
var
  lFPagamento: TFPagamento;
begin
  lFPagamento := TFPagamento.Create;
  try
    if trim(edtDescricao.Text) = emptystr then
    begin
      ShowMessage
        ('A Forma de Pagamento precisa de uma Descrição para a conclusão do cadastro.');
      edtDescricao.SetFocus;
    end
    else if TipoRotina = 'Incluir' then
    begin
      IncluirFPagamento;
      close;
    end
    else if TipoRotina = 'Alterar' then
    begin
      AlterarFPagamento;
      close;
    end;
  finally
    lFPagamento.Free;
  end;
end;

procedure TfrmCadastroFPagamento.FormShow(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmCadastroFPagamento.btnSairClick(Sender: TObject);
begin
  Close;
end;

end.
