{----------------------------------------}
{                                        }
{  DXF file l‚trehoz sa, adatok ki¡r sa  }
{                                        }
{  Alakzatok:  vonal, k”r, ¡v, sz”veg    }
{                                        }
{----------------------------------------}
UNIT DXF ;

INTERFACE

USES
  Crt, Dos ;

{---------------------------}
{ DXF file megnyit sa ¡r sa }
{---------------------------}
{ Param‚ter: File n‚v       }
{---------------------------}
{ Eredm‚ny: True, ha sikeres}
{ volt a file megnyit sa    }
{---------------------------}
FUNCTION OpenDXFFileToWrite(DXF_FName : String) : Boolean ;

{---------------------------}
{ DXF file bez r sa         }
{---------------------------}
{ Eredm‚ny: True, ha sikeres}
{ volt a file bez r sa      }
{---------------------------}
FUNCTION CloseDXF : Boolean ;

{---------------------------}
{ Vonal adatok ki¡r sa      }
{---------------------------}
PROCEDURE WriteLineToDXF(P1X, P1Y, P1Z, P2X, P2Y, P2Z : Real) ;

{---------------------------}
{ K”r adatok ki¡r sa        }
{---------------------------}
PROCEDURE WriteCircToDXF(P1X, P1Y, P1Z, R : Real) ;

{---------------------------}
{ Öv adatok ki¡r sa         }
{---------------------------}
PROCEDURE WriteArcToDXF(P1X, P1Y, P1Z, R, Alfa1, Alfa2 : Real) ;

{---------------------------}
{ Sz”veg ¡r sa DXF file-ba  }
{---------------------------}
PROCEDURE WriteTextToDXF( PX, PY, PZ, H, Rot : Real ;
                          S : String) ;

{---------------------------}

  IMPLEMENTATION

{---------------------------}

VAR
  DXFFile : Text ;  { Sz”veg file defini l sa }

{---------------------------}
{ DXF file megnyit sa ¡r sa }
{---------------------------}
{ Param‚ter: File n‚v       }
{---------------------------}
{ Eredm‚ny: True, ha sikeres}
{ volt a file megnyit s     }
{---------------------------}
FUNCTION OpenDXFFileToWrite(DXF_FName : String) : Boolean ;
  BEGIN
    {$I-}
    Assign(DXFFile, DXF_FName) ;
    ReWrite(DXFFile) ;
    {$I+}
    OpenDXFFileToWrite := False ;

    IF IoResult = 0    { ha nincs hiba akkor ¡runk... }
      THEN BEGIN
        OpenDXFFileToWrite := True ;     { Open / megnyit sa OK }
        { DXF file fejl‚c ki¡r sa: }
        Writeln(DXFFile, '0') ;
        Writeln(DXFFile, 'SECTION') ;
        Writeln(DXFFile, '2') ;
        Writeln(DXFFile, 'ENTITIES') ;
      END
      ELSE OpenDXFFileToWrite := False ;  { Open Error / file megnyit s hiba }
  END ;

{---------------------------}
{ DXF file bez r sa         }
{---------------------------}
{ Eredm‚ny: True, ha sikeres}
{ volt a file bez r sa      }
{---------------------------}

FUNCTION CloseDXF : Boolean ;
  BEGIN
    { DXF file v‚ge }
    Writeln(DXFFile, '0') ;
    Writeln(DXFFile, 'ENDSEC') ;
    Writeln(DXFFile, '0') ;
    Writeln(DXFFile, 'EOF') ;
    {$I-}
    Close(DXFFile) ;
    {$I+}
    IF IoResult = 0
      THEN CloseDXF := True
      ELSE CloseDXF := False ;
  END ;

{-------------------------------------}
{ Sz”veg elej‚n l‚v‹ sz¢k”z”k t”rl‚se }
{-------------------------------------}
FUNCTION DelHomeSpace(VAR S : String) : String ;
  BEGIN
    IF Length(S) > 0 THEN
      WHILE S[1] = ' ' DO Delete(S, 1, 1) ;
  END ;

{-------------------------------------}
{ Real adat sz”vegg‚ alak¡t sa        }
{-------------------------------------}
FUNCTION JStr(Data : Real) : String ;
  VAR
    S : String ;
  BEGIN
    Str(Data:15:8, S) ;
    DelHomeSpace(S) ;
    { Tizedes vessz‹ cser‚je tizedes pontra: }
    IF Pos(',', S) > 0 THEN S[Pos(',', S)] := '.' ;
    JStr := S ;
  END ;

{---------------------------}
{ Vonal adatok ki¡r sa      }
{---------------------------}
PROCEDURE WriteLineToDXF(P1X, P1Y, P1Z, P2X, P2Y, P2Z : Real) ;
  BEGIN
    Writeln(DXFFile, '0') ;
    Writeln(DXFFile, 'LINE') ;
    Writeln(DXFFile, '8') ;
    Writeln(DXFFile, 'Polygon') ;
    Writeln(DXFFile, '10') ;
    Writeln(DXFFile, JStr(P1X)) ;
    Writeln(DXFFile, '20') ;
    Writeln(DXFFile, JStr(P1Y)) ;
    Writeln(DXFFile, '30') ;
    Writeln(DXFFile, JStr(P1Z)) ;
    Writeln(DXFFile, '11') ;
    Writeln(DXFFile, JStr(P2X)) ;
    Writeln(DXFFile, '21') ;
    Writeln(DXFFile, JStr(P2Y)) ;
    Writeln(DXFFile, '31') ;
    Writeln(DXFFile, JStr(P2Z)) ;
  END ;

