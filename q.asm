include Irvine32.inc

.data

Toad1		 byte 0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0
Toad2		 byte 0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0
Toad3		 byte 0,0,0,0,1,1,2,1,1,0,0,0,0,0,0,0,0,0,1,1,2,1,1,0,0,0,0,0
Toad4		 byte 0,0,0,1,1,2,2,2,1,1,0,0,0,0,0,0,0,1,1,2,2,2,1,1,0,0,0,0
Toad5		 byte 0,0,0,0,1,1,2,1,1,0,0,0,0,0,0,0,0,0,1,1,2,1,1,0,0,0,0,0
Toad6		 byte 0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0
Toad7		 byte 0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0
r		     byte 0
g			 byte 0
b			 byte 0
ToadPosX	 byte 0
ToadPosY	 byte 0

FileName     byte "Scores.txt", 0
fileH        dword 0
BUFSIZE      = 5000
data         BYTE BUFSIZE DUP(0)
bytesRead    DWORD ?
lOfdata      byte 0

WelcomeText  byte "WELCOME TO THE ULTIMATE WORLD OF ZUMBAAAAAA........", 0
NameText     byte "Please Enter Your Name : ", 0
NameErase    byte "                         ", 0
NameRead     byte 20 DUP(0), 0
Inst1        byte "1. Start Game", 0
Inst2        byte "2. How To Play", 0
Inst3        byte "3. Select Level", 0
choice       byte 1
LevelNo      byte 1
Lives        byte 49,0
Level1Text	 byte "Level : 1    Difficulty : Easy      Lives : ",0
Level2Text	 byte "Level : 2    Difficulty : Mid       Lives : ",0
Level3Text	 byte "Level : 3    Difficulty : Hard      Lives : ",0
Level1SText	 byte "LEVEL NUMBER 1",0
Level1SText2 byte "Know Your Limits",0
Level2SText	 byte "LEVEL NUMBER 2",0
Level2SText2 byte "Talisman's Power",0
Level3SText	 byte "LEVEL NUMBER 3",0
Level3SText2 byte "Victorious Rebel",0
HowToPlay1   byte "1. Press 'w' & Just Shoot The Balls Man!", 0
HowToPlay2   byte "2. If You Get those Things, Matching Color Balls Will Disappear Like My Grades", 0
HowToPlay3   byte "3. But If those Balls Get you, Its Over Baby *_*", 0
HowToPlay4   byte "4. ......PS : You are a frog now :(", 0
HowToPlay5   byte ">>>>> Press Any Key to Play :)", 0
PauseFF      byte ">>>>> Press Any Key to Continue Playing :)", 0
GameOverText byte "GAME OVER", 0
IntroPrank   byte "I just ate your name.... Wait till I eat you",0
IntroErase   byte "                                            ",0
IntroBool    byte 1
Text1        byte "Next   :    ",0
Text2        byte "Ball   :    0",0
Text3        byte "Fire   :    *",0
Text4        byte "Player :    +",0
Text5        byte "Score  :  ",0
Text6        byte "Name     Score     Level",0

MaxBoundaryX byte 70
MaxBoundaryY byte 30
Boundary     byte ".", 0

PlayerPosX   byte 35
PlayerPosY	 byte 15
Player       byte "+", 0

FirePosX     byte 35
FirePosY	 byte 14
Fire         byte "*", 0
FireColor    byte 0
NextFireColor byte 0
ShootActive  byte 0
NoOfColors   byte 2

Level1MaxX   byte 55
Level1MinX   byte 16
Level1MaxY   byte 23
Level1MinY   byte 8

LevelX       byte 1,2,3,4,5,6,7,8,9,10, 30 DUP(0)
LevelY       byte 8,8,8,8,8,8,8,8,8,8 , 30 DUP(0)
Level1Balls  byte 40 DUP(0)
BallTexture  byte "0", 0
TotalBalls   byte 6
direction    byte 0
left         byte 0
top          byte 0
bottom       byte 0
right        byte 1

Tunnel1X      byte 33,34,35,36,37,38
Tunnel1Y      byte 5,5,5,5,5,5
Tunnel2X      byte 11,11,11
Tunnel2Y      byte 13,14,15
Tunnel3X      byte 31,32,33,34,35,36,37,38,39,40
Tunnel3Y      byte 20,20,20,20,20,20,20,20,20,20

Score        byte 0
Levelselect  byte 0
count        byte 0
GameLoopBool byte 1

.code

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;FILING;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CollectData PROC
	mov edx, offset Filename
	CALL openInputFile
	mov fileh, eax

	mov edx, offset data
	mov ecx, Bufsize
	call ReadFromFile
	mov bytesread, eax

	mov eax, fileh
	CALL CloseFile
	ret
CollectData ENDP

