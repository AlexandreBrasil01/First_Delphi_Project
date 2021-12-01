unit fCadastroVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastroDefault, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfrmCadastroVenda = class(TfmrCadastroDefault)
    edtDesconto: TEdit;
    edtTotal: TEdit;
    memoObs: TMemo;
    edtFormaPagamento: TEdit;
    edtVendedor: TEdit;
    edtCliente: TEdit;
    dtpEmissao: TDateTimePicker;
    edtId: TEdit;
    lblId: TLabel;
    lblEmissao: TLabel;
    lblCliente: TLabel;
    lblVendedor: TLabel;
    lblMemo: TLabel;
    lblDesconto: TLabel;
    lblTotal: TLabel;
    lblFormaPagamento: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroVenda: TfrmCadastroVenda;

implementation

{$R *.dfm}

end.
