[BITS 16]
[ORG 0x0100]
[SEGMENT .text]

init_carte_video: ;init carte video
	mov ax,13h
	int 10h
	mov ax,0a000h
	mov es,ax	
; A COMPLETER

init_vitesse: ;init vitesse jeu
	mov ax,[vitesse_initiale] ;compteur de vitesse initiale
	mov [vitesse],ax ;compteur de vitesse du jeu

affichage_textscore: 
;affichage texte "score"
	mov word[x],20
	mov word[y],10
	mov word[h],5
	mov word[l],29
	mov word[add_sprite],textscore
	call affiche_sprite

;initialise les tableaux d'aliens
call init_tab

boucle: ;boucle principale
	;affichage du vaisseau avec anti trace

	
	
	affiche_aliens: ;appelle la routine d'affichage des aliens
		call affichage_aliens
		
	affiche_suivi_vaisseaux_gauche:
		mov cx,[xv]
		sub cx,3
		mov word [x],cx
		mov word[y],192
		mov word[h],7
		mov word[l],5
		mov word[add_sprite],suivi_vaisseau
		call affiche_sprite
affiche_suivi_vaisseaux_droite:
		mov cx,[xv]
		add cx,15
		mov word [x],cx
		mov word[y],192
		mov word[h],7
		mov word[l],5
		mov word[add_sprite],suivi_vaisseau
		call affiche_sprite
		
		
affiche_vaisseaux:
		mov cx,[xv]
		mov word [x],cx
		mov word[y],192
		mov word[h],7
		mov word[l],15
		mov word[add_sprite],vaisseau 
		call affiche_sprite
	
	
	;décremente et teste le compteur de vitesse jeu pour l'affichage des aliens
	dec word [vitesse]
	cmp word [vitesse],0
	
	; A COMPLETER
	
	
	
	test_tir:
		;si tir n'a pas encore touché d'alien
		cmp word [tir_OK],1
		je test_tir_OK
		jmp appuie_touche
		test_tir_OK:
			call affiche_tir
			call test_explosion
		jmp appuie_touche
	
		


		deplace_alien: ;gestion du déplacement des aliens		
		; A COMPLETER
	change_sens: ;changement de sens du déplacement
	droite_alien:
		cmp word[xa1],90
		jge gauche_alien
		add word[xa1],16
	gauche_alien:
		cmp word[xa1],30
		jle droite_alien
		add word[ya1],12
		sub word[xa1],16
		; A COMPLETER
	
	deplace: ;déplacement des aliens
	;A COMPLETER
	
	
		
		jmp appuie_touche
	perdu_gagne: ;teste si perdu ou gagné
		
		; A COMPLETER
		
		je nouveau_tour
		
	reinit_vitesse: ;remise à vitesse initiale de vitesse jeu
		mov ax,[vitesse_initiale]
		mov [vitesse],ax
				
	appuie_touche: ;teste de l'appuie de touches
		xor ax,ax
		int 16h
		cmp ax,011Bh
		je fin
		cmp ax,4B00h
		je gauche
		cmp ax,4D00h
		Je droite
		cmp ax,3920h
		je tir
		jmp boucle

tir: ;touche tir
	cmp word [tir_OK],0
	je tir_valide
	jmp boucle
	tir_valide:
	
		; A COMPLETER
		
	jmp boucle

gauche: ;touche gauche
	cmp word [xv],1
	je boucle
	mov ax,[xv]
	sub ax,3
	mov [xv],ax
	jmp boucle
	

droite: ;touche droite
	cmp word [xv],304
	je boucle
	mov ax,[xv]
	add ax,3
	mov [xv],ax
	jmp boucle

nouveau_tour: ;nouveau tour de jeu (tous les aliens ont été tués)
	call reinit_tour
	call init_tab
	jmp boucle		
	
fin_perdu: ;perdu
	
	; A COMPLETER
	
fin: ;quitte le jeu
	mov ax,3h
	int 10h
	mov ax,4c00h
	int 21h
	
reinit_tour: ;reinit pour le tour de jeu suivant (tous les aliens ont été tués)	
	mov word [xa1],50
	mov word [ya1],40
	mov word [nb_aliens],55
	mov word [xinc],1
	
	; A COMPLETER
	
	ret		
	
affiche_tir: ;affichage du tir
	; A COMPLETER
ret

test_explosion: ;routine de test explosion
	
	; A COMPLETER

	reinit_tir:
			mov word [tir_OK],0
			mov word [yt],185
ret

