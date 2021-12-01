unit uProduto;

interface

uses
  FireDAC.Comp.Client,
  dconexao,
  Vcl.Dialogs,
  System.SysUtils,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.ExtCtrls,
  RLReport,
  uHelpersImagensBase64,
  uHelpersrlImagensBase64;

type
  TProduto = class
  private
    FID: Integer;
    FIDUNIDADE: Integer;
    FDESCRICAO: String;
    FREFERENCIA: String;
    FPRECO: Double;
    FCUSTO: Double;
    FSALDO: Double;
    FPESO: Double;
    FFOTO: String;

    class var FObjetoBusca: TProduto;
  public
    destructor Destroy; override;
    procedure Inicializar;
    procedure Carrega;
    procedure Incluir(pEfetuarCommit: boolean);
    procedure Alterar(pEfetuarCommit: boolean);
    procedure Excluir(pEfetuarCommit: boolean);
    procedure CarregaImagem(pImagem: TImage);
    procedure CarregaRLImagem(pImagem: TRLImage);

    constructor Create;
    class property ObjetoBusca: TProduto read FObjetoBusca write FObjetoBusca;
    class function GeraProximoID: Integer;
    class function Existe(pId: Integer): boolean;

    property ID: Integer read FID write FID;
    property IDUNIDADE: Integer read FIDUNIDADE write FIDUNIDADE;
    property DESCRICAO: String read FDESCRICAO write FDESCRICAO;
    property REFERENCIA: String read FREFERENCIA write FREFERENCIA;
    property preco: Double read FPRECO write FPRECO;
    property CUSTO: Double read FCUSTO write FCUSTO;
    property SALDO: Double read FSALDO write FSALDO;
    property PESO: Double read FPESO write FPESO;
    property FOTO: string read FFOTO write FFOTO;

  end;

implementation

{ TClassDefault }

procedure TProduto.Carrega;
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' SELECT * FROM PRODUTO ');
    lQuery.SQL.Add(' WHERE ID = :ID        ');
    lQuery.ParamByName('ID').AsInteger := FID;
    lQuery.Open;

    if lQuery.RecordCount > 0 then
    begin
      FID := lQuery.ParamByName('ID').AsInteger;
      FIDUNIDADE := lQuery.FieldByName('FK_UNIDADE').AsInteger;
      FDESCRICAO := lQuery.FieldByName('DESCRICAO').AsString;
      FREFERENCIA := lQuery.FieldByName('REFERENCIA').AsString;
      FPRECO := lQuery.FieldByName('PRECO').AsFloat;
      FCUSTO := lQuery.FieldByName('CUSTO').AsFloat;
      FSALDO := lQuery.FieldByName('SALDO').AsFloat;
      FPESO := lQuery.FieldByName('PESO').AsFloat;
      FFOTO := lQuery.FieldByName('FOTO').AsString;
    end;
  finally
    lQuery.Free;
  end;
end;

class function TProduto.Existe(pId: Integer): boolean;
var
  lQuery: TFDQuery;
begin
  result := false;
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.SQL.Add('SELECT * FROM PRODUTO WHERE ID = :ID');
    lQuery.ParamByName('ID').AsInteger := pId;
    lQuery.Open;

    if (lQuery.RecordCount > 0) then
    begin
      result := true;

      if not Assigned(FObjetoBusca) then
      begin
        FObjetoBusca := TProduto.Create;
      end;

      FObjetoBusca.FID := pId;
      FObjetoBusca.Carrega;
    end;
  finally
    lQuery.Free;
  end;
end;

procedure TProduto.CarregaImagem(pImagem: TImage);
begin
  // Chamar sempre APÓS CARREGAR A CLASSE.
  pImagem.Picture := nil;

  if trim(FFOTO) <> emptystr then
  begin
    pImagem.Base64(FFOTO);
  End
  Else
  Begin
    // tratar aqui como nao encontrado
  End;
end;

procedure TProduto.CarregaRLImagem(pImagem: TRLImage);
begin
  // Chamar sempre APÓS CARREGAR A CLASSE.
  pImagem.Picture := nil;

  if trim(FFOTO) <> emptystr then
  begin
    pImagem.Base64(FFOTO);
  end
  else
  begin
    // Tratar aqui como nao encontrado
  end;

end;

class function TProduto.GeraProximoID: Integer;
var
  lQuery: TFDQuery;
begin
  // Criei Class Function para não precisar estanciar a classe.
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' select gen_id(gen_produto_id, 0) codigo from PRODUTO ');
    lQuery.Open;

    result := lQuery.FieldByName('codigo').AsInteger + 1;

  finally
    lQuery.Free;
  end;
end;

