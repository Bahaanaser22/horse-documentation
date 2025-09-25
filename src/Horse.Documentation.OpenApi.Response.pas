unit Horse.Documentation.OpenApi.Response;

interface

uses
  System.JSON,
  System.Classes,
  System.SysUtils,
  Horse.Documentation.OpenApi.Types,
  Horse.Documentation.OpenApi.Ancestor,
  Horse.Documentation.OpenApi.Interfaces;

type
  TResponse<T> = class(TOpenApiAncestor, IResponse<T>)
  private
    FParent: T;
    FDescription: string;
    FHeaders: TOpenApiMap<IHeader<IResponse<T>>, IResponse<T>>;
    FContent: TOpenApiMap<IMediaType<IResponse<T>>, IResponse<T>>;
    FLinks: TOpenApiMap<ILink<IResponse<T>>, IResponse<T>>;

    constructor Create(AParent: T);
  public
    class function New(AParent: T): IResponse<T>; static;
    function ToJson: TJSONObject;

    function Description: string; overload;
    function Description(const AValue: string): IResponse<T>; overload;
    function Headers: TOpenApiMap<IHeader<IResponse<T>>, IResponse<T>>;
    function Content: TOpenApiMap<IMediaType<IResponse<T>>, IResponse<T>>;
    function Links: TOpenApiMap<ILink<IResponse<T>>, IResponse<T>>;
    function &End: T;
  end;

implementation

uses
  Horse.Documentation.OpenApi.Link,
  Horse.Documentation.OpenApi.Header,
  Horse.Documentation.OpenApi.MediaType;

{ TResponse<T> }

function TResponse<T>.&End: T;
begin
  Result := FParent;
end;

function TResponse<T>.Content: TOpenApiMap<IMediaType<IResponse<T>>, IResponse<T>>;
begin
  if FContent = nil then
    FContent := TOpenApiMap<IMediaType<IResponse<T>>, IResponse<T>>.Create(Self, TMediaType<IResponse<T>>);
  Result := FContent;
end;

function TResponse<T>.Headers: TOpenApiMap<IHeader<IResponse<T>>, IResponse<T>>;
begin
  if FHeaders = nil then
    FHeaders := TOpenApiMap<IHeader<IResponse<T>>, IResponse<T>>.Create(Self, THeader<IResponse<T>>);
  Result := FHeaders;
end;

function TResponse<T>.Links: TOpenApiMap<ILink<IResponse<T>>, IResponse<T>>;
begin
  if FLinks = nil then
    FLinks := TOpenApiMap<ILink<IResponse<T>>, IResponse<T>>.Create(Self, TLink<IResponse<T>>);
  Result := FLinks;
end;

constructor TResponse<T>.Create(AParent: T);
begin
  inherited Create;
  FParent := AParent;
end;

function TResponse<T>.Description(const AValue: string): IResponse<T>;
begin
  Result := Self;
  FDescription := AValue;
end;

function TResponse<T>.Description: string;
begin
  Result := FDescription;
end;

class function TResponse<T>.New(AParent: T): IResponse<T>;
begin
  Result := TResponse<T>.Create(AParent);
end;

function TResponse<T>.ToJson: TJSONObject;
begin
  Result := inherited ToJson;

  Result.AddPair('description', FDescription);

  if (FHeaders <> nil) and (FHeaders.Count > 0) then
    Result.AddPair('headers', FHeaders.ToJson);

  if (FContent <> nil) and (FContent.Count > 0) then
    Result.AddPair('content', FContent.ToJson);

  if (FLinks <> nil) and (FLinks.Count > 0) then
    Result.AddPair('links', FLinks.ToJson);
end;

end.