affichage_aliens: ;routine d'affichage des aliens		
		mov ax,[xa1]
		mov word[x],ax
		mov ax,[ya1]
		mov word[y],ax
		
		mov cx,[tab_alien_h];cx=6
		mov bx,tab_alien; met l'addresse de tab_alien dans bx
		mov word [add1],bx;met bx dans la valeur de l'adresse du tableaux
		
	loop_alien_ligne:	
		push cx;met dans la pile cx=11 premier de la pile
		mov ax,[xa1]
		mov word[x],ax
		
		add word[y],12
		mov cx,[tab_alien_l];cx=11
		
	loop_alien_colonne:		
		push cx;met dans la pile cx=6 second de la pile
		add word[x],16
		mov word [l],16
		mov word [h],12
		mov bl,[bx]
		
		cmp  bl,0
		je fin1
		cmp  bl,1
		je alien1c
		cmp  bl,3
		je alien3c
		cmp bl,5
		je alien5
		
	alien1c:
		mov word [add_sprite],alien1
		call affiche_sprite
		jmp fin1
		
	alien3c:
		mov word [add_sprite],alien3
		call affiche_sprite
		jmp fin1
		
	alien5:
		mov word [add_sprite],alien2
		call affiche_sprite
		jmp fin1
		
	fin1:
		inc word[add1]
		mov  bx,[add1]
		pop cx
		loop loop_alien_colonne 
		pop cx
		loop loop_alien_ligne	
	ret


affichage_score: ;;routine d'affichage du score
	; A COMPLETER
ret

test_chiffre: ;routine de test des chiffres du score
    cmp dx,0
	je chiffre_0
	cmp dx,1
	je chiffre_1
	cmp dx,2
	je chiffre_2
	cmp dx,3
	je chiffre_3
	cmp dx,4
	je chiffre_4
	cmp dx,5
	je chiffre_5
	cmp dx,6
	je chiffre_6
	cmp dx,7
	je chiffre_7
	cmp dx,8
	je chiffre_8
	cmp dx,9
	je chiffre_9
	chiffre_0:
		mov bx,zero
		ret
	chiffre_1:
		mov bx,un
		ret
	chiffre_2:
		mov bx,deux
		ret
	chiffre_3:
		mov bx,trois
		ret
	chiffre_4:
		mov bx,quatre
		ret
	chiffre_5:
		mov bx,cinq
		ret
	chiffre_6:
		mov bx,six
		ret
	chiffre_7:
		mov bx,sept
		ret
	chiffre_8:
		mov bx,huit
		ret
	chiffre_9:
		mov bx,neuf
		ret

affiche_sprite: ;routine d'affichage d'un sprite
	mov bx,[add_sprite]
	mov ax,[y]
	mov cx,320
	mul cx
	mov dx,[x]
	add dx,ax
	mov di,dx
	mov cx,[h]
	ligne:
	push cx
	mov cx,[l]
		col:
			mov al,[bx]
			stosb ;equivalent à mov [es:di],al
			inc bx
		loop col
		sub di,[l]
		add di,320
	pop cx
	loop ligne
ret

init_tab: ;remplissage des tableaux des aliens
	mov cx,66
	mov bx,tab_alien
	mov [add1],bx
	mov bx,tab_alien_cte
	mov [add2],bx
	mov bx,tab_alienb
	mov [add3],bx
	mov bx,tab_alienb_cte
	mov [add4],bx
	init_loop:
	    mov bx,[add2]
		mov al,[bx]
		mov bx,[add1]
		mov [bx],al
		mov bx,[add4]
		mov al,[bx]
		mov bx,[add3]
		mov [bx],al
		inc word [add1]
		inc word [add2]
		inc word [add3]
		inc word [add4]
		loop init_loop
