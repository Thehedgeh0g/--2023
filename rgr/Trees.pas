UNIT Trees;

INTERFACE

  TYPE
    Dict = ^NodeType;
    NodeType = RECORD
                 Word: STRING;
                 Count: INTEGER;
                 Llink, RLink: Dict;
               END;
             
  PROCEDURE Insert(VAR Ptr: Dict; Data: STRING);             
  PROCEDURE PrintTree(VAR FOut: TEXT; Ptr: Dict);
  
IMPLEMENTATION


PROCEDURE Insert(VAR Ptr: Dict; Data: STRING);
VAR
  Leaf: NodeType;
BEGIN {Insert}
  
  IF Ptr = NIL
  THEN
    BEGIN 
      NEW(Ptr);
      Ptr^.Word := Data;
      Ptr^.LLink := NIL;
      Ptr^.RLink := NIL;
      Ptr^.Count := 0;
    END
  ELSE
    BEGIN
      
      IF Ptr^.Word > Data
      THEN
        Insert(Ptr^.LLink, Data) 
      ELSE
        IF Ptr^.Word < Data
        THEN
          Insert(Ptr^.RLink, Data) 
        ELSE
          Ptr^.Count := Ptr^.Count + 1
    END; 
         
END;

PROCEDURE PrintTree(VAR FOut: TEXT; Ptr: Dict);
BEGIN {PrintTree}
  IF Ptr <> NIL
  THEN  
    BEGIN
      PrintTree(FOut, Ptr^.LLink);
      WRITELN(FOut, Ptr^.Word, ': ', Ptr^.Count + 1);
      PrintTree(FOut, Ptr^.RLink)
    END
END;

BEGIN
END.

