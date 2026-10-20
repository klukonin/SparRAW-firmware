/* hwd_abif__rgf_889480_8ccad8 @ 0x8ccad8, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: hwf__rf_lo_setup, phy_ber__enable_dig_loopback
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_abif__rgf_889480_8ccad8,"ax",@progbits
	.global hwd_abif__rgf_889480_8ccad8
hwd_abif__rgf_889480_8ccad8:
	.global L_8ccad8
L_8ccad8:
	push_s blink
L_8ccada:
	bl L_8c02bc
L_8ccade:
	mov.f r1,r0
L_8ccae2:
	mov.ne r1,0x1
L_8ccae6:
	cmp_s r0,0x0
L_8ccae8:
	mov_s r13,0x1
L_8ccaea:
	sub_s.ne r13,r13,r13
L_8ccaec:
	mov_s r12,r13
L_8ccaee:
	bic.f r12,r12,-0xff
L_8ccaf2:
	asl r16,r1,0x2
L_8ccaf6:
	bne_s L_8ccb1e
	.global L_8ccaf8
L_8ccaf8:
	bic.f 0x0,r16,0xf
L_8ccafc:
	bne_s L_8ccb32
	.global L_8ccafe
L_8ccafe:
	mov_s r0,0x889480
L_8ccb04:
	ld_s r2,[r0,0x24]
L_8ccb06:
	asl_s r13,r13,0xf
L_8ccb08:
	mov_s r1,0xffff07ff
L_8ccb0e:
	and_s r1,r1,r2
L_8ccb10:
	or_s r13,r13,r1
L_8ccb12:
	asl r1,r16,0xb
L_8ccb16:
	or_s r1,r1,r13
L_8ccb18:
	st_s r1,[r0,0x24]
L_8ccb1a:
	b L_8c0324
	.global L_8ccb1e
L_8ccb1e:
	mov_s r0,blink
L_8ccb20:
	mov_s r2,0x1019954
L_8ccb26:
	mov_s r1,0xad
L_8ccb28:
	bl.d L_8c82c0
L_8ccb2c:
	mov r3,0x6fe
L_8ccb30:
	b_s L_8ccaf8
	.global L_8ccb32
L_8ccb32:
	mov_s r0,blink
L_8ccb34:
	mov_s r2,0x1019954
L_8ccb3a:
	mov_s r1,0xae
L_8ccb3c:
	bl.d L_8c82c0
L_8ccb40:
	mov r3,0x6fe
L_8ccb44:
	b_s L_8ccafe
L_8ccb46:
	nop_s
