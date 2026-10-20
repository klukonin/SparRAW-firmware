/* rm__store_tune_request @ 0x8e9ab4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_main_sm__secondary_tune_done, rm_sm__action_8e0eb0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm__store_tune_request
rm__store_tune_request:
	.global L_8e9ab4
L_8e9ab4:
	add r0,r0,0x80
L_8e9ab8:
	st_s r2,[r0,0x8]
L_8e9aba:
	st_s r1,[r0,0xc]
L_8e9abc:
	j_s.d [blink]
L_8e9abe:
	stb_s r3,[r0,0x10]