AppendName PROC

	mov edx,OFFSET filename
	call CreateOutputFile
	mov fileh, eax

	mov ecx, bytesread
	mov esi, ecx
	mov dh, cl

	mov data[esi], 13
	inc esi
	inc dh
	mov data[esi], 10
	inc esi
	inc dh

	mov ecx, lengthof NameRead
	mov ebx, 0
	l1:
		mov dl, NameRead[ebx]
		cmp dl, 0
		je lol
		mov data[esi], dl
		inc esi
		inc dh
		inc ebx
	loop l1
	lol:
	mov data[esi], 32
	inc esi
	inc dh
	mov data[esi], 32
	inc esi
	inc dh

	mov eax, 0
	mov al, score
	mov bl, 10
	div bl
	mov dl, al
	ADD dl, 48
	mov data[esi], dl
	inc esi
	inc dh
	mov dl, ah
	ADD dl, 48
	mov data[esi], dl
	inc esi
	inc dh

	mov data[esi], 32
	inc esi
	inc dh
	mov data[esi], 32
	inc esi
	inc dh
	mov dl, LevelNo
	ADD dl, 48
	mov data[esi], dl
	inc dh

	mov bl, dh
	mov lOfdata, bl
	mov eax, fileh
	mov edx, offset data
	mov ecx, 0
	mov cl, bl
	CALL WriteToFile

	mov eax, fileh
	CALL CloseFile

	ret
AppendName ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;TUNNELS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TunnelDisplay PROC
	mov ecx, lengthof Tunnel1X
	mov esi, 0

	l1:
		mov dl, Tunnel1X[esi]
		mov dh, Tunnel1Y[esi]
		CALL GOTOXY
		mov eax, brown+(brown*16)
		CALL SETTEXTCOLOR
		mov edx, offset BallTexture
		Call writestring
		inc esi
	loop l1

	mov ecx, lengthof Tunnel2X
	mov esi, 0
	l2:
		mov dl, Tunnel2X[esi]
		mov dh, Tunnel2Y[esi]
		CALL GOTOXY
		mov eax, brown+(brown*16)
		CALL SETTEXTCOLOR
		mov edx, offset BallTexture
		Call writestring
		inc esi
	loop l2

	mov ecx, lengthof Tunnel3X
	mov esi, 0
	l3:
		mov dl, Tunnel3X[esi]
		mov dh, Tunnel3Y[esi]
		CALL GOTOXY
		mov eax, brown+(brown*16)
		CALL SETTEXTCOLOR
		mov edx, offset BallTexture
		Call writestring
		inc esi
	loop l3
	mov eax, white+(black*16)
		CALL SETTEXTCOLOR
	ret
TunnelDisplay ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;LEVEL&LIVES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LevelAndLivesDisplay PROC
	mov eax, white + (Green*16)
	Call SetTextColor
	mov dl, 73
	mov dh, 2
	CALL GOTOXY
	cmp LevelNo, 1
	jne nex
	mov edx, offset Level1Text
	jmp wri
	nex:
	cmp LevelNo, 2
	jne nexx
	mov edx, offset Level2Text
	jmp wri
	nexx:
	mov edx, offset Level3Text
	jmp wri
	wri:
	call WRITESTRING
	mov edx, offset Lives
	call WriteString
	ret
LevelAndLivesDisplay ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;PAUSE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PauseF PROC
	CALL CLRSCR
	mov dl, 35
	mov dh, 14
	CALL GOTOXY
	mov edx, offset PAUSEff
	call WRITESTRING
	CALL READCHAR
	CALL CLRSCR
	ret
PauseF ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MENU;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Menu PROC
	mov dl, 45
	mov dh, 13
	CALL GOTOXY
	mov edx, offset Inst1
	CALL WriteString
	mov dl, 45
	mov dh, 14
	CALL GOTOXY
	mov edx, offset Inst2
	CALL WriteString

	mov dl, 45
	mov dh, 15
	CALL GOTOXY
	mov edx, offset Inst3
	CALL WriteString

	CALL ReadChar
	mov choice, al

	cmp choice, '1'
	je Startgame
	cmp al, '3'
	je LevelSelection
	CALL Clrscr

	mov dl, 35
	mov dh, 12
	CALL GOTOXY

	mov edx, OFFSET Howtoplay1
	CALL WRITESTRING
	mov dl, 35
	mov dh, 13
	CALL GOTOXY
	mov edx, OFFSET Howtoplay2
	CALL WRITESTRING
	mov dl, 35
	mov dh, 14
	CALL GOTOXY
	mov edx, OFFSET Howtoplay3
	CALL WRITESTRING
	mov dl, 35
	mov dh, 15
	CALL GOTOXY
	mov edx, OFFSET Howtoplay4
	CALL WRITESTRING
	mov dl, 35
	mov dh, 16
	CALL GOTOXY
	mov edx, OFFSET Howtoplay5
	CALL WRITESTRING
	CALL ReadChar
	jmp startgame

	LevelSelection:
	call clrscr

	mov dl, 25
	mov dh, 14
	CALL GOTOXY
	mov edx, OFFSET Level1SText
	CALL WRITESTRING
	mov dl, 25
	mov dh, 15
	CALL GOTOXY
	mov edx, OFFSET Level1SText2
	CALL WRITESTRING

	mov dl, 50
	mov dh, 14
	CALL GOTOXY
	mov edx, OFFSET Level2SText
	CALL WRITESTRING

	mov dl, 50
	mov dh, 15
	CALL GOTOXY
	mov edx, OFFSET Level2SText2
	CALL WRITESTRING

	mov dl, 75
	mov dh, 14
	CALL GOTOXY
	mov edx, OFFSET Level3SText
	CALL WRITESTRING

	mov dl, 75
	mov dh, 15
	CALL GOTOXY
	mov edx, OFFSET Level3SText2
	CALL WRITESTRING

	CALL ReadChar
	mov levelselect, al
	cmp al, '1'
	jne skipppp

	Startgame:
	CALL CLRSCR
	mov dl, 18
	mov dh, 8
	CALL GOTOXY

	mov edx, OFFSET NameText
	CALL WRITESTRING

	mov ecx, lengthof NameRead
	mov edx, OFFSET NameRead
	CALL READSTRING

	mov dl, 18
	mov dh, 8
	CALL GOTOXY

	mov edx, OFFSET NameErase
	CALL WRITESTRING

	skipppp:
	ret
