UNIT Strings;

INTERFACE
  PROCEDURE ReadWord(VAR FIn: TEXT; VAR Word: STRING);

IMPLEMENTATION
 
CONST
  Alphabet = ['A' .. 'Z', 'a' .. 'z', 'À' .. 'ß', 'à' .. 'ÿ', '¨', '¸', '-'];
  DashChar = '-';
  EmptyWord = '';

PROCEDURE CheckDashes(VAR Word: STRING);
VAR
  DashPos: INTEGER;
BEGIN
  DashPos := POS(DashChar, Word);
  IF (Word[1] = DashChar) OR (Word[LENGTH(Word)] = DashChar) OR (Word[DashPos+1] = DashChar)
  THEN
    Word := EmptyWord
END;  
  
FUNCTION ValidateSym(VAR Ch: CHAR): BOOLEAN;
BEGIN
  IF Ch IN Alphabet
  THEN
    Result := TRUE
  ELSE
    Result := FALSE   
END; 

FUNCTION ToLowerCase(VAR Ch: CHAR): CHAR;
BEGIN
  CASE Ch OF
    'A': ToLowerCase := 'a';
    'B': ToLowerCase := 'b';
    'C': ToLowerCase := 'c';
    'D': ToLowerCase := 'd';
    'E': ToLowerCase := 'e';
    'F': ToLowerCase := 'f';
    'G': ToLowerCase := 'g';
    'H': ToLowerCase := 'h';
    'I': ToLowerCase := 'i';
    'J': ToLowerCase := 'j';
    'K': ToLowerCase := 'k';
    'L': ToLowerCase := 'l';
    'M': ToLowerCase := 'm';
    'N': ToLowerCase := 'n';
    'O': ToLowerCase := 'o';
    'P': ToLowerCase := 'p';
    'Q': ToLowerCase := 'q';
    'R': ToLowerCase := 'r';
    'S': ToLowerCase := 's';
    'T': ToLowerCase := 't';
    'U': ToLowerCase := 'u';
    'V': ToLowerCase := 'v';
    'W': ToLowerCase := 'w';
    'X': ToLowerCase := 'x';
    'Y': ToLowerCase := 'y';
    'Z': ToLowerCase := 'z';
    'À': ToLowerCase := 'à';
    'Á': ToLowerCase := 'á';
    'Â': ToLowerCase := 'â';
    'Ã': ToLowerCase := 'ã';
    'Ä': ToLowerCase := 'ä';
    'Å': ToLowerCase := 'å';
    '¨': ToLowerCase := 'å';
    '¸': ToLowerCase := 'å';
    'Æ': ToLowerCase := 'æ';
    'Ç': ToLowerCase := 'ç';
    'È': ToLowerCase := 'è';
    'É': ToLowerCase := 'é';
    'Ê': ToLowerCase := 'ê';
    'Ë': ToLowerCase := 'ë';
    'Ì': ToLowerCase := 'ì';
    'Í': ToLowerCase := 'í';
    'Î': ToLowerCase := 'î';
    'Ï': ToLowerCase := 'ï';
    'Ð': ToLowerCase := 'ð';
    'Ñ': ToLowerCase := 'ñ';
    'Ò': ToLowerCase := 'ò';
    'Ó': ToLowerCase := 'ó';
    'Ô': ToLowerCase := 'ô';
    'Õ': ToLowerCase := 'õ';
    'Ö': ToLowerCase := 'ö';
    '×': ToLowerCase := '÷';
    'Ø': ToLowerCase := 'ø';
    'Ù': ToLowerCase := 'ù';
    'Ú': ToLowerCase := 'ú';
    'Û': ToLowerCase := 'û';
    'Ü': ToLowerCase := 'ü';
    'Ý': ToLowerCase := 'ý';
    'Þ': ToLowerCase := 'þ';
    'ß': ToLowerCase := 'ÿ';
    ELSE ToLowerCase := Ch
  END  
END; 

PROCEDURE ReadWord(VAR FIn: TEXT; VAR Word: STRING);
VAR
  Ch: CHAR;
BEGIN
  REPEAT
    READ(FIn, Ch);
    IF (Ch IN Alphabet) AND (NOT EOF(FIn))
    THEN
      BEGIN
        Ch  := ToLowerCase(Ch);
        Word := Word + Ch
      END
    ELSE
      CheckDashes(Word)
  UNTIL 
    EOF(FIn) OR (NOT (Ch IN Alphabet) AND (Word <> EmptyWord))
END;

BEGIN
END.

 
