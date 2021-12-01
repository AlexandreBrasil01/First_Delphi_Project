unit uClasDefault;

interface

uses
  FireDAC.Comp.Client, dconexao, Vcl.Dialogs, System.SysUtils, Vcl.Controls,
  Vcl.Forms;

type
  TClasDefault = class
  private
    FID: integer;

    class var FObjetoBusca: TClasDefault;
  public
    destructor Destroy; override;
    procedure Inicializar;
    procedure Carrega;
    procedure Incluir(pEfetuarCommit: boolean);
    procedure Alterar(pEfetuarCommit: boolean);
    procedure Excluir(pEfetuarCommit: boolean);

    constructor Create;
    class property ObjetoBusca: TClasDefault read FObjetoBusca write FObjetoBusca;

    property ID: integer read FID write FID;

  end;

implementation

{ TClassDefault }

procedure TClasDefault.Carrega;
begin

end;

procedure TClasDefault.Incluir(pEfetuarCommit: boolean);
begin

end;

procedure TClasDefault.Alterar(pEfetuarCommit: boolean);
begin

end;

procedure TClasDefault.Excluir(pEfetuarCommit: boolean);
begin

end;

procedure TClasDefault.Inicializar;
begin

end;

constructor TClasDefault.Create;
begin

end;

destructor TClasDefault.Destroy;
begin

  inherited;
end;

end.
