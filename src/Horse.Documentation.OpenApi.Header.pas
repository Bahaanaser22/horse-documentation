unit Horse.Documentation.OpenApi.Header;

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
  THeader<T> = class(TOpenApiAncestor, IHeader<T>)
  private
    FParent: T;
    FDescription: string;
    FRequired: Boolean;
    FDeprecated: Boolean;
    FStyle: TParameterStyle;
    FExplode: Boolean;
    FSchema: ISchema;
    FExample: TJSONValue;
    FExamples: TOpenApiMap<IExample<IHeader<T>>, IHeader<T>>;
    FContent: TOpenApiMap<IMediaType<IHeader<T>>, IHeader<T>>;

    constructor Create(AParent: T);
  public
    class function New(AParent: T): IHeader<T>; static;
    function ToJson: TJSONObject;

    function Description: string; overload;
    function Description(const AValue: string): IHeader<T>; overload;
    function Required: Boolean; overload;
    function Required(const AValue: Boolean): IHeader<T>; overload;
    function Deprecated: Boolean; overload;
    function Deprecated(const AValue: Boolean): IHeader<T>; overload;
    function Style: TParameterStyle; overload;
    function Style(const AValue: TParameterStyle): IHeader<T>; overload;
    function Explode: Boolean; overload;
    function Explode(const AValue: Boolean): IHeader<T>; overload;
    function Schema: ISchema;
    function Example: TJSONValue; overload;
    function Example(const AValue: TJSONValue): IHeader<T>; overload;
    function Examples: TOpenApiMap<IExample<IHeader<T>>, IHeader<T>>;
    function Content: TOpenApiMap<IMediaType<IHeader<T>>, IHeader<T>>;
    function &End: T;
  end;

implementation

uses
  Horse.Documentation.OpenApi.Example,
  Horse.Documentation.OpenApi.MediaType;

{ THeader<T> }

function THeader<T>.Content: TOpenApiMap<IMediaType<IHeader<T>>, IHeader<T>>;
begin
  if FContent = nil then
    FContent := TOpenApiMap<IMediaType<IHeader<T>>, IHeader<T>>.Create(Self, TMediaType<IHeader<T>>);
  Result := FContent;
end;

constructor THeader<T>.Create(AParent: T);
begin
  inherited Create;
  FParent := AParent;
end;

function THeader<T>.Description: string;
begin
  Result := FDescription;
end;

function THeader<T>.Deprecated(const AValue: Boolean): IHeader<T>;
begin
  Result := Self;
  FDeprecated := AValue;
end;

function THeader<T>.Deprecated: Boolean;
begin
  Result := FDeprecated;
end;

function THeader<T>.Description(const AValue: string): IHeader<T>;
begin
  Result := Self;
  FDescription := AValue;
end;

function THeader<T>.&End: T;
begin
  Result := FParent;
end;

function THeader<T>.Example(const AValue: TJSONValue): IHeader<T>;
begin
  Result := Self;
  FExample := AValue;
end;

function THeader<T>.Example: TJSONValue;
begin
  Result := FExample;
end;

function THeader<T>.Examples: TOpenApiMap<IExample<IHeader<T>>, IHeader<T>>;
begin
  if FExamples = nil then
    FExamples := TOpenApiMap<IExample<IHeader<T>>, IHeader<T>>.Create(Self, TExample<IHeader<T>>);
  Result := FExamples;
end;

function THeader<T>.Explode(const AValue: Boolean): IHeader<T>;
begin
  Result := Self;
  FExplode := AValue;
end;

function THeader<T>.Explode: Boolean;
begin
  Result := FExplode;
end;

class function THeader<T>.New(AParent: T): IHeader<T>;
begin
  Result := THeader<T>.Create(AParent);
end;

function THeader<T>.Required(const AValue: Boolean): IHeader<T>;
begin
  Result := Self;
  FRequired := AValue;
end;

function THeader<T>.Required: Boolean;
begin
  Result := FRequired;
end;

function THeader<T>.Schema: ISchema;
begin
  Result := FSchema;
end;

function THeader<T>.Style: TParameterStyle;
begin
  Result := FStyle;
end;

function THeader<T>.Style(const AValue: TParameterStyle): IHeader<T>;
begin
  Result := Self;
  FStyle := AValue;
end;

function THeader<T>.ToJson: TJSONObject;
var
  LDefaultStyle: TParameterStyle;
  LDefaultExplode: Boolean;
begin
  Result := inherited ToJson;

  if not FDescription.IsEmpty then
    Result.AddPair('description', FDescription);

  if FRequired then
    Result.AddPair('required', FRequired);

  if FDeprecated then
    Result.AddPair('deprecated', FDeprecated);

  if FSchema <> nil then
  begin
    Result.AddPair('schema', FSchema);

    LDefaultStyle := TParameterStyle.psForm;
    if FStyle <> LDefaultStyle then
      Result.AddPair('style', FStyle.ToString);

    LDefaultExplode := FStyle = psForm;
    if FExplode <> LDefaultExplode then
      Result.AddPair('explode', FExplode);

    if FExample <> nil then
      Result.AddPair('example', FExample);

    if FDeprecated then
      Result.AddPair('deprecated', FDeprecated);

    if (FExamples <> nil) and (FExamples.Count > 0) then
      Result.AddPair('examples', FExamples.ToJson);
  end;

  if (FContent <> nil) and (FContent.Count > 0) then
    Result.AddPair('content', FContent.ToJson);
end;

end.
