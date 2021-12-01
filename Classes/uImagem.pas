unit uImagem;

interface

uses
  System.JSON, REST.JSON, System.Generics.Collections, uConexao,
  System.SysUtils, Vcl.Dialogs, Vcl.ExtCtrls, uHelpersImagensBase64,
  FireDAC.Comp.Client,  FireDAC.DApt;

type
  TImagem = class;

  TImagem = class
  private

    FID: integer;
    FIMAGEM_BASE64: string;
    FID_PRODUTO: integer;
    FNUMERO_IMAGEM: integer;
    [JSONMarshalledAttribute(False)]
    FDataSet: TFDQuery;

  public
    destructor Destroy; override;

    property ID: integer read FID write FID;
    property IMAGEM_BASE64: string read FIMAGEM_BASE64 write FIMAGEM_BASE64;
    property ID_PRODUTO: integer read FID_PRODUTO write FID_PRODUTO;
    property NUMERO_IMAGEM: integer read FNUMERO_IMAGEM write FNUMERO_IMAGEM;

    procedure Incluir(pEfetuarCommit: Boolean);
    procedure CarregaImagens(pImagem: TImage);

    constructor Create;

    function ToJson: TJSONObject;
  end;

implementation

function TImagem.ToJson: TJSONObject;
begin
  result := TJson.ObjectToJsonObject(self, [joIgnoreEmptyStrings]);
end;

procedure TImagem.Incluir(pEfetuarCommit: Boolean);
begin
  try
    FDataSet.close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add(' update or insert into IMAGENS (          ');
    FDataSet.SQL.Add(' ID_PRODUTO,                              ');
    FDataSet.SQL.Add(' IMAGEM_BASE64,                           ');
    FDataSet.SQL.Add(' NUMERO_IMAGEM)                           ');
    FDataSet.SQL.Add(' values (                                 ');
    FDataSet.SQL.Add(' :ID_PRODUTO,                             ');
    FDataSet.SQL.Add(' :IMAGEM_BASE64,                          ');
    FDataSet.SQL.Add(' :NUMERO_IMAGEM)                          ');
    FDataSet.SQL.Add(' matching (ID_PRODUTO ,NUMERO_IMAGEM)     ');
    FDataSet.ParamByName('ID_PRODUTO').AsInteger := FID_PRODUTO;
    FDataSet.ParamByName('IMAGEM_BASE64').AsString := FIMAGEM_BASE64;
    FDataSet.ParamByName('NUMERO_IMAGEM').AsInteger := FNUMERO_IMAGEM;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except
    on E: Exception do
    begin
      ShowMessage('Problema ao alterar/incluir foto');
    end;
  end;
end;

procedure TImagem.CarregaImagens(pImagem: TImage);
begin
  pImagem.Picture := nil;

  FDataSet.close;
  FDataSet.SQL.Clear;
  FDataSet.SQL.Add('SELECT IMAGEM_BASE64 FROM IMAGENS            ');
  FDataSet.SQL.Add('WHERE NUMERO_IMAGEM = :NUMERO_IMAGEM         ');
  FDataSet.ParamByName('NUMERO_IMAGEM').AsInteger := 1;
  FDataSet.Open;

  if FDataSet.RecordCount > 0 then
  begin
    pImagem.Base64(FDataSet.fieldbyname('IMAGEM_BASE64').AsString);
  End
  Else
  Begin
    // tratar aqui como nao encontrado
  End;

end;

constructor TImagem.Create;
begin
  FDataSet := TFDQuery.Create(nil);
  FDataSet.Connection := TConexao.ObjetoConexao.ConnectionBD;
end;

destructor TImagem.Destroy;
begin
  FDataSet.Free;
end;

end.
