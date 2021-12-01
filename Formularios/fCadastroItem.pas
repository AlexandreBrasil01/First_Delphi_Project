unit fCadastroItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastroDefault, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfrrCadastroItem = class(TfmrCadastroDefault)
    dtpEmissao: TDateTimePicker;
    edtId: TEdit;
    lblId: TLabel;
    lblEmissao: TLabel;
    edtProduto: TEdit;
    lblProduto: TLabel;
    Button2: TButton;
    edtDescricao: TEdit;
    lblDescricao: TLabel;
    Edit2: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frrCadastroItem: TfrrCadastroItem;

implementation

{$R *.dfm}

end.