Menu ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;STARTING;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

starting PROC
	
	mov eax, 0
	mov al, totalBalls
	mov ecx, eax
	mov esi, OFFSET Level1Balls
	call RANDOMIZE
	RandomBallsGenerate:
		mov eax, 0
		mov al, NoOfColors
		call RANDOMRANGE
		mov [esi], al
		inc esi
	loop RandomBallsGenerate

	mov eax, 0
	mov al, NoOfColors
	call RANDOMRANGE
	mov FireColor, al
	call RANDOMRANGE
	mov NextFireColor, al

	cmp levelno, 1
	jne skipp

	mov dl, 30
	mov dh, 13
	call GOTOXY

	mov edx, offset welcometext
	call WRITESTRING

	mov eax, 1000
	call DELAY
	call CLRSCR
	skipp:
	ret
starting ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;BOUNDARY;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BoundaryPrinting PROC
	mov eax, white + (magenta * 16)
	call SETTEXTCOLOR

	mov cl, MaxBoundaryX
	B1:
		mov dl, cl
		mov dh, 1
		call GOTOXY
		mov edx, offset boundary
		call WRITESTRING
	loop B1

	mov cl, MaxBoundaryX
	B2:
		mov dl, cl
		mov dh, MaxBoundaryY
		call GOTOXY
		mov edx, offset boundary
		call WRITESTRING
	loop B2

	mov cl, MaxBoundaryY
	B3:
		mov dl, 1
		mov dh, cl
		call GOTOXY
		mov edx, offset boundary
		call WRITESTRING
	loop B3
	
	mov cl, MaxBoundaryY
	B4:
		mov dl, MaxBoundaryX
		mov dh, cl
		call GOTOXY
		mov edx, offset boundary
		call WRITESTRING
	loop B4

	mov eax, white + (black * 16)
	call SETTEXTCOLOR
	ret
