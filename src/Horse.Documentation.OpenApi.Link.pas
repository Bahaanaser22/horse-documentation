unit Horse.Documentation.OpenApi.Link;

interface

uses
  System.JSON,
  System.Rtti,
  System.Classes,
  System.TypInfo,
  System.SysUtils,
  System.Generics.Collections,
  Horse.Documentation.OpenApi.Utils,
  Horse.Documentation.OpenApi.Types,
  Horse.Documentation.OpenApi.Ancestor,
  Horse.Documentation.OpenApi.Interfaces;

type
  TLink<T> = class(TOpenApiAncestor, ILink<T>)
  private
    FParent: T;
    FOperationRef: string;
    FOperationId: string;
    FParameters: TOpenApiMap<string, ILink<T>>;
    FRequestBody: TJSONValue;
    FDescription: string;
    FServer: IServer<ILink<T>>;

    constructor Create(AParent: T);
  public
    class function New(AParent: T): ILink<T>; static;
    function ToJson: TJSONObject;

    function OperationRef: string; overload;
    function OperationRef(const AValue: string): ILink<T>; overload;
    function OperationId: string; overload;
    function OperationId(const AValue: string): ILink<T>; overload;
    function Parameters: TOpenApiMap<string, ILink<T>>;
    function RequestBody: TJSONValue; overload;
    function RequestBody(const AValue: TJSONValue): ILink<T>; overload;
    function Description: string; overload;
    function Description(const AValue: string): ILink<T>; overload;
    function Server: IServer<ILink<T>>;
    function &End: T;
  end;

implementation

uses
  Horse.Documentation.OpenApi.Server;

{ TLink<T> }

constructor TLink<T>.Create(AParent: T);
begin
  inherited Create;
  FParent := AParent;
end;

function TLink<T>.Description: string;
begin
  Result := FDescription;
end;

function TLink<T>.Description(const AValue: string): ILink<T>;
begin
  Result := Self;
  FDescription := AValue;
end;

function TLink<T>.&End: T;
begin
  Result := FParent;
end;

class function TLink<T>.New(AParent: T): ILink<T>;
begin
  Result := TLink<T>.Create(AParent);
end;

function TLink<T>.OperationId: string;
begin
  Result := FOperationId;
end;

function TLink<T>.OperationId(const AValue: string): ILink<T>;
begin
  Result := Self;
  FOperationId := AValue;
end;

function TLink<T>.OperationRef: string;
begin
  Result := FOperationRef;
end;

function TLink<T>.OperationRef(const AValue: string): ILink<T>;
begin
  Result := Self;
  FOperationRef := AValue;
end;

function TLink<T>.Parameters: TOpenApiMap<string, ILink<T>>;
begin
  if FParameters = nil then
    FParameters := TOpenApiMap<string, ILink<T>>.Create(Self);
  Result := FParameters;
end;

function TLink<T>.RequestBody: TJSONValue;
begin
  Result := FRequestBody;
end;

function TLink<T>.RequestBody(const AValue: TJSONValue): ILink<T>;
begin
  Result := Self;
  FRequestBody := AValue;
end;

function TLink<T>.Server: IServer<ILink<T>>;
begin
  if FServer = nil then
    FServer := TServer<ILink<T>>.New(Self);
  Result := FServer;
end;

function TLink<T>.ToJson: TJSONObject;
begin
  Result := inherited ToJson;

  if not FOperationRef.IsEmpty then
    Result.AddPair('operationRef', FOperationRef)
  else if not FOperationId.IsEmpty then
    Result.AddPair('operationId', FOperationId);

  if not FDescription.IsEmpty then
    Result.AddPair('description', FOperationRef);

  if FRequestBody <> nil then
    Result.AddPair('requestBody', FRequestBody);

  if (FParameters <> nil) and (FParameters.Count > 0) then
    Result.AddPair('parameters', FParameters.ToJson);

  if FServer <> nil then
    Result.AddPair('server', FServer.ToJson);
end;

end.
