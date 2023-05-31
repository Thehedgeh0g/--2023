UNIT FileManager;

INTERFACE

USES 
  Trees;

PROCEDURE ClearDict(VAR Root: Dict);
PROCEDURE PrintDictFile(VAR FOut: TEXT);

IMPLEMENTATION
TYPE
  DictFile = FILE OF NodeType;
VAR
  IsFirstDict: BOOLEAN;  
  TempFile1, TempFile2: DictFile;
  
PROCEDURE DisposeDict(VAR Root: Dict);
BEGIN
  IF Root <> NIL
  THEN
    BEGIN
      DisposeDict(Root^.LLink);
      DisposeDict(Root^.RLink);
      DISPOSE(Root);
      Root := NIL
    END
END;  
  
PROCEDURE CopyDictToFile(VAR Root: Dict; VAR FOut: DictFile);
BEGIN
  IF Root <> NIL
  THEN
    BEGIN
      CopyDictToFile(Root^.LLink, FOut);
      WRITE(FOut, Root^);
      CopyDictToFile(Root^.RLink, FOut)
    END
END; 

PROCEDURE InsertIntoFile(VAR Ptr: Dict; VAR FilePtr: NodeType; VAR FilePtrReaded: BOOLEAN);
VAR
  PtrPositionFound, PtrInserted: BOOLEAN;
BEGIN
  IF Ptr <> NIL
  THEN
    BEGIN
      InsertIntoFile(Ptr^.LLink, FilePtr, FilePtrReaded);
      PtrPositionFound := FALSE;
      PtrInserted := FALSE;
      WHILE(NOT PtrPositionFound) AND (NOT PtrInserted) AND (NOT EOF(TempFile1))
      DO
        BEGIN
          IF NOT FilePtrReaded
          THEN
            READ(TempFile1, FilePtr);
            
          IF FilePtr.Word < Ptr^.Word
          THEN
            BEGIN
              WRITE(TempFile2, FilePtr);
              FilePtrReaded := FALSE
            END
          ELSE
            IF FilePtr.Word = Ptr^.Word
            THEN
              BEGIN
                FilePtr.Count := FilePtr.Count + Ptr^.Count;
                WRITE(TempFile2, FilePtr);
                PtrInserted := TRUE;
                FilePtrReaded := FALSE
              END
            ELSE
              BEGIN
                PtrPositionFound := TRUE;
                FilePtrReaded := TRUE
              END    
        END;
      IF NOT PtrInserted
      THEN
        WRITE(TempFile2, Ptr^);
      InsertIntoFile(Ptr^.RLink, FilePtr, FilePtrReaded)  
    END
END;

PROCEDURE MergeDictWithFile(VAR Root: Dict);
VAR
  FilePtr: NodeType;
  FilePtrReaded: BOOLEAN;
BEGIN
  RESET(TempFile1);
  REWRITE(TempFile2);
  FilePtrReaded := FALSE;
  InsertIntoFile(Root, FilePtr, FilePtrReaded);   
  IF FilePtrReaded
  THEN
    WRITE(TempFile2, FilePtr);
  WHILE NOT EOF(TempFile1)
  DO
    BEGIN
      READ(TempFile1, FilePtr);
      WRITE(TempFile2, FilePtr)
    END;
    
  RESET(TempFile2);
  REWRITE(TempFile1);
  WHILE NOT EOF(TempFile2)
  DO
    BEGIN
      READ(TempFile2, FilePtr);
      WRITE(TempFile1, FilePtr)
    END    
END;     

PROCEDURE ClearDict(VAR Root: Dict);
BEGIN
  IF IsFirstDict
  THEN
    BEGIN
      REWRITE(TempFile1);
      CopyDictToFile(Root, TempFile1);
      IsFirstDict := FALSE
    END
  ELSE
    MergeDictWithFile(Root);
  DisposeDict(Root)  
END; 

PROCEDURE PrintDictFile(VAR FOut: TEXT);
VAR
  FilePtr: NodeType;
BEGIN
  RESET(TempFile1);
  WRITELN('Printing dictionary...');
  WHILE NOT EOF(TempFile1)
  DO
    BEGIN
      READ(TempFile1, FilePtr);
      WRITELN(FOut, FilePtr.Word, ': ', FilePtr.Count + 1)
    END;
  REWRITE(TempFile1)
END;
    
BEGIN
  IsFirstDict := TRUE;
  //ASSIGN(TempFile1, 'Temp')
END.

