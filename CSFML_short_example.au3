#include "CSFML.au3"

If FileExists(@ScriptDir & "\logo4.gif") = False Then

	MsgBox(0, "CSFML short example", "The file named ""logo4.gif"" is missing.  Exiting.")
	Exit
EndIf

If FileExists(@ScriptDir & "\arial.ttf") = False Then

	MsgBox(0, "CSFML short example", "The file named ""arial.ttf"" is missing.  Exiting.")
	Exit
EndIf

MsgBox(0, "CSFML short example", "The following SFML GUI will display a sprite (logo4.gif) that you can" & @CRLF & "move around using the ""A"", ""S"", ""D"", and ""W"" keys" & @CRLF & @CRLF & "Use the ""Q"" and ""E"" keys to rotate the sprite." & @CRLF & @CRLF & "Press ""Esc"" to close the GUI.")

; Load the CSFML libraries
_CSFML_Startup()

; Create a sfEvent structure (for capturing SFML events below)
Local $event = _CSFML_sfEvent_Constructor()
Local $event_ptr = DllStructGetPtr($event)

; Create a sfVector2f structure (for handling sprite positions below)
Local $sprite_pos = _CSFML_sfVector2f_Constructor(320, 270)
Local $sprite_pos_ptr = DllStructGetPtr($sprite_pos)

; Create a sfVector2f structure (for handling text positions below)
Local $text_pos = _CSFML_sfVector2f_Constructor(40, 270)
Local $text_pos_ptr = DllStructGetPtr($text_pos)

; Define the SFML colors we will use
Local $black = _CSFML_sfColor_Constructor(0, 0, 0, 0)
Local $white = _CSFML_sfColor_Constructor(255, 255, 255, 0)

; Create a sfVideoMode structure, and define it as 800 x 600 pixels and 32 bits
Local $video_mode = _CSFML_sfVideoMode_Constructor(800, 600, 32)

; Create the main window
Local $window_ptr = _CSFML_sfRenderWindow_create($video_mode, "SFML window", $CSFML_sfWindowStyle_sfResize + $CSFML_sfWindowStyle_sfClose, Null)

; Load a sprite to display
Local $texture_ptr = _CSFML_sfTexture_createFromFile("logo4.gif", Null)
Local $sprite_ptr = _CSFML_sfSprite_create()
_CSFML_sfSprite_setTexture($sprite_ptr, $texture_ptr, True)

; Create a graphical text to display
Local $font_ptr = _CSFML_sfFont_createFromFile("arial.ttf")
Local $text_ptr = _CSFML_sfText_create()
_CSFML_sfText_setString($text_ptr, "Hello SFML")
_CSFML_sfText_setFont($text_ptr, $font_ptr)
_CSFML_sfText_setCharacterSize($text_ptr, 50)
_CSFML_sfText_setFillColor($text_ptr, $black)
_CSFML_sfText_setPosition($text_ptr, $text_pos)

_CSFML_sfSprite_setOrigin($sprite_ptr, _CSFML_sfVector2f_Constructor(85, 34))

Local $x_shift, $y_shift

; Start the game loop
While _CSFML_sfRenderWindow_isOpen($window_ptr) = True

	$x_shift = 0
	$y_shift = 0

	; Process events
	While _CSFML_sfRenderWindow_pollEvent($window_ptr, $event_ptr) = True

		Switch DllStructGetData($event, 1)

			; if the user closed the GUI
			Case $CSFML_sfEvtClosed

				; Close window : exit
				_CSFML_sfRenderWindow_close($window_ptr)

			; if the user pressed a key
			Case $CSFML_sfEvtKeyPressed

				; get the code of the key pressed
				Local $key_code = DllStructGetData($event, 2)

				Switch $key_code

					; if the user pressed Esc
					Case 36

						; Close window : exit
						_CSFML_sfRenderWindow_close($window_ptr)

					; if the user pressed A
					case 0

						; Move the sprite 5 pixels to the left
						$x_shift = $x_shift - 5
						_CSFML_sfVector2f_Move($sprite_pos_ptr, $x_shift, $y_shift)

					; if the user pressed D
					case 3

						; Move the sprite 5 pixels to the right
						$x_shift = $x_shift + 5
						_CSFML_sfVector2f_Move($sprite_pos_ptr, $x_shift, $y_shift)

					; if the user pressed S
					Case 18

						; Move the sprite 5 pixels down
						$y_shift = $y_shift + 5
						_CSFML_sfVector2f_Move($sprite_pos_ptr,$x_shift,$y_shift)

					; if the user pressed W
					Case 22

						; Move the sprite 5 pixels up
						$y_shift = $y_shift - 5
						_CSFML_sfVector2f_Move($sprite_pos_ptr,$x_shift,$y_shift)

					; if the user pressed E
					Case 4

						; Rotate the sprite 5 pixels clockwise
						_CSFML_sfSprite_rotate($sprite_ptr, 5)

					; if the user pressed Q
					Case 16

						; Rotate the sprite 5 pixels counter-clockwise
						_CSFML_sfSprite_rotate($sprite_ptr, -5)
				EndSwitch
		EndSwitch
	WEnd

	; Clear the screen
	_CSFML_sfRenderWindow_clear($window_ptr, $white)

	; Set the position of the sprite
	_CSFML_sfSprite_setPosition($sprite_ptr, $sprite_pos)

	; Draw the sprite
	_CSFML_sfRenderWindow_drawSprite($window_ptr, $sprite_ptr, Null)

	;Draw the text
	_CSFML_sfRenderWindow_drawText($window_ptr, $text_ptr, Null)

	; Update the window
	_CSFML_sfRenderWindow_display($window_ptr)

WEnd

; Unload the CSFML libraries
_CSFML_Shutdown()
