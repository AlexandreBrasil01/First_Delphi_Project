unit fFiltroDefault;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmFiltroDefault = class(TForm)
    pnlTitulo: TPanel;
    Panel2: TPanel;
    pnlBotoes: TPanel;
    btnVisualizar: TButton;
    btnLimpar: TButton;
    cbxListaTodos: TCheckBox;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFiltroDefault: TfrmFiltroDefault;

implementation

{$R *.dfm}

procedure TfrmFiltroDefault.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

end.
