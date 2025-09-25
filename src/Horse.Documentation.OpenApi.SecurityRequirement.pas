unit Horse.Documentation.OpenApi.SecurityRequirement;

interface

uses
  System.JSON,
  System.Classes,
  System.TypInfo,
  System.SysUtils,
  System.Generics.Collections,
  Horse.Documentation.OpenApi.Types,
  Horse.Documentation.OpenApi.Ancestor,
  Horse.Documentation.OpenApi.Interfaces;

type
  TSecurityRequirement<T> = class(TOpenApiAncestor, ISecurityRequirement<T>)
  private
    FParent: T;
    FSchemeName: string;
    FScopes: TOpenApiList<string, ISecurityRequirement<T>>;

    constructor Create(AParent: T);
  public
    class function New(AParent: T): ISecurityRequirement<T>; static;
    function ToJson: TJSONObject;

    function SchemeName: string; overload;
    function SchemeName(const AValue: string): ISecurityRequirement<T>; overload;
    function Scopes: TOpenApiList<string, ISecurityRequirement<T>>;
    function &End: T;
  end;

implementation

{ TSecurityRequirement<T> }

constructor TSecurityRequirement<T>.Create(AParent: T);
begin
  inherited Create;
  FParent := AParent;
  FScopes := TOpenApiList<string, ISecurityRequirement<T>>.Create(Self);
end;

function TSecurityRequirement<T>.&End: T;
begin
  Result := FParent;
end;

class function TSecurityRequirement<T>.New(AParent: T): ISecurityRequirement<T>;
begin
  Result := TSecurityRequirement<T>.Create(AParent);
end;

function TSecurityRequirement<T>.SchemeName: string;
begin
  Result := FSchemeName;
end;

function TSecurityRequirement<T>.SchemeName(const AValue: string): ISecurityRequirement<T>;
begin
  Result := Self;
  FSchemeName := AValue;
end;

function TSecurityRequirement<T>.Scopes: TOpenApiList<string, ISecurityRequirement<T>>;
begin
  Result := FScopes;
end;

function TSecurityRequirement<T>.ToJson: TJSONObject;
begin
  Result := inherited ToJson;

  if (not FSchemeName.IsEmpty) then
    Result.AddPair(FSchemeName, FScopes.ToJson);
end;

end.

