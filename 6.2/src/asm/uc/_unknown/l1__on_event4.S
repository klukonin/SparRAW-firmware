/* l1__on_event4 @ 0x92cd20, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc__check_g8004f4_0_1_2
 * Зовёт сам: dti_alloc__dispatch, l1_task__dispatch, ps__hold_awake_if_active, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l1__on_event4
l1__on_event4:
	.global L_92cd20
L_92cd20:
	push_s blink
L_92cd22:
	mov_s r0,r54
L_92cd24:
	bbit0 r0,0xf,L_92cd44
L_92cd28:
	mov_s r0,0x49008000
L_92cd2e:
	mov_s r32,r0
L_92cd30:
	st.ab r0,[r25,0x4]
L_92cd34:
	bclr r25,r25,0xa
L_92cd38:
	mov_s r0,0x4
L_92cd3a:
	bl.d L_934e30
L_92cd3e:
	mov_s r1,0x0
	.global L_92cd40
L_92cd40:
	pop_s blink
L_92cd42:
	j_s [blink]
	.global L_92cd44
L_92cd44:
	mov_s r0,r54
L_92cd46:
	bbit0 r0,0x4,L_92cd66
L_92cd4a:
	mov_s r0,0x49000010
L_92cd50:
	mov_s r32,r0
L_92cd52:
	st.ab r0,[r25,0x4]
L_92cd56:
	bclr r25,r25,0xa
L_92cd5a:
	mov_s r0,0x802f44
L_92cd60:
	bl L_92b75c
L_92cd64:
	b_s L_92cd40
	.global L_92cd66
L_92cd66:
	mov_s r0,r54
L_92cd68:
	bbit0 r0,0x11,L_92cd88
L_92cd6c:
	mov_s r0,0x49020000
L_92cd72:
	mov_s r32,r0
L_92cd74:
	st.ab r0,[r25,0x4]
L_92cd78:
	bclr r25,r25,0xa
L_92cd7c:
	mov_s r0,0x802f80
L_92cd82:
	bl L_93da98
L_92cd86:
	b_s L_92cd40
	.global L_92cd88
L_92cd88:
	mov_s r0,blink
L_92cd8a:
	bl.d L_926618
L_92cd8e:
	mov_s r1,0x2c
L_92cd90:
	b_s L_92cd40
L_92cd92:
	nop_s
