/* lmac_if__forward_evt_to_obj @ 0x8c3f08, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__ucode_evt_check_8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__forward_evt_to_obj
lmac_if__forward_evt_to_obj:
	.global L_8c3f08
L_8c3f08:
	mov_s r2,r0
L_8c3f0a:
	ldb_s r0,[r0,0x3]
L_8c3f0c:
	stb r0,[gp, 0xc9]
L_8c3f10:
	ld_s r0,[gp,-0x64]
L_8c3f12:
	ld_s r1,[r0,0x8]
L_8c3f14:
	ld_s r3,[r1,0x8]
L_8c3f16:
	j_s.d [r3]
L_8c3f18:
	mov_s r1,0x2
L_8c3f1a:
	nop_s