{---------------------------}
{ K”r adatok ki¡r sa        }
{---------------------------}
PROCEDURE WriteCircToDXF(P1X, P1Y, P1Z, R : Real) ;
  BEGIN
    Writeln(DXFFile, '0') ;
    Writeln(DXFFile, 'CIRCLE') ;
    Writeln(DXFFile, '8') ;
    Writeln(DXFFile, 'Polygon') ;
    Writeln(DXFFile, '10') ;
    Writeln(DXFFile, JStr(P1X)) ;
    Writeln(DXFFile, '20') ;
    Writeln(DXFFile, JStr(P1Y)) ;
    Writeln(DXFFile, '30') ;
    Writeln(DXFFile, JStr(P1Z)) ;
    Writeln(DXFFile, '40') ;
    Writeln(DXFFile, JStr(R)) ;
  END ;

{---------------------------}
{ Öv adatok ki¡r sa         }
{---------------------------}
PROCEDURE WriteArcToDXF(P1X, P1Y, P1Z, R, Alfa1, Alfa2 : Real) ;
  BEGIN
    Writeln(DXFFile, '0') ;
    Writeln(DXFFile, 'ARC') ;
    Writeln(DXFFile, '8') ;
    Writeln(DXFFile, 'Polygon') ;
    Writeln(DXFFile, '10') ;
    Writeln(DXFFile, JStr(P1X)) ;
    Writeln(DXFFile, '20') ;
    Writeln(DXFFile, JStr(P1Y)) ;
    Writeln(DXFFile, '30') ;
    Writeln(DXFFile, JStr(P1Z)) ;
    Writeln(DXFFile, '40') ;
    Writeln(DXFFile, JStr(R)) ;
    Writeln(DXFFile, '50') ;
    Writeln(DXFFile, JStr(Alfa1)) ;
    Writeln(DXFFile, '51') ;
    Writeln(DXFFile, JStr(Alfa2)) ;
  END ;

{---------------------------}
{ Sz”veg ¡r sa DXF file-ba  }
{---------------------------}
{ H : beutmagassag
  Rot : forgatás szöge 
  SC  : "width scale factor" skálázási faktor (X irány)
  DO  : dontott betu - dontés (fok)}
PROCEDURE WriteTextToDXF( PX, PY, PZ, H, Rot, SC, DO : Real ;
                          S : String) ;
  BEGIN
    Writeln(DXFFile, '0') ;
    Writeln(DXFFile, 'TEXT') ;
    Writeln(DXFFile, '8') ;
    Writeln(DXFFile, 'Polygon') ;
    Writeln(DXFFile, '10') ;
    Writeln(DXFFile, JStr(PX)) ;
    Writeln(DXFFile, '20') ;
    Writeln(DXFFile, JStr(PY)) ;
    Writeln(DXFFile, '30') ;
    Writeln(DXFFile, JStr(PZ)) ;
    Writeln(DXFFile, '40') ;
    Writeln(DXFFile, JStr(H)) ;
    Writeln(DXFFile, '41') ;
    Writeln(DXFFile, JStr(SC)) ;
    Writeln(DXFFile, '50') ;
    Writeln(DXFFile, JStr(Rot)) ;
    Writeln(DXFFile, '51') ;
    Writeln(DXFFile, JStr(DO)) ;
    Writeln(DXFFile, '1') ;
    Writeln(DXFFile, S) ;
  END ;

{-----------------------------------------------------------------}

{ ROSSZ!!!   ROSSZ!!!   ROSSZ!!!   ROSSZ!!!   ROSSZ!!!   ROSSZ!!! }

{-----------------------------------------------------------------}
{  K¢tavonal adatok ki¡r sa DXF file-ba                           }
{-----------------------------------------------------------------}
(* PROCEDURE WriteDimToDXF( P1X, P1Y, P1Z : Real ;
                         P2X, P2Y, P2Z : Real ;
                         P3X, P3Y, P3Z : Real ;
                         P4X, P4Y, P4Z : Real ;
                         Rot : Real ;
                         Typ : Byte ;
                         S : String ) ;
  BEGIN
    Writeln(DXFFile, '0') ;
    Writeln(DXFFile, 'DIMENSION') ;
    Writeln(DXFFile, '8') ;
    Writeln(DXFFile, 'Polygon') ;
    Writeln(DXFFile, '10') ;
    Writeln(DXFFile, JStr(P1X)) ;
    Writeln(DXFFile, '20') ;
    Writeln(DXFFile, JStr(P1Y)) ;
    Writeln(DXFFile, '30') ;
    Writeln(DXFFile, JStr(P1Z)) ;
    Writeln(DXFFile, '11') ;
    Writeln(DXFFile, JStr(P2X)) ;
    Writeln(DXFFile, '21') ;
    Writeln(DXFFile, JStr(P2Y)) ;
    Writeln(DXFFile, '31') ;
    Writeln(DXFFile, JStr(P2Z)) ;
    Writeln(DXFFile, '13') ;
    Writeln(DXFFile, JStr(P3X)) ;
    Writeln(DXFFile, '23') ;
    Writeln(DXFFile, JStr(P3Y)) ;
    Writeln(DXFFile, '33') ;
    Writeln(DXFFile, JStr(P3Z)) ;
    Writeln(DXFFile, '14') ;
    Writeln(DXFFile, JStr(P4X)) ;
    Writeln(DXFFile, '24') ;
    Writeln(DXFFile, JStr(P4Y)) ;
    Writeln(DXFFile, '34') ;
    Writeln(DXFFile, JStr(P4Z)) ;
    Writeln(DXFFile, '70') ;
    Writeln(DXFFile, Typ) ;
    Writeln(DXFFile, '53') ;
    Writeln(DXFFile, JStr(Rot)) ;
    Writeln(DXFFile, '1') ;
    Writeln(DXFFile, S) ;
  END ;
*)

BEGIN
END.
