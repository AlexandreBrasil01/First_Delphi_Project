unit uConfig;

interface

uses
  FireDAC.Comp.Client,
  dconexao,
  Vcl.Dialogs,
  System.SysUtils,
  Vcl.Controls,
  Vcl.Forms,
  uUsuario,
  Vcl.Graphics,
  Vcl.ExtCtrls;

type
  TConfig = class
  private
    FCONFIGID: integer;
    FCONFIGNOME: string;
    FCONFIGLOGIN: string;
    FCONFIGSENHA: string;
    FCONFIGNACESSO: integer;
    FCONFIGCOR: string;

    FMODULO: integer;
    FFORMUSUARIO: integer;
    FFORMCLIENTE: integer;
    FFORMVENDEDOR: integer;
    FFORMPRODUTO: integer;
    FFORMUNIDADE: integer;
    FFORMFPAGAMENTO: integer;
    FFORMVENDA: integer;

    FINCLUIR: integer;
    FALTERAR: integer;
    FEXCLUIR: integer;
    FVISUALIZAR: integer;
    FRELATORIO: integer;

    class var FObjetoBusca: TConfig;

  public
    destructor Destroy; override;
    constructor Create;
    procedure Inicializar;
    procedure CarregaCorProBanco(pCor: TColor);
    procedure CarregaUsuarioAcessando(pLogin, pSenha: String);
    procedure CarregaRestricoesBanco;
    procedure SobeRestricoesBanco(pEfetuarCommit: boolean);
    function ValidaLogin(pLogin, pSenha: String): boolean;

    // Vriaveis que salvam os dados de quem logou;
    property CONFIGID: integer read FCONFIGID write FCONFIGID;
    property CONFIGNOME: string read FCONFIGNOME write FCONFIGNOME;
    property CONFIGLOGIN: string read FCONFIGLOGIN write FCONFIGLOGIN;
    property CONFIGSENHA: string read FCONFIGSENHA write FCONFIGSENHA;
    property CONFIGNACESSO: integer read FCONFIGNACESSO write FCONFIGNACESSO;
    property CONFIGCOR: string read FCONFIGCOR write FCONFIGCOR;

    // Variaveis que salvam as restrições do Modulo;
    property MODULO: integer read FMODULO write FMODULO;
    property FORMUSUARIO: integer read FFORMUSUARIO write FFORMUSUARIO;
    property FORMCLIENTE: integer read FFORMCLIENTE write FFORMCLIENTE;
    property FORMVENDEDOR: integer read FFORMVENDEDOR write FFORMVENDEDOR;
    property FORMPRODUTO: integer read FFORMPRODUTO write FFORMPRODUTO;
    property FORMUNIDADE: integer read FFORMUNIDADE write FFORMUNIDADE;
    property FORMFPAGAMENTO: integer read FFORMFPAGAMENTO write FFORMFPAGAMENTO;
    property FORMVENDA: integer read FFORMVENDA write FFORMVENDA;

    // Variaveis que salvam as restrições do CRUD;
    property INCLUIR: integer read FINCLUIR write FINCLUIR;
    property ALTERAR: integer read FALTERAR write FALTERAR;
    property EXCLUIR: integer read FEXCLUIR write FEXCLUIR;
    property VISUALIZAR: integer read FVISUALIZAR write FVISUALIZAR;
    property RELATORIO: integer read FRELATORIO write FRELATORIO;

    class property ObjetoBusca: TConfig read FObjetoBusca write FObjetoBusca;
  end;

var
  lConfig: TConfig;

implementation

{ TClassDefault }

procedure TConfig.Inicializar;
begin
  FCONFIGID := 0;
  FCONFIGNOME := '';
  FCONFIGLOGIN := '';
  FCONFIGSENHA := '';
  FCONFIGNACESSO := 0;
  FCONFIGCOR := '';

  FMODULO := 0;
  FFORMUSUARIO := 0;
  FFORMCLIENTE := 0;
  FFORMVENDEDOR := 0;
  FFORMPRODUTO := 0;
  FFORMUNIDADE := 0;
  FFORMFPAGAMENTO := 0;
  FFORMVENDA := 0;

  FINCLUIR := 0;
  FALTERAR := 0;
  FEXCLUIR := 0;
  FVISUALIZAR := 0;
  FRELATORIO := 0;
end;

procedure TConfig.CarregaRestricoesBanco;
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' SELECT * FROM CONFIGURACAO ');
    lQuery.SQL.Add(' WHERE ID = 1               ');
    lQuery.Open;

    FMODULO := lQuery.FieldByName('MODULO').AsInteger;
    FORMUSUARIO := lQuery.FieldByName('USUARIO').AsInteger;
    FORMCLIENTE := lQuery.FieldByName('CLIENTE').AsInteger;
    FORMVENDEDOR := lQuery.FieldByName('VENDEDOR').AsInteger;
    FORMPRODUTO := lQuery.FieldByName('PRODUTO').AsInteger;
    FORMUNIDADE := lQuery.FieldByName('UNIDADE').AsInteger;
    FORMFPAGAMENTO := lQuery.FieldByName('FORMAPAGAMENTO').AsInteger;
    FORMVENDA := lQuery.FieldByName('VENDA').AsInteger;

    INCLUIR := lQuery.FieldByName('INCLUIR').AsInteger;
    ALTERAR := lQuery.FieldByName('ALTERAR').AsInteger;
    EXCLUIR := lQuery.FieldByName('EXCLUIR').AsInteger;
    VISUALIZAR := lQuery.FieldByName('VISUALIZAR').AsInteger;
    RELATORIO := lQuery.FieldByName('RELATORIO').AsInteger;

  finally
    lQuery.Free;
  end;