ret


	
[SEGMENT .data]
def_tab db 0;
score dw 0 ;score du jeu
reduc_vitesse dw 500 ;reducteur du compteur de vitesse : permet d'acceler le jeu à chaque nouveau tour
vitesse_initiale dw 3000 ;vitesse du jeu
vitesse dw 3000 ;compteur de vitesse du jeu
vitesse_tir dw 0 ;compteur de vitesse du tir
xinc dw 1 ;1 ou -1 utilisé pour le déplacement des aliens
x dw 0 ;parametre x de la routine d'affichage de sprite
y dw 0 ;parametre y de la routine d'affichage de sprite
h dw 0 ;hauteur du sprite à afficher dans la routine d'affichage
l dw 0 ;largeur du sprite à afficher dans la routine d'affichage
qx dw 0 ;quotient en x pour déterminer l'abscisse de l'alien tué
qy dw 0 ;quotient en y pour déterminer l'abscisse de l'alien tué
xa1 dw 30 ;position initiale x des aliens
ya1 dw 18 ;position initiale y des aliens
la1 dw 16 ;largeur d'un alien
ha1 dw 12 ;hauteur d'un alien
xt dw 0 ;position initiale x du tir
yt dw 185 ;position initiale y du tir
xv dw 160 ;position initiale x du vaisseau
yv dw 190 ;position initiale y du vaisseau
xc dw 70 ;position initiale x d'un chiffre du score
yc dw 10 ;position initiale y d'un chiffre du score
add_sprite dw 0 ;adresse d'un sprite à afficher
tab_alien_l dw 11 ;largeur des tabeaux des aliens
tab_alien_h dw 6 ;hauteur des tableaux des aliens
nb_aliens dw 55 ;nombre d'aliens
tir_OK dw 0 ;variable de test si le tir est OK
add1 dw 0 ;adresse de tab_alien
add2 dw 0 ;adresse de tab_alien_cte
add3 dw 0 ;adresse de tab_alienb
add4 dw 0 ;adresse de tab_alienb_cte

;tableau des aliens allure1 variable (en fonction des aliens tués)
tab_alien db 0,0,0,0,0,0,0,0,0,0,0
		  db 0,0,0,0,0,0,0,0,0,0,0  
		  db 0,0,0,0,0,0,0,0,0,0,0 
		  db 0,0,0,0,0,0,0,0,0,0,0 
		  db 0,0,0,0,0,0,0,0,0,0,0 
		  db 0,0,0,0,0,0,0,0,0,0,0 
		  
;tableau des aliens allure2 variable (en fonction des aliens tués)		  
tab_alienb db 0,0,0,0,0,0,0,0,0,0,0
		   db 0,0,0,0,0,0,0,0,0,0,0  
		   db 0,0,0,0,0,0,0,0,0,0,0 
		   db 0,0,0,0,0,0,0,0,0,0,0 
		   db 0,0,0,0,0,0,0,0,0,0,0 
		   db 0,0,0,0,0,0,0,0,0,0,0 

;tableau des aliens allure1 constant permettant la remise à zéro au tour suivant
tab_alien_cte db 0,0,0,0,0,0,0,0,0,0,0
		      db 5,5,5,5,5,5,5,5,5,5,5
		      db 1,1,1,1,1,1,1,1,1,1,1
		      db 1,1,1,1,1,1,1,1,1,1,1
		      db 3,3,3,3,3,3,3,3,3,3,3
		      db 3,3,3,3,3,3,3,3,3,3,3

;tableau des aliens allure2 constant permettant la remise à zéro au tour suivant
tab_alienb_cte db 0,0,0,0,0,0,0,0,0,0,0
 		       db 2,2,2,2,2,2,2,2,2,2,2
		       db 4,4,4,4,4,4,4,4,4,4,4
		       db 4,4,4,4,4,4,4,4,4,4,4
		       db 6,6,6,6,6,6,6,6,6,6,6
		       db 6,6,6,6,6,6,6,6,6,6,6
    
;sprite tir vaisseau
tir_v db 00,15,00
	  db 00,15,00
	  db 00,15,00
	  db 00,15,00
	  db 00,00,00
	  
;sprite masque tir vaisseau
tir_vide db 00,00,00
	     db 00,00,00
	     db 00,00,00
	     db 00,00,00
	     db 00,00,00
;anti trace
suivi_vaisseau
		 db 00,00,00,00,00
	     db 00,00,00,00,00
	     db 00,00,00,00,00
	     db 00,00,00,00,00
	     db 00,00,00,00,00
		 db 00,00,00,00,00
	     db 00,00,00,00,00	 

;sprite alien mort
mort db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
     db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	  
	 db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
     db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	  
	 db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
     db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	  
	 db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
     db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00  
	 db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
	 db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
	 db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
     db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	   

;sprite boom
boom db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
     db 00,00,00,15,00,00,00,15,00,00,00,00,00,00,00,00	  
	 db 00,00,00,00,15,00,00,15,00,00,15,00,00,00,00,00
     db 00,00,00,00,00,15,00,00,00,00,15,00,00,15,00,00  
	 db 00,00,00,00,00,00,00,00,00,15,00,00,15,00,00,00
     db 00,00,15,15,00,00,00,00,00,00,00,00,00,00,00,00	  
	 db 00,00,00,00,00,00,00,00,00,00,00,00,15,15,00,00
     db 00,00,00,15,00,00,15,00,00,00,15,00,00,00,00,00 
	 db 00,00,15,00,00,15,00,00,00,00,00,15,00,00,00,00
	 db 00,00,00,00,00,15,00,00,15,00,00,00,15,00,00,00
	 db 00,00,00,00,00,00,00,00,15,00,00,00,00,00,00,00
     db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	   

