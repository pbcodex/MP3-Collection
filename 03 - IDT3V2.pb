; Get tag ID3 v2
;
; Contributor : GallyHC
;
; PureBasic 5.44 -> 5.60
;

DisableASM
EnableExplicit

Global NewMap Frames.s()
Global Dim Genre.s(125)

Structure TAG_ID3V2
  tag.a[3]
  version.u
  reserved.a
  size.a[4]
EndStructure

Structure FRAME_ID3V2
  frame.a[4]
  size.a[4]
  reserved1.a
  reserved2.a
  reserved3.a
EndStructure

Global tags_id3v2.TAG_ID3V2
Global frame_id3v2.FRAME_ID3V2

Declare Start()
Declare GetSoundInfo(FileName.s, *Point)
Declare InitFrames()
Declare InitGenre()

Start()

Procedure Start()
  InitFrames()
  InitGenre()
  
  Protected filename.s = OpenFileRequester("Open MP3", "", "MP3 Files|*.mp3|All Files|*.*", 0)
  If FileName
    GetSoundInfo(FileName, tags_id3v2)
  EndIf
EndProcedure

Procedure GetSoundInfo(FileName.s, *Point)
  Protected *buffer, i, j, tagsize, frameid.s, framesize, result.s
  Protected File = ReadFile(#PB_Any, FileName, #PB_UTF8 | #PB_File_SharedRead)
  
  If file
    ReadData(file, tags_id3v2, SizeOf(TAG_ID3V2))
    If PeekS(@tags_id3v2\Tag, 3, #PB_UTF8) = "ID3"
      With tags_id3v2
        For i = 0 To 3
          tagsize  + \size[i] << (7 * (3 - i))
        Next i
      EndWith
      ;
      If tagsize > 0
        If *buffer
          FreeMemory(*buffer)
        EndIf
        *buffer = AllocateMemory(tagsize)
        ReadData(file, *buffer, tagsize)
        ;
        For i = 0 To tagsize
          CopyMemory(*buffer + i, @frame_id3v2, SizeOf(FRAME_ID3V2))
          framesize = 0
          For j = 0 To 3
            framesize + frame_id3v2\size[j] << (7 * (3 - j))
          Next j
          If framesize = 0
            Break
          EndIf
          ;
          Select frame_id3v2\reserved3 & $FF
            Case 0, 87
              result = PeekS(*buffer + 1 + SizeOf(FRAME_ID3V2) + i - 1, framesize - 1, #PB_UTF8)
              
            Case 1
              result = PeekS(*buffer + 1 + SizeOf(FRAME_ID3V2) + i - 1, (framesize / 2) - 1, #PB_Unicode)
          EndSelect
          
          If result <> #Null$
            frameid = PeekS(@frame_id3v2\frame, 4, #PB_UTF8)
            Debug "FRAME : "+ frameid + " -- (" + Frames(frameid) + ")"
            Debug result  
            Debug "--------------------------"
          EndIf
          ;
          i + SizeOf(FRAME_ID3V2) + framesize - 2
        Next i
        ;
      EndIf
      CloseFile(file)
    EndIf
  EndIf
EndProcedure

Procedure InitFrames()
  Frames("AENC") = "Audio encryption"
  Frames("APIC") = "Attached picture"
  Frames("ASPI") = "Audio seek point index"
  Frames("COMM") = "Comments"
  Frames("COMR") = "Commercial frame"
  Frames("ENCR") = "Encryption method registration"
  Frames("EQU2") = "Equalisation"
  Frames("ETCO") = "Event timing codes"
  Frames("GEOB") = "General encapsulated object"
  Frames("GRID") = "Group identification registration"
  Frames("LINK") = "Linked information"
  Frames("MCDI") = "Music CD identifier"
  Frames("MLLT") = "MPEG location lookup table"
  Frames("OWNE") = "Ownership frame"
  Frames("PRIV") = "Private frame"
  Frames("PCNT") = "Play counter"
  Frames("POPM") = "Popularimeter"
  Frames("POSS") = "Position synchronisation frame"
  Frames("RBUF") = "Recommended buffer size"
  Frames("RVA2") = "Relative volume adjustment (2)"
  Frames("RVRB") = "Reverb"
  Frames("SEEK") = "Seek frame"
  Frames("SIGN") = "Signature frame"
  Frames("SYLT") = "Synchronised lyric/text"
  Frames("SYTC") = "Synchronised tempo codes"
  Frames("TALB") = "Album/Movie/Show title"
  Frames("TBPM") = "BPM (beats per minute)"
  Frames("TCOM") = "Composer"
  Frames("TCON") = "Content type"
  Frames("TCOP") = "Copyright message"
  Frames("TDEN") = "Encoding time"
  Frames("TDLY") = "Playlist delay"
  Frames("TDOR") = "Original release time"
  Frames("TDRC") = "Recording time"
  Frames("TDRL") = "Release time"
  Frames("TDTG") = "Tagging time"
  Frames("TENC") = "Encoded by"
  Frames("TEXT") = "Lyricist/Text writer"
  Frames("TFLT") = "File type"
  Frames("TIPL") = "Involved people List"
  Frames("TIT1") = "Content group description"
  Frames("TIT2") = "Title/songname/content description"
  Frames("TIT3") = "Subtitle/Description refinement"
  Frames("TKEY") = "Initial key"
  Frames("TLAN") = "Language(s)"
  Frames("TLEN") = "Length"
  Frames("TMCL") = "Musician credits List"
  Frames("TMED") = "Media type"
  Frames("TMOO") = "Mood"
  Frames("TOAL") = "Original album/movie/show title"
  Frames("TOFN") = "Original filename"
  Frames("TOLY") = "Original lyricist(s)/text writer(s)"
  Frames("TOPE") = "Original artist(s)/performer(s)"
  Frames("TOWN") = "File owner/licensee"
  Frames("TPE1") = "Lead performer(s)/Soloist(s)"
  Frames("TPE2") = "Band/orchestra/accompaniment"
  Frames("TPE3") = "Conductor/performer refinement"
  Frames("TPE4") = "Interpreted, remixed, Or otherwise modified by"
  Frames("TPOS") = "Part of a set"
  Frames("TPRO") = "Produced notice"
  Frames("TPUB") = "Publisher"
  Frames("TRCK") = "Track number/Position in set"
  Frames("TRSN") = "Internet radio station name"
  Frames("TRSO") = "Internet radio station owner"
  Frames("TSOA") = "Album sort order"
  Frames("TSOP") = "Performer sort order"
  Frames("TSOT") = "Title sort order"
  Frames("TSRC") = "ISRC (international standard recording code)"
  Frames("TSSE") = "Software/Hardware And settings used For encoding"
  Frames("TSST") = "Set subtitle"
  Frames("TYER") = "Year"
  Frames("TXXX") = "User defined text information frame"
  Frames("UFID") = "Unique file identifier"
  Frames("USER") = "Terms of use"
  Frames("USLT") = "Unsynchronised lyric/text transcription"
  Frames("WCOM") = "Commercial information"
  Frames("WCOP") = "Copyright/Legal information"
  Frames("WOAF") = "Official audio file webpage"
  Frames("WOAR") = "Official artist/performer webpage"
  Frames("WOAS") = "Official audio source webpage"
  Frames("WORS") = "Official Internet radio station homepage"
  Frames("WPAY") = "Payment"
  Frames("WPUB") = "Publishers official webpage"
  Frames("WXXX") = "User defined URL link frame"
EndProcedure

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
; CursorPosition = 87
; FirstLine = 58
; Folding = -v
; EnableXP