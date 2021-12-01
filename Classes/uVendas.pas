unit uVendas;

interface

uses
  FireDAC.Comp.Client, dconexao, Vcl.Dialogs, System.SysUtils, Vcl.Controls,
  Vcl.Forms;

type
  TVendas = class
  private
    FID: integer;

    class var FObjetoBusca: TVendas;
  public
    destructor Destroy; override;
    procedure Inicializar;
    procedure Carrega;
    procedure Incluir(pEfetuarCommit: boolean);
    procedure Alterar(pEfetuarCommit: boolean);
    procedure Excluir(pEfetuarCommit: boolean);

    constructor Create;
    class property ObjetoBusca: TVendas read FObjetoBusca write FObjetoBusca;

    property ID: integer read FID write FID;

  end;

implementation

{ TClassDefault }

procedure TVendas.Carrega;
begin

end;

procedure TVendas.Incluir(pEfetuarCommit: boolean);
begin

end;

procedure TVendas.Alterar(pEfetuarCommit: boolean);
begin

end;

procedure TVendas.Excluir(pEfetuarCommit: boolean);
begin

end;

procedure TVendas.Inicializar;
begin

end;

constructor TVendas.Create;
begin

end;

destructor TVendas.Destroy;
begin

  inherited;
end;

end.