BoundaryPrinting ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;BALLS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BallPrinting PROC
	mov ecx, 0
	mov ebx, 0
	mov eax, 0
	mov edx, 0
	mov esi, 0
	mov cl, TotalBalls
	dec cl
	mov esi, ecx
	inc ecx

	Print:
		mov al, Level1Balls[esi]
		cmp al, 0
		je RedBall
		cmp al, 1
		je BlueBall
		cmp al, 2
		je BrownBall
		cmp al, 3
		je GreenBall
		cmp al, 4
		je WBall

		RedBall:
			mov eax, white + (red * 16)
			call SETTEXTCOLOR
			jmp SKIPP
		BlueBall:
			mov eax, white + (Blue * 16)
			call SETTEXTCOLOR
			jmp SKIPP
		BrownBall:
			mov eax, white + (Brown * 16)
			call SETTEXTCOLOR
			jmp SKIPP
		GreenBall:
			mov eax, white + (Green * 16)
			call SETTEXTCOLOR
			jmp SKIPP
		WBall:
			mov eax, white + (white * 16)
			call SETTEXTCOLOR
			jmp SKIPP
		SKIPP:
			mov ebx, eax
			mov eax, white + (black * 16)
			call SETTEXTCOLOR

			mov dl,  LevelX [esi]
			mov dh,  LevelY [esi]
			CALL GOTOXY
			mov al, ' '
			CALL WriteChar

			mov eax, ebx
			call SETTEXTCOLOR

			mov bl, Level1MinX
			mov bh, Level1MaxX
			mov al, Level1MinY
			mov ah, Level1MaxY
			SubPosX:
				cmp LevelX[esi], bl
				jle AddPosY
				cmp LevelY[esi], ah
				jne AddPosY
				SUB LevelX[esi], 1
				cmp bottom, 1
				je  MaxYInc
				jmp skip
				MaxYInc:
					cmp esi, 0
					jne skip
					ADD Level1MinY, 1
					mov left  , 1
					mov top   , 0
					mov bottom, 0
					mov right , 0
			jmp SKIP
			AddPosY:
				cmp LevelX[esi], bh
				jne AddPosX
				cmp LevelY[esi], ah
				jge AddPosX
				ADD LevelY[esi], 1
				cmp right  , 1
				je  MaxXInc
				jmp skip
				MaxXInc:
					cmp esi, 0
					jne skip
					ADD Level1MinX, 1
					mov left  , 0
					mov top   , 0
					mov bottom, 1
					mov right , 0
				jmp SKIP
			AddPosX:
				cmp LevelX[esi], bh
				jge SubPosY
				cmp LevelY[esi], al
				jne SubPosY
				ADD LevelX[esi], 1
				cmp top  , 1
				je  MinYInc
				jmp skip
				MinYInc:
					cmp esi, 0
					jne skip
					SUB Level1MaxY, 1
					mov left  , 0
					mov top   , 0
					mov bottom, 0
					mov right , 1
				jmp SKIP	
			SubPosY:
				cmp LevelX[esi], bl
				jne SubPosX
				cmp LevelY[esi], al
				jle SubPosX
				SUB LevelY[esi], 1
				cmp left  , 1
				je  MinXInc
				jmp skip
				MinXInc:
					cmp esi, 0
					jne skip
					SUB Level1MaxX, 1
					mov left  , 0
					mov top   , 1
					mov bottom, 0
					mov right , 0
				jmp SKIP
					
			SKIP:
				mov dl, LevelX[esi]
				mov dh, LevelY[esi]
				CALL GOTOXY
					
				mov edx, OFFSET BallTexture
				CALL WriteString
				
				cmp LevelY[esi], 15
				jne sk
				cmp LevelX[esi], 55
				jl  sk
				cmp IntroBool, 0
				je sk
				BoolFalse:
					mov eax, white + (black * 16)
					call SETTEXTCOLOR
					mov dl, 72
					mov dh, 13
					CALL GOTOXY
					mov edx, OFFSET IntroPrank
					CALL WriteString
					mov eax, 2000
					CALL Delay
					mov dl, 72
					mov dh, 13
					CALL GOTOXY
					mov edx,OFFSET  IntroErase
					CALL WriteString
					PUSH esi
					PUSH ecx
					mov ToadPosX, 82
					mov ToadPosY, 4
					CALL Toad
					POP ECX
					POP ESI
					mov IntroBool, 0
				sk:
				dec esi
				dec	ecx
				cmp ecx, 0
			jne Print
		cmp introbool, 1
		je cont
		CALL LevelAndLivesDisplay
		cmp LevelNo, 1
		jne contTwoPointO
		mov eax, 50
		CALL Delay
		contTwoPointO:
		cmp LevelNo, 2
		jne cont
		mov eax, 50
		CALL Delay
		cont:
		mov eax, white + (black * 16)
		call SETTEXTCOLOR
		ret
BallPrinting ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;FIRE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

FirePrinting PROC
	cmp shootActive, 1
	je Shot
	jmp co
	Shot:
		CALL Shoot
	co:
	mov bl, 0
	cmp FireColor, 0
	je RedBall
	cmp FireColor, 1
	je BlueBall
	cmp FireColor, 2
	je BrownBall
	cmp FireColor, 3
	je GreenBall

	RedBall:
		mov eax, white + (red * 16)
		call SETTEXTCOLOR
		cmp bl, 1
		je skippp
		jmp SKIP
	BlueBall:
		mov eax, white + (Blue * 16)
		call SETTEXTCOLOR
		cmp bl, 1
		je skippp
		jmp SKIP
	BrownBall:
		mov eax, white + (Brown * 16)
		call SETTEXTCOLOR
		cmp bl, 1
		je skippp
		jmp SKIP
	GreenBall:
		mov eax, white + (Green * 16)
		call SETTEXTCOLOR
		cmp bl, 1
		je skippp
		jmp SKIP

	SKIP:

	mov dl, FirePosX
	mov dh, FirePosY
	call GOTOXY
	mov edx, offset Fire
	call WRITESTRING

	mov eax, white + (black * 16)
	call SETTEXTCOLOR
	mov bl, 1
	cmp NextFireColor, 0
	je RedBall
	cmp NextFireColor, 1
	je BlueBall
	cmp NextFireColor, 2
	je BrownBall
	cmp NextFireColor, 3
	je GreenBall

	skippp:
	mov ebx, eax
	mov eax, white + (black * 16)
	call SETTEXTCOLOR

	cmp levelNo, 1
	je nooo

	mov dl, 75
	mov dh, 15
	call GOTOXY
	mov edx, offset Text5
	call WRITESTRING

	mov dl, 87
	mov dh, 15
	call GOTOXY
	mov eax, 0
	mov al, score
	call writeint

	nooo:

	mov dl, 75
	mov dh, 17
	call GOTOXY
	mov edx, offset Text1
	call WRITESTRING

	mov dl, 75
	mov dh, 19
	call GOTOXY
	mov edx, offset Text2
	call WRITESTRING

	mov dl, 75
	mov dh, 21
	call GOTOXY
	mov edx, offset Text3
	call WRITESTRING

	mov dl, 75
	mov dh, 23
	call GOTOXY
	mov edx, offset Text4
	call WRITESTRING

	mov eax, ebx
	call SETTEXTCOLOR
	mov dl, 87
	mov dh, 17
	call GOTOXY
	mov edx, offset Fire
	call WRITESTRING
	ret
