/* hwd_abif__uses_rgf_889380 @ 0x8d0098, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf__configure_chain
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__uses_rgf_889380
hwd_abif__uses_rgf_889380:
	.global L_8d0098
L_8d0098:
	push_s blink
L_8d009a:
	bl L_8c01e4
L_8d009e:
	mov_s r14,r1
L_8d00a0:
	mov_s r13,0x889380
L_8d00a6:
	st_s r0,[r13,0x1c]
L_8d00a8:
	bic.f r1,r1,0x1f
L_8d00ac:
	bne_s L_8d00c0
	.global L_8d00ae
L_8d00ae:
	ld_s r0,[r13,0x18]
L_8d00b0:
	bic r0,r0,0x1f
L_8d00b4:
	or_s r14,r14,r0
L_8d00b6:
	st_s r14,[r13,0x18]
L_8d00b8:
	sync
L_8d00bc:
	b L_8c0254
	.global L_8d00c0
L_8d00c0:
	mov_s r0,blink
L_8d00c2:
	bl.d L_8c9b28
L_8d00c6:
	mov_s r1,0xac
L_8d00c8:
	b_s L_8d00ae
L_8d00ca:
	nop_s
