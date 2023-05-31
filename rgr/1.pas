PROGRAM DictionaryMaker(INPUT, OUTPUT);
CONST
  Split = 100000;
USES 
  Strings, Trees, FileManager;

VAR
  FOut, FIn: TEXT;
  NewDict: Dict;
  NewWord: STRING;
  Counter: INTEGER;
  
BEGIN
  WRITELN('Creating dictionary...');
  Counter := 1;
  ASSIGN(FIn, 'wap.txt');
  ASSIGN(FOut, 'FOut.txt');
  RESET(FIn);
  REWRITE(FOut);
  NewDict := NIL;                    
  WHILE NOT EOF(FIn)
  DO
    BEGIN 
      ReadWord(FIn, NewWord);
      IF NOT (NewWord = '')
      THEN
        BEGIN
          Insert(NewDict, NewWord);
          
          IF Counter MOD ((Split DIV 100) * 5) = 0 
          THEN 
            WRITELN('Words inserted: ', Counter);
            
          IF Counter MOD Split = 0 
          THEN
            ClearDict(NewDict);
            
          NewWord := '';
          Counter := Counter + 1;
        END 
    END;  
  WRITELN('Dictionary created');
    
  ClearDict(NewDict);
  IF Counter MOD ((Split DIV 100) * 5) <> 0 
  THEN 
    WRITELN('Words inserted: ', Counter);
   
  PrintDictFile(FOut);
  WRITELN('Dictionary printed')
END.               


