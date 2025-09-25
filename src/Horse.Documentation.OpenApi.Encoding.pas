unit Horse.Documentation.OpenApi.Encoding;

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
  TEncoding<T> = class(TOpenApiAncestor, IEncoding<T>)
  private
    FParent: T;
    FContentType: string;
//    FHeaders: TOpenApiMap<IHeader<IEncoding<T>>, IEncoding<T>>;
    FStyle: TParameterStyle;
    FExplode: Boolean;
    FAllowReserved: Boolean;

    constructor Create(AParent: T);
  public
    class function New(AParent: T): IEncoding<T>; static;
    function ToJson: TJSONObject;

    function ContentType: string; overload;
    function ContentType(const AValue: string): IEncoding<T>; overload;
//    function Headers: TOpenApiMap<IHeader<IEncoding<T>>, IEncoding<T>>;
    function Style: TParameterStyle; overload;
    function Style(const AValue: TParameterStyle): IEncoding<T>; overload;
    function Explode: Boolean; overload;
    function Explode(const AValue: Boolean): IEncoding<T>; overload;
    function AllowReserved: Boolean; overload;
    function AllowReserved(const AValue: Boolean): IEncoding<T>; overload;
    function &End: T;
  end;

implementation

uses
  Horse.Documentation.OpenApi.Header;

{ TEncoding<T> }

function TEncoding<T>.AllowReserved(const AValue: Boolean): IEncoding<T>;
begin
  Result := Self;
  FAllowReserved := AValue;
end;

function TEncoding<T>.AllowReserved: Boolean;
begin
  Result := FAllowReserved;
end;

function TEncoding<T>.ContentType: string;
begin
  Result := FContentType;
end;

function TEncoding<T>.ContentType(const AValue: string): IEncoding<T>;
begin
  Result := Self;
  FContentType := AValue;
end;

constructor TEncoding<T>.Create(AParent: T);
begin
  inherited Create;
  FParent := AParent;
end;

function TEncoding<T>.&End: T;
begin
  Result := FParent;
end;

function TEncoding<T>.Explode(const AValue: Boolean): IEncoding<T>;
begin
  Result := Self;
  FExplode := AValue;
end;

//function TEncoding<T>.Headers: TOpenApiMap<IHeader<IEncoding<T>>, IEncoding<T>>;
//begin
//  if FHeaders = nil then
//    FHeaders := TOpenApiMap<IHeader<IEncoding<T>>, IEncoding<T>>.Create(Self, THeader<IEncoding<T>>);
//  Result := FHeaders;
//end;

function TEncoding<T>.Explode: Boolean;
begin
  Result := FExplode;
end;

class function TEncoding<T>.New(AParent: T): IEncoding<T>;
begin
  Result := TEncoding<T>.Create(AParent);
end;

function TEncoding<T>.Style: TParameterStyle;
begin
  Result := FStyle;
end;

function TEncoding<T>.Style(const AValue: TParameterStyle): IEncoding<T>;
begin
  Result := Self;
  FStyle := AValue;
end;

function TEncoding<T>.ToJson: TJSONObject;
var
  LDefaultExplode: Boolean;
begin
  Result := inherited ToJson;

  if not FContentType.IsEmpty then
    Result.AddPair('contentType', FContentType);

  if FAllowReserved then
    Result.AddPair('allowReserved', FAllowReserved);

  LDefaultExplode := FStyle = psForm;
  if FExplode <> LDefaultExplode then
    Result.AddPair('explode', FExplode);

  if FStyle <> psForm then
    Result.AddPair('style', FStyle.ToString);

//  if (FHeaders <> nil) and (FHeaders.Count > 0) then
//    Result.AddPair('headers', FHeaders.ToJson);
end;

end.
