;Ref : http://mgc99.free.fr/InfoMP3.html
EnableExplicit

Global FileName.s
Global Dim Genre.s(125)

Structure TAG_ID3V1
  Tag.a[3]      ;Doit contenir "TAG" sinon ce n'est pas un tag ID3 v1
  Title.a[30]
  Artist.a[30]
  Album.a[30]
  Year.a[4]
  Comment.a[30]
  Genre.a[1]
EndStructure
Global mp3.TAG_ID3V1

Declare InitGenre()

;Pour lire le tag ID3 v1 il faut se placer à 128 octets de la fin du fichier
Procedure GetSoundInfo(FileName.s, *Point)
  Protected File = ReadFile(#PB_Any, FileName, #PB_UTF8)
  If File
    FileSeek(File, Lof(File) - 128)
    ReadData(File, *Point, SizeOf(TAG_ID3V1))
    CloseFile(File)
  EndIf
EndProcedure

InitGenre()
FileName.s = OpenFileRequester("Open MP3", "", "MP3 Files|*.mp3|All Files|*.*", 0)
If FileName
  GetSoundInfo(FileName, mp3)
  
  With mp3
    ;Si les 3 premiers octets représentent la mention "TAG"
    If PeekS(@\Tag, 3, #PB_UTF8) = "TAG"
      Debug PeekS(@\Title, -1, #PB_UTF8)
      Debug PeekS(@\Artist, -1, #PB_UTF8)
      Debug PeekS(@\Album, -1, #PB_UTF8)
      Debug PeekS(@\Year, -1, #PB_UTF8)
      Debug PeekS(@\Comment, -1, #PB_UTF8)
      If \Genre > -1 And \Genre < 126
        Debug Genre(\Genre)
      EndIf
    Else
      Debug "This is not a tag ID3 v1"
    EndIf
  EndWith
EndIf

Procedure InitGenre()
  Genre(0) = "Blues"
  Genre(1) = "Classic Rock"
  Genre(2) = "Country"
  Genre(3) = "Dance"
  Genre(4) = "Disco"
  Genre(5) = "Funk"
  Genre(6) = "Grunge"
  Genre(7) = "Hip-Hop"
  Genre(8) = "Jazz"
  Genre(9) = "Metal"
  Genre(10) = "New Age"
  Genre(11) = "Oldies"
  Genre(12) = "Other"
  Genre(13) = "Pop"
  Genre(14) = "R&B"
  Genre(15) = "Rap"
  Genre(16) = "Reggae"
  Genre(17) = "Rock"
  Genre(18) = "Techno"
  Genre(19) = "Industrial"
  Genre(20) = "Alternative"
  Genre(21) = "Ska"
  Genre(22) = "Death Metal"
  Genre(23) = "Pranks"
  Genre(24) = "Soundtrack"
  Genre(25) = "Euro-Techno"
  Genre(26) = "Ambient"
  Genre(27) = "Trip-Hop"
  Genre(28) = "Vocal"
  Genre(29) = "Jazz+Funk"
  Genre(30) = "Fusion"
  Genre(31) = "Trance"
  Genre(32) = "Classical"
  Genre(33) = "Instrumental"
  Genre(34) = "Acid"
  Genre(35) = "House"
  Genre(36) = "Game"
  Genre(37) = "Sound Clip"
  Genre(38) = "Gospel"
  Genre(39) = "Noise"
  Genre(40) = "AlternRock"
  Genre(41) = "Bass"
  Genre(42) = "Soul"
  Genre(43) = "Punk"
  Genre(44) = "Space"
  Genre(45) = "Meditative"
  Genre(46) = "Instrumental Pop"
  Genre(47) = "Instrumental Rock"
  Genre(48) = "Ethnic"
  Genre(49) = "Gothic"
  Genre(50) = "Darkwave"
  Genre(51) = "Techno-Industrial"
  Genre(52) = "Electronic"
  Genre(53) = "Pop-Folk"
  Genre(54) = "Eurodance"
  Genre(55) = "Dream"
  Genre(56) = "Southern Rock"
  Genre(57) = "Comedy"
  Genre(58) = "Cult"
  Genre(59) = "Gangsta"
  Genre(60) = "Top 40"
  Genre(61) = "Christian Rap"
  Genre(62) = "PopFunk"
  Genre(63) = "Jungle"
  Genre(64) = "Native American"
  Genre(65) = "Cabaret"
  Genre(66) = "New Wave"
  Genre(67) = "Psychadelic"
  Genre(68) = "Rave"
  Genre(69) = "Showtunes"
  Genre(70) = "Trailer"
  Genre(71) = "Lo-Fi"
  Genre(72) = "Tribal"
  Genre(73) = "Acid Punk"
  Genre(74) = "Acid Jazz"
  Genre(75) = "Polka"
  Genre(76) = "Retro"
  Genre(77) = "Musical"
  Genre(78) = "Rock & Roll"
  Genre(79) = "Hard Rock"
  Genre(80) = "Folk"
  Genre(81) = "Folk-Rock"
  Genre(82) = "National Folk"
  Genre(83) = "Swing"
  Genre(84) = "Fast Fusion"
  Genre(85) = "Bebob"
  Genre(86) = "Latin"
  Genre(87) = "Revival"
  Genre(88) = "Celtic"
  Genre(89) = "Bluegrass"
  Genre(90) = "Avantgarde"
  Genre(91) = "Gothic Rock"
  Genre(92) = "Progressive Rock"
  Genre(93) = "Psychedelic Rock"
  Genre(94) = "Symphonic Rock"
  Genre(95) = "Slow Rock"
  Genre(96) = "Big Band"
  Genre(97) = "Chorus"
  Genre(98) = "Easy Listening"
  Genre(99) = "Acoustic"
  Genre(100) = "Humour"
  Genre(101) = "Speech"
  Genre(102) = "Chanson"
  Genre(103) = "Opera"
  Genre(104) = "Chamber Music"
  Genre(105) = "Sonata"
  Genre(106) = "Symphony"
  Genre(107) = "Booty Bass"
  Genre(108) = "Primus"
  Genre(109) = "Porn Groove"
  Genre(110) = "Satire"
  Genre(111) = "Slow Jam"
  Genre(112) = "Club"
  Genre(113) = "Tango"
  Genre(114) = "Samba"
  Genre(115) = "Folklore"
  Genre(116) = "Ballad"
  Genre(117) = "Power Ballad"
  Genre(118) = "Rhythmic Soul"
  Genre(119) = "Freestyle"
  Genre(120) = "Duet"
  Genre(121) = "Punk Rock"
  Genre(122) = "Drum Solo"
  Genre(123) = "A capella"
  Genre(124) = "Euro-House"
  Genre(125) = "Dance Hall"
EndProcedure
; IDE Options = PureBasic 5.60 (Windows - x86)
; CursorPosition = 29
; Folding = --
; EnableXP