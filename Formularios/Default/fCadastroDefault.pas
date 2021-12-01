unit fCadastroDefault;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls, dConexao;

type
  TfmrCadastroDefault = class(TForm)
    pnlTitulo: TPanel;
    pnlCentral: TPanel;
    pnlBotoes: TPanel;
    btnSair: TButton;
    btnSalvar: TButton;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }

  end;

implementation

{$R *.dfm}

procedure TfmrCadastroDefault.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfmrCadastroDefault.FormShow(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

end.
