unit Horse.Documentation.OpenApi.MediaType;

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
  TMediaType<T> = class(TOpenApiAncestor, IMediaType<T>)
  private
    FParent: T;
    FSchema: ISchema;
    FExample: TJSONValue;
    FExamples: TOpenApiMap<IExample<IMediaType<T>>, IMediaType<T>>;
    FEncoding: TOpenApiMap<IEncoding<IMediaType<T>>, IMediaType<T>>;

    constructor Create(AParent: T);
  public
    class function New(AParent: T): IMediaType<T>; static;
    function ToJson: TJSONObject;

    function Schema: ISchema; overload;
    function Schema(const AValue: ISchema): IMediaType<T>; overload;
    function Example: TJSONValue; overload;
    function Example(const AValue: TJSONValue): IMediaType<T>; overload;
    function Examples: TOpenApiMap<IExample<IMediaType<T>>, IMediaType<T>>;
    function Encoding: TOpenApiMap<IEncoding<IMediaType<T>>, IMediaType<T>>;
    function &End: T;
  end;

implementation

uses
  Horse.Documentation.OpenApi.Example,
  Horse.Documentation.OpenApi.Encoding;

{ TMediaType<T> }

constructor TMediaType<T>.Create(AParent: T);
begin
  inherited Create;
  FParent := AParent;
end;

function TMediaType<T>.Encoding: TOpenApiMap<IEncoding<IMediaType<T>>, IMediaType<T>>;
begin
  if FEncoding = nil then
    FEncoding := TOpenApiMap<IEncoding<IMediaType<T>>, IMediaType<T>>.Create(Self, TEncoding<IMediaType<T>>);
  Result := FEncoding;
end;

function TMediaType<T>.&End: T;
begin
  Result := FParent;
end;

function TMediaType<T>.Example(const AValue: TJSONValue): IMediaType<T>;
begin
  Result := Self;
  FExample := AValue;
end;

function TMediaType<T>.Example: TJSONValue;
begin
  Result := FExample;
end;

function TMediaType<T>.Examples: TOpenApiMap<IExample<IMediaType<T>>, IMediaType<T>>;
begin
  if FExamples = nil then
    FExamples := TOpenApiMap<IExample<IMediaType<T>>, IMediaType<T>>.Create(Self, TExample<IMediaType<T>>);
  Result := FExamples;
end;

class function TMediaType<T>.New(AParent: T): IMediaType<T>;
begin
  Result := TMediaType<T>.Create(AParent);
end;

function TMediaType<T>.Schema(const AValue: ISchema): IMediaType<T>;
begin
  Result := Self;
  FSchema := AValue;
end;

function TMediaType<T>.Schema: ISchema;
begin
  Result := FSchema;
end;

function TMediaType<T>.ToJson: TJSONObject;
begin
  Result := inherited ToJson;

  if FSchema <> nil then
    Result.AddPair('schema', FSchema);

  if FExample <> nil then
    Result.AddPair('example', FExample);

  if (FExamples <> nil) and (FExamples.Count > 0) then
    Result.AddPair('examples', FExamples.ToJson);

  if (FEncoding <> nil) and (FEncoding.Count > 0) then
    Result.AddPair('encoding', FEncoding.ToJson);
end;

end.