FirePrinting ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;PLAYER;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PlayerPrinting PROC
	mov eax, white + (green * 16)
	call SETTEXTCOLOR

	mov dl, PlayerPosX
	mov dh, PlayerPosY
	call GOTOXY
	mov edx, offset player
	call WRITESTRING

	mov eax, white + (black * 16)
	call SETTEXTCOLOR
	ret
PlayerPrinting ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;KEY CHECKING;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KeyCheck PROC
	call READKEY

	cmp al, 'e'
	jne SKIP
	mov GameLoopBool, 0

	SKIP:
		ret
KeyCheck ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MOVEMENT LEFT;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MoveLeft PROC
	mov dl, FirePosX
	mov dh, FirePosY
	CALL GOTOXY
	mov al, ' '
	CALL WriteChar
	SubPosX:
		cmp FirePosX, 34
		jle AddPosY
		cmp FirePosY, 14
		jne AddPosY
		SUB FirePosX, 1
		jmp SKIP
	AddPosY:
		cmp FirePosX, 34
		jne AddPosX
		cmp FirePosY, 16
		jge AddPosX
		ADD FirePosY, 1
		jmp SKIP
	AddPosX:
		cmp FirePosX, 36
		jge SubPosY
		cmp FirePosY, 16
		jne SubPosY
		ADD FirePosX, 1
		jmp SKIP	
	SubPosY:
		cmp FirePosX, 36
		jne SubPosX
		cmp FirePosY, 14
		jle SubPosX
		SUB FirePosY, 1
		jmp SKIP

	SKIP:
	ret
MoveLeft ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MOVEMENT RIGHT;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MoveRight PROC
	mov dl, FirePosX
	mov dh, FirePosY
	CALL GOTOXY
	mov al, ' '
	CALL WriteChar
	SubPosX:
		cmp FirePosX, 34
		jle AddPosY
		cmp FirePosY, 16
		jne AddPosY
		SUB FirePosX, 1
		jmp SKIP
	AddPosY:
		cmp FirePosX, 36
		jne AddPosX
		cmp FirePosY, 16
		jge AddPosX
		ADD FirePosY, 1
		jmp SKIP
	AddPosX:
		cmp FirePosX, 36
		jge SubPosY
		cmp FirePosY, 14
		jne SubPosY
		ADD FirePosX, 1
		jmp SKIP	
	SubPosY:
		cmp FirePosX, 34
		jne SubPosX
		cmp FirePosY, 14
		jle SubPosX
		SUB FirePosY, 1
		jmp SKIP

	SKIP:

	ret
MoveRight ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;COLLISION BALLS & PLAYER;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CollisionBallPlayer PROC
	mov cl, TotalBalls
	dec cl
	mov esi, 0
	l1:
		ADD esi, 1
	loop l1

	mov al, PlayerPosX
	mov bl, PlayerPosY
	cmp LevelX[esi], al
	jne SKIP
	cmp LevelY[esi], bl
	jne SKIP
	mov GameLoopBool, 0
	mov Lives, 48
	SKIP:
	ret
CollisionBallPlayer ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;SHOOT;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Shoot PROC
	mov dl, FirePosX
	mov dh, FirePosY
	CALL GOTOXY
	mov al, ' '
	CALL WRITECHAR
	cmp levelNo, 3
	jne loo

	mov ecx, lengthof Tunnel1X
	mov esi, 0
	mov al, FirePosX
	mov bl, FirePosY
	l1:
		cmp Tunnel1X[esi],al
		jne sk
		SUB bl, 1
		cmp Tunnel1Y[esi],bl
		jne sk1
		jmp Next4
		sk1:
		ADD bl,1
		sk:
		inc esi
	loop l1

	mov al, FirePosX
	mov bl, FirePosY
	mov ecx, lengthof Tunnel2X
	mov esi, 0
	l2:
		SUB al, 1
		cmp Tunnel2X[esi],al
		jne ske
		cmp Tunnel2Y[esi],bl
		jne ske
		jmp Next4
		ske:
		ADD al, 1
		inc esi
	loop l2

	mov al, FirePosX
	mov bl, FirePosY
	mov ecx, lengthof Tunnel3X
	mov esi, 0
	l3:
		cmp Tunnel3X[esi],al
		jne skep
		ADD bl, 1
		cmp Tunnel3Y[esi],bl
		jne skep1
		jmp Next4
		skep1:
		SUB bl, 1
		skep:
		inc esi
	loop l3

	loo:
	cmp FirePosX, 35
	jne NEXT1
	cmp FirePosY, 14
	jg NEXT1
	cmp FirePosY, 1
	jle NEXT4
	SUB FirePosY, 1
	mov direction, 1
	jmp SKIP

	NEXT1:
	cmp FirePosX, 34
	jg NEXT2
	cmp FirePosY, 15
	jne NEXT2
	cmp FirePosX, 1
	jle NEXT4
	SUB FirePosX, 1
	mov direction, 4
	jmp SKIP

	NEXT2:
	cmp FirePosX, 35
	jne NEXT3
	cmp FirePosY, 16
	jl NEXT3
	cmp FirePosY, 29
	jge NEXT4
	ADD FirePosY, 1
	mov direction, 3
	jmp SKIP

	NEXT3:
	cmp FirePosX, 36
	jl NEXT4
	cmp FirePosY, 15
	jne NEXT4
	cmp FirePosX, 69
	jge NEXT4
	ADD FirePosX, 1
	mov direction, 2
	jmp SKIP

	NEXT4:
		mov ShootActive, 0
		mov FirePosX, 35
		mov FirePosY, 14
		mov al, NextFireColor
		mov FireColor, al
		mov eax, 0
		mov al, NoOfColors
		call RANDOMRANGE
		mov NextFireColor, al
		jmp SKIP2
		
	SKIP:
	CALL CollisionBall
	SKIP2:
	ret
