/* hwd_abif__uses_rgf_889480_8cebac @ 0x8cebac, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: init_rf_hw
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__uses_rgf_889480_8cebac
hwd_abif__uses_rgf_889480_8cebac:
	.global L_8cebac
L_8cebac:
	push_s blink
L_8cebae:
	push_s r13
L_8cebb0:
	cmp_s r0,0x0
L_8cebb2:
	mov_s r13,0x1
L_8cebb4:
	sub_s.ne r13,r13,r13
L_8cebb6:
	bclr.f 0x0,r13,0x0
L_8cebba:
	bne_s L_8cebd0
	.global L_8cebbc
L_8cebbc:
	mov_s r1,0x889480
L_8cebc2:
	ld_s r0,[r1,0x8]
L_8cebc4:
	asl_s r13,r13,0x1b
L_8cebc6:
	bclr_s r0,r0,0x1b
L_8cebc8:
	or_s r13,r13,r0
L_8cebca:
	st_s r13,[r1,0x8]
L_8cebcc:
	b L_8c025c
	.global L_8cebd0
L_8cebd0:
	mov_s r0,blink
L_8cebd2:
	bl.d L_8c9b28
L_8cebd6:
	mov_s r1,0xac
L_8cebd8:
	b_s L_8cebbc
L_8cebda:
	nop_s
