;Get tag ID3 v1
;
; Contributor : Falsam
;
; PureBasic 5.44 -> 5.60
.
;Ref : http://mgc99.free.fr/InfoMP3.html

File.s = OpenFileRequester("Open MP3", "", "MP3 Files|*.mp3|All Files|*.*", 0)

If ReadFile(0, File) 
  *Pointer = AllocateMemory(128) 
  
  ;Pour lire le tag ID3 v1 il faut se placer à 128 octets de la fin du fichier
  FileSeek(0, Lof(0)-128) 
  ReadData(0, *Pointer, 128) 
  
  ;Si les 3 premiers octets représentent la mention "TAG"
  If PeekS(*Pointer, 3, #PB_UTF8) = "TAG"
    Debug "#Zone Tag ID3 v1 présent"
    titre$    = Trim(PeekS(*Pointer   +  3, 30, #PB_UTF8))
    artist$   = Trim(PeekS(*Pointer   + 33, 30, #PB_UTF8)) 
    album$    = Trim(PeekS(*Pointer   + 63, 30, #PB_UTF8)) 
    year$     = Trim(PeekS(*Pointer   + 93,  4, #PB_UTF8)) 
    comment$  = Trim(PeekS(*Pointer   + 97, 30, #PB_UTF8))
    genre     = PeekB(*Pointer + 127) 
    
    FreeMemory(*Pointer) 
    
    Debug "Titre "    + titre$ 
    Debug "Artiste "  + artist$ 
    Debug "Album "    + album$ 
    Debug "Années "   + year$ 
    Debug "Commentaire " + comment$
    Debug "Genre " + genre
    
  Else
    
    Debug "Pas de tag ID3 v1" + #CRLF$
  EndIf    
EndIf
; IDE Options = PureBasic 5.60 (Windows - x86)
; CursorPosition = 12
; Folding = -
; EnableXP