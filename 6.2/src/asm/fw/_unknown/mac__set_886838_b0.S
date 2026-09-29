/* mac__set_886838_b0 @ 0x8f811c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_bringup
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__set_886838_b0
mac__set_886838_b0:
	.global L_8f811c
L_8f811c:
	push_s blink
L_8f811e:
	push_s r13
L_8f8120:
	mov_s r13,r0
L_8f8122:
	bclr.f r0,r0,0x0
L_8f8126:
	bne_s L_8f813a
	.global L_8f8128
L_8f8128:
	mov_s r1,0x886800
L_8f812e:
	ld_s r0,[r1,0x38]
L_8f8130:
	bclr_s r0,r0,0x0
L_8f8132:
	or_s r13,r13,r0
L_8f8134:
	st_s r13,[r1,0x38]
L_8f8136:
	b L_8c025c
	.global L_8f813a
L_8f813a:
	mov_s r0,blink
L_8f813c:
	bl.d L_8c9b28
L_8f8140:
	mov_s r1,0xac
L_8f8142:
	b_s L_8f8128