end;

procedure TConfig.SobeRestricoesBanco(pEfetuarCommit: boolean);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' UPDATE CONFIGURACAO SET            ');
    lQuery.SQL.Add('   MODULO = :MODULO                 ');
    lQuery.SQL.Add('  ,USUARIO = :USUARIO               ');
    lQuery.SQL.Add('  ,CLIENTE = :CLIENTE               ');
    lQuery.SQL.Add('  ,VENDEDOR = :VENDEDOR             ');
    lQuery.SQL.Add('  ,PRODUTO = :PRODUTO               ');
    lQuery.SQL.Add('  ,UNIDADE = :UNIDADE               ');
    lQuery.SQL.Add('  ,FORMAPAGAMENTO = :FORMAPAGAMENTO ');
    lQuery.SQL.Add('  ,VENDA = :VENDA                   ');
    lQuery.SQL.Add('  ,INCLUIR = :INCLUIR               ');
    lQuery.SQL.Add('  ,ALTERAR = :ALTERAR               ');
    lQuery.SQL.Add('  ,EXCLUIR = :EXCLUIR               ');
    lQuery.SQL.Add('  ,VISUALIZAR = :VISUALIZAR         ');
    lQuery.SQL.Add('  ,RELATORIO = :RELATORIO           ');
    lQuery.SQL.Add('  WHERE ID = 1                      ');

    lQuery.ParamByName('MODULO').AsInteger := FMODULO;
    lQuery.ParamByName('USUARIO').AsInteger := FFORMUSUARIO;
    lQuery.ParamByName('CLIENTE').AsInteger := FFORMCLIENTE;
    lQuery.ParamByName('VENDEDOR').AsInteger := FFORMVENDEDOR;
    lQuery.ParamByName('PRODUTO').AsInteger := FFORMPRODUTO;
    lQuery.ParamByName('UNIDADE').AsInteger := FFORMUNIDADE;
    lQuery.ParamByName('FORMAPAGAMENTO').AsInteger := FFORMFPAGAMENTO;
    lQuery.ParamByName('VENDA').AsInteger := FFORMVENDA;

    lQuery.ParamByName('INCLUIR').AsInteger := FINCLUIR;
    lQuery.ParamByName('ALTERAR').AsInteger := FALTERAR;
    lQuery.ParamByName('EXCLUIR').AsInteger := FEXCLUIR;
    lQuery.ParamByName('VISUALIZAR').AsInteger := FVISUALIZAR;
    lQuery.ParamByName('RELATORIO').AsInteger := FRELATORIO;

    lQuery.ExecSQL;
    if pEfetuarCommit then
    begin
      dtmConexao.FDConnection.Commit;
    end;
  finally
    lQuery.Free;
  end;
end;

function TConfig.ValidaLogin(pLogin, pSenha: String): boolean;
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' SELECT * FROM USUARIO ');
    lQuery.SQL.Add(' WHERE LOGIN = :LOGIN  ');
    lQuery.SQL.Add(' AND SENHA = :SENHA    ');
    lQuery.ParamByName('LOGIN').AsString := pLogin;
    lQuery.ParamByName('SENHA').AsString := pSenha;
    lQuery.Open;

    ValidaLogin := lQuery.RecordCount > 0;

  finally
    lQuery.Free;
  end;
end;

// Tornar numa function q retorna NAcesso, ID, CorPerfil
procedure TConfig.CarregaUsuarioAcessando(pLogin, pSenha: String);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' SELECT * FROM USUARIO ');
    lQuery.SQL.Add(' WHERE LOGIN = :LOGIN  ');
    lQuery.SQL.Add(' AND SENHA = :SENHA    ');
    lQuery.ParamByName('LOGIN').AsString := pLogin;
    lQuery.ParamByName('SENHA').AsString := pSenha;
    lQuery.Open;

    FCONFIGID := lQuery.FieldByName('ID').AsInteger;
    FCONFIGLOGIN := lQuery.FieldByName('LOGIN').AsString;
    FCONFIGSENHA := lQuery.FieldByName('SENHA').AsString;
    FCONFIGNACESSO := lQuery.FieldByName('NIVELACESSO').AsInteger;
    FCONFIGCOR := lQuery.FieldByName('CORPERFIL').AsString;

  finally
    lQuery.Free;
  end;
end;

procedure TConfig.CarregaCorProBanco(pCor: TColor);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' UPDATE USUARIO SET      ');
    lQuery.SQL.Add(' CORPERFIL = :CORPERFIL  ');
    lQuery.SQL.Add(' WHERE (ID = :ID)        ');
    lQuery.ParamByName('ID').AsInteger := FCONFIGID;
    lQuery.ParamByName('CORPERFIL').AsString := ColorToString(pCor);
    lQuery.ExecSQL;
    dtmConexao.FDConnection.Commit;

  finally
    lQuery.Free;
  end;
end;

constructor TConfig.Create;
begin
  Inicializar;
end;

destructor TConfig.Destroy;
begin
  inherited;
end;

Initialization

lConfig := TConfig.Create;

Finalization

lConfig.Free;

end.
