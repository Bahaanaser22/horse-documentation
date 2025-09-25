unit Horse.Documentation.OpenApi.Utils;

interface

uses
  System.JSON,
  System.Rtti,
  System.SysUtils,
  System.Variants,
  System.Generics.Collections;

type
  TUtils = class
  public
    class function ValueToJson(const AValue: TValue): TJSONValue; static;
  end;

implementation

{ TUtils }

class function TUtils.ValueToJson(const AValue: TValue): TJSONValue;
var
  LJsonObj: TJSONObject;
  LJsonArray: TJSONArray;
  LDict: TDictionary<string, TValue>;
  LList: TList<TValue>;
  LArray: TArray<TValue>;
begin
  if VarIsNull(AValue.IsEmpty) then
    Exit(TJSONNull.Create);

  // Tratamento de tipos primitivos
  case VarType(AValue.AsVariant) of
    varSmallInt, varInteger, varShortInt, varByte, varWord, varLongWord, varInt64:
      Exit(TJSONNumber.Create(AValue.AsInt64));
    varSingle, varDouble, varCurrency:
      Exit(TJSONNumber.Create(AValue.AsExtended));
    varBoolean:
      Exit(TJSONBool.Create(AValue.AsBoolean));
    varOleStr, varStrArg, varUString, varString:
      Exit(TJSONString.Create(AValue.AsString));
  end;

  // Tratamento de tipos complexos (objetos e listas gen�ricas)
  if AValue.IsObject then
  begin
    if (AValue.IsArray) and (AValue.IsType<TArray<TValue>>) then
    begin
      LArray := AValue.AsType<TArray<TValue>>;
      LJsonArray := TJSONArray.Create;
      for var LItem in LArray do
        LJsonArray.AddElement(ValueToJson(LItem));
      Exit(LJsonArray);
    end
    else if AValue.IsType<TDictionary<string, TValue>> then
    begin
      LDict := AValue.AsType<TDictionary<string, TValue>>;
      LJsonObj := TJSONObject.Create;
      for var LPair in LDict do
        LJsonObj.AddPair(LPair.Key, ValueToJson(LPair.Value));
      Exit(LJsonObj);
    end
    else if AValue.IsType<TList<TValue>> then
    begin
      LList := AValue.AsType<TList<TValue>>;
      LJsonArray := TJSONArray.Create;
      for var LItem in LList do
        LJsonArray.AddElement(ValueToJson(LItem));
      Exit(LJsonArray);
    end;
  end;

  // Se nenhum tipo for reconhecido, retorna null
  Result := TJSONNull.Create;
end;

end.
