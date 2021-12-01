unit uFPagamento;

interface

uses
  FireDAC.Comp.Client, dconexao, Vcl.Dialogs, System.SysUtils, Vcl.Controls,
  Vcl.Forms;

type
  TFPagamento = class
  private
    FID: integer;
    FDESCRICAO: String;
    FTIPO: String;

    class var FObjetoBusca: TFPagamento;
  public
    destructor Destroy; override;
    procedure Inicializar;
    procedure Carrega;
    procedure Incluir(pEfetuarCommit: boolean);
    procedure Alterar(pEfetuarCommit: boolean);
    procedure Excluir(pEfetuarCommit: boolean);

    constructor Create;
    class property ObjetoBusca: TFPagamento read FObjetoBusca
      write FObjetoBusca;
    class function GeraProximoID: integer;
    class function Existe(pId: integer): boolean;

    property ID: integer read FID write FID;
    property DESCRICAO: String read FDESCRICAO write FDESCRICAO;
    property TIPO: String read FTIPO write FTIPO;

  end;

implementation

{ TClassDefault }

procedure TFPagamento.Carrega;
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' SELECT * FROM FORMAPAGAMENTO ');
    lQuery.SQL.Add(' WHERE ID = :ID               ');
    lQuery.ParamByName('ID').AsInteger := FID;
    lQuery.Open;

    if lQuery.RecordCount > 0 then
    begin
      FID := lQuery.FieldByName('ID').AsInteger;
      FDESCRICAO := lQuery.FieldByName('DESCRICAO').AsString;
      FTIPO := lQuery.FieldByName('TIPO').AsString;
    end;
  finally
    lQuery.Free;
  end;
end;

class function TFPagamento.Existe(pId: integer): boolean;
var
  lQuery: TFDQuery;
begin
  result := false;
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.SQL.Add('SELECT * FROM FORMAPAGAMENTO WHERE ID = :ID');
    lQuery.ParamByName('ID').AsInteger := pId;
    lQuery.Open;

    if (lQuery.RecordCount > 0) then
    begin
      result := true;

      if not Assigned(FObjetoBusca) then
      begin
        FObjetoBusca := TFPagamento.Create;
      end;

      FObjetoBusca.FID := pId;
      FObjetoBusca.Carrega;
    end;
  finally
    lQuery.Free;
  end;
end;

class function TFPagamento.GeraProximoID: integer;
var
  lQuery: TFDQuery;
begin
  // Criei Class Function para não precisar estanciar a classe.
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add
      (' select gen_id(gen_formapagamento_id, 0) codigo from formapagamento ');
    lQuery.Open;

    result := lQuery.FieldByName('codigo').AsInteger + 1;

  finally
    lQuery.Free;
  end;
end;

procedure TFPagamento.Incluir(pEfetuarCommit: boolean);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' INSERT INTO FORMAPAGAMENTO ( ');
    lQuery.SQL.Add(' DESCRICAO                    ');
    lQuery.SQL.Add(' ,TIPO )                      ');
    lQuery.SQL.Add(' VALUES (                     ');
    lQuery.SQL.Add(' :DESCRICAO                   ');
    lQuery.SQL.Add(' ,:TIPO )                     ');

    lQuery.ParamByName('DESCRICAO').AsString := FDESCRICAO;
    lQuery.ParamByName('TIPO').AsString := FTIPO;

    lQuery.ExecSQL;

    if pEfetuarCommit = true then
    begin
      dtmConexao.FDConnection.Commit;
    end;
  finally
    lQuery.Free;
  end;
end;

procedure TFPagamento.Alterar(pEfetuarCommit: boolean);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' UPDATE FORMAPAGAMENTO SET ');
    lQuery.SQL.Add(' DESCRICAO = :DESCRICAO    ');
    lQuery.SQL.Add(' ,TIPO = :TIPO             ');
    lQuery.SQL.Add(' WHERE ID = :ID            ');

    lQuery.ParamByName('ID').AsInteger := FID;
    lQuery.ParamByName('DESCRICAO').AsString := FDESCRICAO;
    lQuery.ParamByName('TIPO').AsString := FTIPO;

    lQuery.ExecSQL;

    if pEfetuarCommit = true then
    begin
      dtmConexao.FDConnection.Commit;
    end;
  finally
    lQuery.Free;
  end;
end;

procedure TFPagamento.Excluir(pEfetuarCommit: boolean);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    if (MessageDlg('Confirma a Exclusão da Forma de pagamento ' + FID.ToString +
      '-' + FDESCRICAO + ' ?', mtInformation, [mbyes, mbno], 0) = mryes) then
    begin
      lQuery.Connection := dtmConexao.FDConnection;
      lQuery.Close;
      lQuery.SQL.Clear;
      lQuery.SQL.Add(' DELETE FROM FORMAPAGAMENTO ');
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

procedure TFPagamento.Inicializar;
begin
  FID := 0;
  FDESCRICAO := EmptyStr;
  FTIPO := EmptyStr;
end;

constructor TFPagamento.Create;
begin
  Inicializar;
end;

destructor TFPagamento.Destroy;
begin
  inherited;
end;

end.