Shoot ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;COLLISION;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CollisionBall PROC
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	mov eax, 0
	
	mov cl, TotalBalls
	mov ebx, ecx
	mov esi, ecx
	dec esi

	mov al, FirePosX
	mov ah, FirePosY
	L1:
		cmp LevelX[esi], al
		jne Skip
		cmp LevelY[esi], ah
		jne Skip
		
		mov esi, ebx
		dec esi
		L2:
			mov dl, LevelX[esi]
			cmp direction, 1
			jne s
			Add dl, 1
			jmp s1
			s:
			cmp direction, 3
			jne s1
			SUB dl, 1
			s1:
			mov LevelX[esi+1], dl
			mov dl, Level1Balls[esi]
			mov Level1Balls[esi+1], dl
			mov dl, LevelY[esi]
			cmp direction, 2
			jne se
			ADD dl, 1
			jmp sep
			se:
			cmp direction, 4
			jne sep
			SUB dl, 1
			sep:
			mov LevelY[esi+1], dl
			dec esi
			dec ebx
			cmp bl, cl
		jne L2
			mov LevelX[esi], al
			mov LevelY[esi], ah
			mov al, FireColor
			mov Level1Balls[esi+1], al
			ADD TotalBalls,1
			mov ShootActive, 0
			mov FirePosX, 35
			mov FirePosY, 14
			mov eax, 4
			call RANDOMRANGE
			mov FireColor, al
			cmp LevelNo, 1
			je ENDD
			CALL Destruct
			jmp ENDD

		Skip:
		dec esi
		dec ecx
		cmp ecx, 0
	jne L1

	ENDD:
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	mov eax, 0
	ret
CollisionBall ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DESTRUCTION;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Destruct PROC
	mov ecx, 0
	mov eax, 0
	mov ebx, 0
	mov edx, 0
	
	mov cl, totalBalls
	mov esi, 0
	SUB cl, 1

	L1:
		mov al, Level1Balls[esi+1]
		cmp Level1Balls[esi], al
		jne Diff

		add count,1
		jmp Skip

		Diff:
		cmp count, 2
		jl Noshift
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	    Add Score, 5
		mov al, count
		mov dl, totalBalls
		Sub dl, count
		inc ebx
		mov edi, ebx
		L2:
			mov ah, LevelX[ebx+1]
			cmp direction, 1
			jne s
			SUB ah, 1
			jmp s1
			s:
			cmp direction, 3
			jne s1
			ADD ah, 1
			s1:
			mov LevelX[ebx], ah
			mov ah, LevelY[ebx+1]
			cmp direction, 2
			jne se
			Add ah, 1
			jmp sep
			se:
			cmp direction, 4
			jne sep
			SUB ah, 1
			sep:
		 	mov LevelY[ebx], ah
			mov ah, Level1Balls[ebx+1]
			mov Level1Balls[ebx], ah

				inc ebx
				sub dl, 1
				cmp dl, 0
			jne L2

			mov dl, totalBalls
			Sub dl, count

			SUB TotalBalls, 1
			dec esi
			SUB al, 1
			mov ebx, edi
			cmp al, 0
		jne L2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		NoShift:
		mov count, 0
		mov ebx, esi
		skip:
		inc esi
		dec ecx
		cmp ecx, 0
	jne L1

	ret
Destruct ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;******MAIN FUNCTION(HOST)******;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Main PROC

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;LEVEL 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov eax, 0
	mov edx, 0
	mov ecx, 0
	mov ebx, 0

	CALL CollectData
	mov eax, 0
	mov edx, 0
	mov ecx, 0
	mov ebx, 0
	CALL starting
	mov ToadPosX, 39
	mov ToadPosY, 5
	CALL Toad
	CALL Menu
	cmp levelSelect, '2'
	je Level2
	cmp levelSelect, '3'
	je Level3
	
