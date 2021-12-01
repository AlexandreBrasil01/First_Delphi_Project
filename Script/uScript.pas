unit uScript;

interface

uses
  FireDAC.Comp.Client, dconexao, Vcl.Dialogs, System.SysUtils, Vcl.Controls,
  Vcl.Forms;

type
  TScript = class
  private
    class var FObjetoBusca: TScript;
    function VerificaSeATabelaEstaCriadaNoBanco(pTabela: string): Boolean;
    function VerificaSeOCampoEstaCriadoNoBanco(pCampo: array of string;
      pTabela: string): Boolean;
    function VerificaSeExisteOGenerator(pNomeGenerator: string): Boolean;
    function VerificaSeExisteATrigger(pNomeTrigger: string): Boolean;
    function VerificaSeExisteProcedure(pNomeProcedure: string): Boolean;
    function VerificaSeExisteFunction(pNomeFunction: string): Boolean;
    function VerificaSeExisteAConstraint(pNome: string): Boolean;
    function VerificaSeExisteOIndice(pNome: string): Boolean;
  public
    destructor Destroy; override;
    procedure Inicializar;
    constructor Create;
    class property ObjetoBusca: TScript read FObjetoBusca write FObjetoBusca;

  end;

implementation

{ TClassDefault }

constructor TScript.Create;
begin

end;

destructor TScript.Destroy;
begin

  inherited;
end;

procedure TScript.Inicializar;
begin
  //
end;



function TScript.VerificaSeATabelaEstaCriadaNoBanco(pTabela: string): Boolean;
begin

end;

function TScript.VerificaSeExisteAConstraint(pNome: string): Boolean;
begin

end;

function TScript.VerificaSeExisteATrigger(pNomeTrigger: string): Boolean;
begin

end;

function TScript.VerificaSeExisteFunction(pNomeFunction: string): Boolean;
begin

end;

function TScript.VerificaSeExisteOGenerator(pNomeGenerator: string): Boolean;
begin

end;

function TScript.VerificaSeExisteOIndice(pNome: string): Boolean;
begin

end;

function TScript.VerificaSeExisteProcedure(pNomeProcedure: string): Boolean;
begin

end;

function TScript.VerificaSeOCampoEstaCriadoNoBanco(pCampo: array of string; pTabela: string): Boolean;
begin

end;

end.