procedure TProduto.Incluir(pEfetuarCommit: boolean);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' INSERT INTO PRODUTO ( ');
    lQuery.SQL.Add('  FK_UNIDADE           ');
    lQuery.SQL.Add(' ,DESCRICAO            ');
    lQuery.SQL.Add(' ,REFERENCIA           ');
    lQuery.SQL.Add(' ,PRECO                ');
    lQuery.SQL.Add(' ,CUSTO                ');
    lQuery.SQL.Add(' ,SALDO                ');
    lQuery.SQL.Add(' ,PESO                 ');
    lQuery.SQL.Add(' ,FOTO                 ');
    lQuery.SQL.Add(' )VALUES (             ');
    lQuery.SQL.Add('  :FK_UNIDADE          ');
    lQuery.SQL.Add(' ,:DESCRICAO           ');
    lQuery.SQL.Add(' ,:REFERENCIA          ');
    lQuery.SQL.Add(' ,:PRECO               ');
    lQuery.SQL.Add(' ,:CUSTO               ');
    lQuery.SQL.Add(' ,:SALDO               ');
    lQuery.SQL.Add(' ,:PESO                ');
    lQuery.SQL.Add(' ,:FOTO                ');
    lQuery.SQL.Add(' )                     ');

    lQuery.ParamByName('FK_UNIDADE').AsInteger := FIDUNIDADE;
    lQuery.ParamByName('DESCRICAO').AsString := FDESCRICAO;
    lQuery.ParamByName('REFERENCIA').AsString := FREFERENCIA;
    lQuery.ParamByName('PRECO').AsFloat := FPRECO;
    lQuery.ParamByName('CUSTO').AsFloat := FCUSTO;
    lQuery.ParamByName('SALDO').AsFloat := FSALDO;
    lQuery.ParamByName('PESO').AsFloat := FPESO;
    lQuery.ParamByName('FOTO').AsString := FFOTO;
    lQuery.ExecSQL;

    if pEfetuarCommit = true then
    begin
      dtmConexao.FDConnection.Commit;
    end;
  finally
    lQuery.Free;
  end;
end;

procedure TProduto.Alterar(pEfetuarCommit: boolean);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := dtmConexao.FDConnection;
    lQuery.Close;
    lQuery.SQL.Clear;
    lQuery.SQL.Add(' UPDATE PRODUTO SET        ');
    lQuery.SQL.Add('  FK_UNIDADE = :FK_UNIDADE ');
    lQuery.SQL.Add(' ,DESCRICAO = :DESCRICAO   ');
    lQuery.SQL.Add(' ,REFERENCIA = :REFERENCIA ');
    lQuery.SQL.Add(' ,PRECO = :PRECO           ');
    lQuery.SQL.Add(' ,CUSTO = :CUSTO           ');
    lQuery.SQL.Add(' ,SALDO = :SALDO           ');
    lQuery.SQL.Add(' ,PESO = :PESO             ');
    lQuery.SQL.Add(' ,FOTO = :FOTO             ');
    lQuery.SQL.Add(' WHERE ID = :ID            ');

    lQuery.ParamByName('ID').AsInteger := FID;
    lQuery.ParamByName('FK_UNIDADE').AsInteger := FIDUNIDADE;
    lQuery.ParamByName('DESCRICAO').AsString := FDESCRICAO;
    lQuery.ParamByName('REFERENCIA').AsString := FREFERENCIA;
    lQuery.ParamByName('PRECO').AsFloat := FPRECO;
    lQuery.ParamByName('CUSTO').AsFloat := FCUSTO;
    lQuery.ParamByName('SALDO').AsFloat := FSALDO;
    lQuery.ParamByName('PESO').AsFloat := FPESO;
    lQuery.ParamByName('FOTO').AsString := FFOTO;
    lQuery.ExecSQL;

    if pEfetuarCommit = true then
    begin
      dtmConexao.FDConnection.Commit;
    end;
  finally
    lQuery.Free;
  end;
end;

procedure TProduto.Excluir(pEfetuarCommit: boolean);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    if (MessageDlg('Confirma a Exclusão do Produto: ' + FID.ToString + '-' +
      FDESCRICAO + ' ?', mtInformation, [mbyes, mbno], 0) = mryes) then
    begin
      lQuery.Connection := dtmConexao.FDConnection;
      lQuery.Close;
      lQuery.SQL.Clear;
      lQuery.SQL.Add(' DELETE FROM PRODUTO ');
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
      MessageDlg('Problema na Exclusão do Produto da O.S. ' +
        'Favor tentar mais tarde e conferir rotina !!!', mtError, [mbOK], 0);
    end;
    Screen.Cursor := crDefault;
  end;
end;

procedure TProduto.Inicializar;
begin
  FID := 0;
  FIDUNIDADE := 0;
  FDESCRICAO := emptystr;
  FREFERENCIA := emptystr;
  FPRECO := 0;
  FCUSTO := 0;
  FSALDO := 0;
  FPESO := 0;
  FFOTO := emptystr;
end;

constructor TProduto.Create;
begin
  Inicializar;
end;

destructor TProduto.Destroy;
begin
  inherited;
end;

end.