GAMELOOP:
	CALL BoundaryPrinting
	CALL FirePrinting
	CALL PlayerPrinting
	CALL BallPrinting
	CALL CollisionBallPlayer
	cmp LevelNo, 3
	jne ski
	CALL TunnelDisplay
	ski:
	CALL KeyCheck
	
	cmp al, 'a'
	je  LeftMovement
	cmp al, 'd'
	je  RightMovement
	cmp al, 'w'
	je ShootFire
	cmp al, 'x'
	je PauseFunction
	jmp SKIP

	PauseFunction:
		CALL PAUSEF
		jmp SKIP
	LeftMovement:
		cmp ShootActive, 1
		je SKIP
		CALL MoveLeft
		jmp SKIP

	RightMovement:
		cmp ShootActive, 1
		je SKIP
		CALL MoveRight
		jmp SKIP

	ShootFire:
		mov ShootActive, 1
		jmp SKIP
	
	SKIP:
	
	cmp GameLoopBool, 0

	jne GAMELOOP
	jmp Endd
	cmp levelNo, 1
	je Level2
	cmp LevelNo, 2
	je Level3
	jmp ENDD
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;LEVEL 2;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LEVEL2:
	
	mov noofcolors, 3
	mov introbool, 0
	mov LevelNo, 2
	mov TotalBalls, 10
	mov direction,0
	mov left,0
	mov top,0
	mov bottom,0
	mov right,1

	mov count, 0
	mov GameLoopBool,1

	mov Level1MaxX, 67
	mov Level1MinX, 4
	mov Level1MaxY, 27
	mov Level1MinY, 4
	mov Lives, 49
	CALL StartinG

	mov cl, totalballs
	mov esi, 0
	mov bl, Level1MinY
	mov bh, 2
	l1:
		mov LevelX[esi], bh
		mov LevelY[esi], bl
		inc esi
		inc bh
	loop l1
	call clrscr
	mov dl, 46
	mov dh, 13
	CALL GOTOXY
	
	mov eax, white + (red * 16)
	call SETTEXTCOLOR

	mov edx, offset Level2SText
	call writestring

	mov dl, 45
	mov dh, 14
	CALL GOTOXY

	mov edx, offset Level2SText2
	call writestring

	mov eax, 3000
	CALL DELAY
	mov eax, white + (black * 16)
	call SETTEXTCOLOR

	call clrscr
	mov ToadPosX, 82
	mov ToadPosY, 4
	CALL Toad
	jmp gameloop


	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;LEVEL 3;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	Level3:
	mov NoOfColors, 4
	mov introbool, 0
	mov LevelNo, 3
	mov TotalBalls, 15
	mov direction,0
	mov left,0
	mov top,0
	mov bottom,0
	mov right,1

	mov count, 0
	mov GameLoopBool,1

	mov Level1MaxX, 69
	mov Level1MinX, 4
	mov Level1MaxY, 25
	mov Level1MinY, 4
	mov Lives, 49
	CALL StartinG

	mov cl, totalballs
	mov esi, 0
	mov bl, Level1MinY
	mov bh, 2
	l2:
		mov LevelX[esi], bh
		mov LevelY[esi], bl
		inc esi
		inc bh
	loop l2
	call clrscr
	mov dl, 46
	mov dh, 13
	CALL GOTOXY
	
	mov eax, white + (Blue * 16)
	call SETTEXTCOLOR

	mov edx, offset Level3SText
	call writestring

	mov dl, 45
	mov dh, 14
	CALL GOTOXY

	mov edx, offset Level3SText2
	call writestring

	mov eax, 3000
	CALL DELAY
	mov eax, white + (black * 16)
	call SETTEXTCOLOR

	call clrscr
	mov ToadPosX, 82
	mov ToadPosY, 4
	CALL Toad
	
	jmp gameloop

	ENDD:
	CALL AppendName
	mov eax, 0
	mov edx, 0
	mov ecx, 0
	mov ebx, 0
	CALL CLRSCR
	mov dl, 0
	mov dh, 10
	call GOTOXY
	mov edx, OFFSET Text6
	CALL Writestring

	mov ecx, 0
	mov cl, lOFData
	mov dl, 0
	mov dh, 11
	call GOTOXY
	mov edx, offset data
	call WritestrinG

	mov dl, 45
	mov dh, 10
	call GOTOXY
	mov edx, OFFSET GameOverText
	CALL Writestring
	mov eax, 10000
	CALL Delay
exit
Main ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;PRINTTOAD;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Toad PROC
	mov edx, 0
	mov dl, ToadPosX
	mov dh, ToadPosY
	CALL GOTOXY
	CALL PrintToad1
	CALL PrintToad2
	CALL PrintToad3
	CALL PrintToad4
	CALL PrintToad5
	CALL PrintToad6
	CALL PrintToad7
	ret
Toad ENDP

