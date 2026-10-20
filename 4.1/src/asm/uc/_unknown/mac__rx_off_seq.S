/* mac__rx_off_seq @ 0x932614, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__set_rx_off
 * Зовёт сам: mac__cmd_29000001, mac__select_sector_and_wait_b
 */
	.section .text.mac__rx_off_seq,"ax",@progbits
	.global mac__rx_off_seq
mac__rx_off_seq:
	.global L_932614
L_932614:
	push_s blink
L_932616:
	bl L_931640
L_93261a:
	bl.d L_931664
L_93261e:
	mov_s r0,0x0
L_932620:
	mov_s r0,0x3d000004
L_932626:
	mov_s r32,r0
L_932628:
	st.ab r0,[r25,0x4]
L_93262c:
	bclr r25,r25,0xa
L_932630:
	mov_s r0,0x29000002
L_932636:
	mov_s r32,r0
L_932638:
	st.ab r0,[r25,0x4]
L_93263c:
	bclr r25,r25,0xa
L_932640:
	pop_s blink
L_932642:
	j_s [blink]
