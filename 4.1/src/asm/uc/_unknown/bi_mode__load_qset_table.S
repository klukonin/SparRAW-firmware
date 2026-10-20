/* bi_mode__load_qset_table @ 0x935a00, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode_init_sequence
 * Зовёт сам: memcpy_uc
 */
	.section .text.bi_mode__load_qset_table,"ax",@progbits
	.global bi_mode__load_qset_table
bi_mode__load_qset_table:
	.global L_935a00
L_935a00:
	push_s blink
L_935a02:
	sub sp,sp,0x100
L_935a06:
	mov_s r0,0x4a000018
L_935a0c:
	mov_s r32,r0
L_935a0e:
	st.ab r0,[r25,0x4]
L_935a12:
	bclr r25,r25,0xa
L_935a16:
	mov_s r0,0x886f00
L_935a1c:
	st 0x3780378,[r0, 0x60]
L_935a24:
	mov_s r0,sp
L_935a26:
	mov_s r1,0x800cd0
L_935a2c:
	bl.d L_920310
L_935a30:
	mov r2,0x100
L_935a34:
	mov_s r0,0x8014f0
L_935a3a:
	mov_s r1,sp
L_935a3c:
	bl.d L_920310
L_935a40:
	mov r2,0x100
L_935a44:
	add sp,sp,0x100
L_935a48:
	pop_s blink
L_935a4a:
	j_s [blink]