;sprite alien1 alure 1
alien1 db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
       db 00,00,00,00,00,15,00,00,00,00,00,15,00,00,00,00	  
	   db 00,00,00,00,00,00,15,00,00,00,15,00,00,00,00,00
       db 00,00,00,00,00,15,15,15,15,15,15,15,00,00,00,00	  
	   db 00,00,00,00,15,15,00,15,15,15,00,15,15,00,00,00
       db 00,00,00,15,15,15,15,15,15,15,15,15,15,15,00,00	  
	   db 00,00,00,15,15,15,15,15,15,15,15,15,15,15,00,00
       db 00,00,00,15,00,15,00,00,00,00,00,15,00,15,00,00	  
	   db 00,00,00,00,00,00,15,15,00,15,15,00,00,00,00,00
	   db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
	   db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
       db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	   

;sprite alien1 alure 2	   
alien1b db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
        db 00,00,00,00,00,15,00,00,00,00,00,15,00,00,00,00	  
	    db 00,00,00,15,00,00,15,00,00,00,15,00,00,15,00,00
        db 00,00,00,15,00,15,15,15,15,15,15,15,00,15,00,00	  
	    db 00,00,00,15,15,15,00,15,15,15,00,15,15,15,00,00
        db 00,00,00,15,15,15,15,15,15,15,15,15,15,15,00,00	  
	    db 00,00,00,00,15,15,15,15,15,15,15,15,15,00,00,00
        db 00,00,00,00,00,15,00,00,00,00,00,15,00,00,00,00	  
	    db 00,00,00,00,15,00,00,00,00,00,00,00,15,00,00,00
	    db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	   
   	    db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
        db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	   

;sprite alien2 alure 1		
alien2 db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
       db 00,00,00,00,00,00,00,15,15,00,00,00,00,00,00,00	  
	   db 00,00,00,00,00,00,15,15,15,15,00,00,00,00,00,00
       db 00,00,00,00,00,15,15,15,15,15,15,00,00,00,00,00	  
	   db 00,00,00,00,15,15,00,15,15,00,15,15,00,00,00,00	  
	   db 00,00,00,00,15,15,15,15,15,15,15,15,00,00,00,00
       db 00,00,00,00,00,00,15,00,00,15,00,00,00,00,00,00
       db 00,00,00,00,00,15,00,15,15,00,15,00,00,00,00,00	  
	   db 00,00,00,00,15,00,15,00,00,15,00,15,00,00,00,00
       db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
	   db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
       db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	   

;sprite alien2 alure 2	   
alien2b db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
        db 00,00,00,00,00,00,00,15,15,00,00,00,00,00,00,00	  
	    db 00,00,00,00,00,00,15,15,15,15,00,00,00,00,00,00
        db 00,00,00,00,00,15,15,15,15,15,15,00,00,00,00,00	  
	    db 00,00,00,00,15,15,00,15,15,00,15,15,00,00,00,00	  
	    db 00,00,00,00,15,15,15,15,15,15,15,15,00,00,00,00
        db 00,00,00,00,00,15,00,15,15,00,15,00,00,00,00,00
        db 00,00,00,00,15,00,00,00,00,00,00,15,00,00,00,00	  
	    db 00,00,00,00,00,15,00,00,00,00,15,00,00,00,00,00
        db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00   
 	    db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
        db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	   

;sprite alien3 alure 1		
alien3 db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
       db 00,00,00,00,00,00,15,15,15,15,00,00,00,00,00,00	  
	   db 00,00,00,15,15,15,15,15,15,15,15,15,15,00,00,00
       db 00,00,15,15,15,15,15,15,15,15,15,15,15,15,00,00	  
	   db 00,00,15,15,15,00,00,15,15,00,00,15,15,15,00,00	  
	   db 00,00,15,15,15,15,15,15,15,15,15,15,15,15,00,00	  
	   db 00,00,00,00,15,15,15,00,00,15,15,15,00,00,00,00
       db 00,00,00,15,15,00,00,15,15,00,00,15,15,00,00,00	  
	   db 00,00,00,00,15,15,00,00,00,00,15,15,00,00,00,00
       db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
	   db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
       db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	   

