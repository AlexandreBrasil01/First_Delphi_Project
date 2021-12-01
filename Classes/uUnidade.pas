unit uUnidade;

interface

uses
  FireDAC.Comp.Client,
  dconexao,
  Vcl.Dialogs,
  System.SysUtils,
  Vcl.Controls,
  Vcl.Forms;

type
  TUnidade = class
  private
    FID: integer;
    FDESCRICAO: String;
    FUNIDADE: String;

    class var FObjetoBusca: TUnidade;
  public
    destructor Destroy; override;
    procedure Inicializar;
    procedure Carrega;
    procedure Incluir(pEfetuarCommit: boolean);
    procedure Alterar(pEfetuarCommit: boolean);
    procedure Excluir(pEfetuarCommit: boolean);

    constructor Create;
    class property ObjetoBusca: TUnidade read FObjetoBusca write FObjetoBusca;
    class function GeraProximoID: integer;

    property ID: integer read FID write FID;
    Property DESCRICAO: String read FDESCRICAO write FDESCRICAO;
    property UNIDADE: String read FUNIDADE write FUNIDADE;

  end;

implementation

{ TClassDefault }

procedure TUnidade.Carrega;
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add('SELECT * FROM UNIDADE');
    lQuery.SQL.Add('WHERE ID = :ID       ');
    lQuery.ParamByName('ID').AsInteger := FID;
    lQuery.Open;

    if lQuery.RecordCount > 0 then
    begin
      FID := lQuery.FieldByName('ID').AsInteger;
      FDESCRICAO := lQuery.FieldByName('DESCRICAO').AsString;
      FUNIDADE := lQuery.FieldByName('UNIDADE').AsString;
    end;
  finally
    lQuery.Free;
  end;
end;

class function TUnidade.GeraProximoID: integer;
var
  lQuery: TFDQuery;
begin
  // Criei Class Function para não precisar estanciar a classe.
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' select gen_id(gen_unidade_id, 0) codigo from UNIDADE ');
    lQuery.Open;

    result := lQuery.FieldByName('codigo').AsInteger + 1;

  finally
    lQuery.Free;
  end;
end;

procedure TUnidade.Incluir(pEfetuarCommit: boolean);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' INSERT INTO UNIDADE ( ');
    lQuery.SQL.Add(' DESCRICAO,            ');
    lQuery.SQL.Add(' UNIDADE )             ');
    lQuery.SQL.Add(' VALUES (              ');
    lQuery.SQL.Add(' :DESCRICAO,           ');
    lQuery.SQL.Add(' :UNIDADE )            ');

    lQuery.ParamByName('DESCRICAO').AsString := FDESCRICAO;
    lQuery.ParamByName('UNIDADE').AsString := FUNIDADE;

    lQuery.ExecSQL;

    if pEfetuarCommit = true then
    begin
      dtmConexao.FDConnection.Commit;
    end;
  finally
    lQuery.Free;
  end;
end;

procedure TUnidade.Alterar(pEfetuarCommit: boolean);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' UPDATE UNIDADE SET        ');
    lQuery.SQL.Add(' DESCRICAO = :DESCRICAO,   ');
    lQuery.SQL.Add(' UNIDADE = :UNIDADE        ');
    lQuery.SQL.Add(' WHERE ID = :ID            ');

    lQuery.ParamByName('ID').AsInteger := FID;
    lQuery.ParamByName('DESCRICAO').AsString := FDESCRICAO;
    lQuery.ParamByName('UNIDADE').AsString := FUNIDADE;

    lQuery.ExecSQL;

    if pEfetuarCommit = true then
    begin
      dtmConexao.FDConnection.Commit;
    end;
  finally
    lQuery.Free;
  end;
end;

procedure TUnidade.Excluir(pEfetuarCommit: boolean);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    if (MessageDlg('Confirma a Exclusão da Unidade: ' + FID.ToString + '-' +
      FUNIDADE + ' ?', mtInformation, [mbyes, mbno], 0) = mryes) then
    begin
      lQuery.Connection := dtmConexao.FDConnection;
      lQuery.Close;
      lQuery.SQL.Clear;
      lQuery.SQL.Add(' DELETE FROM UNIDADE ');
      lQuery.SQL.Add(' WHERE ID = :ID      ');
      lQuery.ParamByName('ID').AsInteger := FID;
      lQuery.ExecSQL;

      if pEfetuarCommit = true then
      begin
        dtmConexao.FDConnection.Commit;
      end;
    end;
  except
    begin
      MessageDlg('Problema na Exclusão. ' +
        'Favor tentar mais tarde e conferir rotina !!!', mtError, [mbOK], 0);
    end;
    Screen.Cursor := crDefault;
  end;
end;

procedure TUnidade.Inicializar;
begin
  FID := 0;
  FDESCRICAO := emptyStr;
  FUNIDADE := emptyStr;
end;

constructor TUnidade.Create;
begin
  Inicializar;
end;

destructor TUnidade.Destroy;
begin
  inherited;
end;

end.
