PROGRAM Generator(INPUT, OUTPUT);
VAR
 J, Counter: INTEGER;
 Word: STRING;
 I, Ch: CHAR;
 FOut: TEXT;
 
BEGIN
  ASSIGN(FOut, 'Test.txt');
  REWRITE(FOut);
  Word := '';
  FOR I := 'A' TO 'z' 
  DO 
    BEGIN
      FOR Ch := 'A' TO 'z' 
      DO
        BEGIN 
          FOR J := 0 to 255 do
          BEGIN
            Counter := Counter + 1;
            Word := Word + Ch + I;
            if counter mod 1000 = 0 then WRITE(' ', Word);
            WRITE(FOut, ' ', Word)
          END;  
        END;
      Word :=  ''  
    END;    
  WRITELN(Counter)
END. 
