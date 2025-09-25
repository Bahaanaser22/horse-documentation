unit Horse.Documentation.OpenApi.RequestBody;

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
  TRequestBody<T> = class(TOpenApiAncestor, IRequestBody<T>)
  private
    FParent: T;
    FDescription: string;
    FContent: TOpenApiMap<IMediaType<IRequestBody<T>>, IRequestBody<T>>;
    FRequired: Boolean;

    constructor Create(AParent: T);
  public
    class function New(AParent: T): IRequestBody<T>; static;
    function ToJson: TJSONObject;

    function Description: string; overload;
    function Description(const AValue: string): IRequestBody<T>; overload;
    function Content: TOpenApiMap<IMediaType<IRequestBody<T>>, IRequestBody<T>>;
    function Required: Boolean; overload;
    function Required(const AValue: Boolean): IRequestBody<T>; overload;
    function &End: T;
  end;

implementation

uses
  Horse.Documentation.OpenApi.MediaType;

{ TRequestBody<T> }

function TRequestBody<T>.Content: TOpenApiMap<IMediaType<IRequestBody<T>>, IRequestBody<T>>;
begin
  if FContent = nil then
    FContent := TOpenApiMap<IMediaType<IRequestBody<T>>, IRequestBody<T>>.Create(Self, TMediaType<IRequestBody<T>>);
  Result := FContent;
end;

constructor TRequestBody<T>.Create(AParent: T);
begin
  inherited Create;
  FParent := AParent;
end;

function TRequestBody<T>.Description: string;
begin
  Result := FDescription;
end;

function TRequestBody<T>.Description(const AValue: string): IRequestBody<T>;
begin
  Result := Self;
  FDescription := AValue;
end;

function TRequestBody<T>.&End: T;
begin
  Result := FParent;
end;

class function TRequestBody<T>.New(AParent: T): IRequestBody<T>;
begin
  Result := TRequestBody<T>.Create(AParent);
end;

function TRequestBody<T>.Required(const AValue: Boolean): IRequestBody<T>;
begin
  Result := Self;
  FRequired := AValue;
end;

function TRequestBody<T>.Required: Boolean;
begin
  Result := FRequired;
end;

function TRequestBody<T>.ToJson: TJSONObject;
begin
  Result := inherited ToJson;

  if not FDescription.IsEmpty then
    Result.AddPair('description', FDescription);

  if FRequired then
    Result.AddPair('required', FRequired);

  if (FContent <> nil) and (FContent.Count > 0) then
    Result.AddPair('content', FContent.ToJson);
end;

end.