PrintToad1 PROC
	mov edx, 0
	mov dl, ToadPosX
	mov dh, ToadPosY
	CALL GOTOXY
	mov ecx, lengthof Toad1
	SUB ecx, 1
	mov esi, offset Toad1

	L1:
		mov al, [esi]
		cmp al, 2
		je RedBa
		cmp al, 1
		je BlueBa
		cmp al, 0
		je GreenBa
		RedBa:
		CALL RedBal
		jmp endd
		BlueBa:
		CALL BlueBal
		jmp endd
		GreenBa:
		CALL GreenBal
		jmp endd

		endd:
		
		inc esi
	loop L1

	ret
PrintToad1 ENDP

PrintToad2 PROC
	mov dl, ToadPosX
	ADD dh, 1
	CALL GOTOXY
	mov ecx, lengthof Toad2
	SUB ecx, 1
	mov esi, offset Toad2

	L2:
		mov al, [esi]
		cmp al, 2
		je RedBa
		cmp al, 1
		je BlueBa
		cmp al, 0
		je GreenBa
		RedBa:
		CALL RedBal
		jmp endd
		BlueBa:
		CALL BlueBal
		jmp endd
		GreenBa:
		CALL GreenBal
		jmp endd

		endd:
		
		inc esi
	loop L2
	ret
PrintToad2 ENDP
PrintToad3 PROC
	mov dl, ToadPosX
	ADD dh, 1
	CALL GOTOXY
	mov ecx, lengthof Toad3
	SUB ecx, 1
	mov esi, offset Toad3

	L3:
		mov al, [esi]
		cmp al, 2
		je RedBa
		cmp al, 1
		je BlueBa
		cmp al, 0
		je GreenBa
		RedBa:
		CALL RedBal
		jmp endd
		BlueBa:
		CALL BlueBal
		jmp endd
		GreenBa:
		CALL GreenBal
		jmp endd

		endd:
		inc esi
	loop L3
	ret
PrintToad3 ENDP

PrintToad4 PROC
	mov dl, ToadPosX
	ADD dh, 1
	CALL GOTOXY
	mov ecx, lengthof Toad4
	SUB ecx, 1
	mov esi, offset Toad4

	L4:
		mov al, [esi]
		cmp al, 2
		je RedBa
		cmp al, 1
		je BlueBa
		cmp al, 0
		je GreenBa
		RedBa:
		CALL RedBal
		jmp endd
		BlueBa:
		CALL BlueBal
		jmp endd
		GreenBa:
		CALL GreenBal
		jmp endd

		endd:
		inc esi
	loop L4
	ret
PrintToad4 ENDP

PrintToad5 PROC
	mov dl, ToadPosX
	ADD dh, 1
	CALL GOTOXY
	mov ecx, lengthof Toad5
	SUB ecx, 1
	mov esi, offset Toad5

	L5:
		mov al, [esi]
		cmp al, 2
		je RedBa
		cmp al, 1
		je BlueBa
		cmp al, 0
		je GreenBa
		RedBa:
		CALL RedBal
		jmp endd
		BlueBa:
		CALL BlueBal
		jmp endd
		GreenBa:
		CALL GreenBal
		jmp endd

		endd:
		inc esi
	loop L5
	ret
PrintToad5 ENDP

PrintToad6 PROC
	mov dl, ToadPosX
	ADD dh, 1
	CALL GOTOXY
	mov ecx, lengthof Toad6
	SUB ecx, 1
	mov esi, offset Toad6

	L6:
		mov al, [esi]
		cmp al, 2
		je RedBa
		cmp al, 1
		je BlueBa
		cmp al, 0
		je GreenBa
		RedBa:
		CALL RedBal
		jmp endd
		BlueBa:
		CALL BlueBal
		jmp endd
		GreenBa:
		CALL GreenBal
		jmp endd

		endd:
		inc esi
	loop L6
	RET
PrintToad6 ENDP
PrintToad7 PROC
	mov dl, ToadPosX
	ADD dh, 1
	CALL GOTOXY
	mov ecx, lengthof Toad7
	SUB ecx, 1
	mov esi, offset Toad7

	L7:
		mov al, [esi]
		cmp al, 2
		je RedBa
		cmp al, 1
		je BlueBa
		cmp al, 0
		je GreenBa
		RedBa:
		CALL RedBal
		jmp endd
		BlueBa:
		CALL BlueBal
		jmp endd
		GreenBa:
		CALL GreenBal
		jmp endd

		endd:
		inc esi
	loop L7
	mov eax, White + (Black * 16)
			call SETTEXTCOLOR
	ret
PrintToad7 ENDP

RedBal PROC
	mov eax, red + (red * 16)
	call SETTEXTCOLOR
	call WriteChar
	ret
RedBal ENDP
BlueBal PROC
	mov eax, Blue + (Blue * 16)
	call SETTEXTCOLOR
	call WriteChar
	ret
BLUEBAL ENDP
GreenBal PROC
	mov eax, Green + (Green * 16)
	call SETTEXTCOLOR
	call WriteChar
	ret
GREENBAL ENDP
END Main