;sprite alien3 alure 2
alien3b db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
        db 00,00,00,00,00,00,15,15,15,15,00,00,00,00,00,00	  
	    db 00,00,00,15,15,15,15,15,15,15,15,15,15,00,00,00
        db 00,00,15,15,15,15,15,15,15,15,15,15,15,15,00,00	  
	    db 00,00,15,15,15,00,00,15,15,00,00,15,15,15,00,00	  
	    db 00,00,15,15,15,15,15,15,15,15,15,15,15,15,00,00	 	  
	    db 00,00,00,00,00,15,15,00,00,15,15,00,00,00,00,00
        db 00,00,00,00,15,15,00,15,15,00,15,15,00,00,00,00	  
	    db 00,00,15,15,00,00,00,00,00,00,00,00,15,15,00,00
        db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
	    db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
        db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	   

;sprite vaisseau
vaisseau db 00,00,00,07,07,00,00,00,00,00,07,07,00,00,00
		 db 00,00,07,07,00,00,07,07,07,00,00,07,07,00,00
		 db 00,07,07,00,00,07,07,07,07,07,00,00,07,07,00		
		 db 00,07,07,07,07,07,07,00,07,07,07,07,07,07,00		
		 db 00,07,07,07,07,07,07,07,07,07,07,07,07,07,00		
		 db 00,00,07,00,00,00,07,07,07,00,00,00,07,00,00		
		 db 00,00,00,07,00,00,00,00,00,00,00,07,00,00,00		

;sprites des chiffres du score

zero db 00,02,02,02,00
	 db 02,00,00,00,02
	 db 02,00,00,00,02
	 db 02,00,00,00,02
	 db 00,02,02,02,00
	 
un db 00,00,00,02,02
   db 00,00,00,00,02
   db 00,00,00,00,02
   db 00,00,00,00,02
   db 00,00,00,00,02
   
deux db 02,02,02,02,00
	 db 00,00,00,00,02
	 db 00,02,02,02,02
	 db 02,00,00,00,00
	 db 02,02,02,02,02
	 
trois db 02,02,02,02,00
	  db 00,00,00,00,02
	  db 00,02,02,02,02
	  db 00,00,00,00,02
	  db 02,02,02,02,00
	  
quatre db 02,00,00,00,02
	   db 02,00,00,00,02
	   db 02,02,02,02,02
	   db 00,00,00,00,02
	   db 00,00,00,00,02
	   
cinq db 02,02,02,02,02
	 db 02,00,00,00,00
	 db 02,02,02,02,00
	 db 00,00,00,00,02
	 db 02,02,02,02,00
	 
six  db 00,02,02,02,00
	 db 02,00,00,00,00
	 db 02,02,02,02,00
	 db 02,00,00,00,02
	 db 00,02,02,02,00
	 
sept db 02,02,02,02,02
	 db 00,00,00,00,02
	 db 00,00,00,00,02
	 db 00,00,00,02,00
	 db 00,00,00,02,00
	 
huit db 00,02,02,02,00
	 db 02,00,00,00,02
	 db 00,02,02,02,00
	 db 02,00,00,00,02
	 db 00,02,02,02,00
	 
neuf db 00,02,02,02,00
	 db 02,00,00,00,02
	 db 00,02,02,02,02
	 db 00,00,00,00,02
	 db 00,02,02,02,00

;sprite texte score	 
textscore db 00,15,15,15,15,00,00,15,15,15,15,00,00,15,15,15,00,00,15,15,15,15,00,00,15,15,15,15,15
		  db 15,00,00,00,00,00,15,00,00,00,00,00,15,00,00,00,15,00,15,00,00,00,15,00,15,00,00,00,00
	      db 00,15,15,15,00,00,15,00,00,00,00,00,15,00,00,00,15,00,15,15,15,15,00,00,15,15,15,15,00
	      db 00,00,00,00,15,00,15,00,00,00,00,00,15,00,00,00,15,00,15,00,00,00,15,00,15,00,00,00,00
	      db 15,15,15,15,00,00,00,15,15,15,15,00,00,15,15,15,00,00,15,00,00,00,15,00,15,15,15,15,15

;sprite message perdu  
perdu db 15,15,15,15,00,15,15,15,15,00,15,15,15,15,00,15,15,15,00,00,15,00,00,15
	  db 15,00,00,15,00,15,00,00,00,00,15,00,00,15,00,15,00,00,15,00,15,00,00,15
	  db 15,15,15,15,00,15,15,15,00,00,15,15,15,15,00,15,00,00,15,00,15,00,00,15
	  db 15,00,00,00,00,15,00,00,00,00,15,00,15,00,00,15,00,00,15,00,15,00,00,15
	  db 15,00,00,00,00,15,15,15,15,00,15,00,00,15,00,15,15,15,00,00,15,15,15,15
