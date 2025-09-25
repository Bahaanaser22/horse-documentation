unit Horse.Documentation.OpenApi.Ancestor;

interface

uses
  System.JSON,
  System.Rtti,
  System.Classes,
  System.Generics.Collections,
  Horse.Documentation.OpenApi.Types,
  Horse.Documentation.OpenApi.Utils,
  Horse.Documentation.OpenApi.Interfaces;

type
  TOpenApiAncestor = class abstract (TInterfacedPersistent, IOpenApiAncestor)
  private
    FExtensions: TOpenApiMap<TJSONValue, IOpenApiAncestor>;
  public
    function Extensions: TOpenApiMap<TJSONValue, IOpenApiAncestor>;
    function ToJson: TJSONObject;
  end;

implementation

{ TOpenApiAncestor }

function TOpenApiAncestor.Extensions: TOpenApiMap<TJSONValue, IOpenApiAncestor>;
begin
  if FExtensions = nil then
    FExtensions := TOpenApiMap<TJSONValue, IOpenApiAncestor>.Create(Self);
  Result := FExtensions;
end;

function TOpenApiAncestor.ToJson: TJSONObject;
var
  LPair: TPair<string, TJSONValue>;
begin
  Result := TJSONObject.Create;

  if (FExtensions = nil) or (FExtensions.Count = 0) then
    Exit;

  for LPair in Self.Extensions do
    TJSONObject(Result).AddPair(LPair.Key, LPair.Value);
end;

end.
