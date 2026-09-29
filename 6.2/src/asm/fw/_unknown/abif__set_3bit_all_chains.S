/* abif__set_3bit_all_chains @ 0x8d0228, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_power__step
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, hwd_abif__tx_table_config_xif_gain
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global abif__set_3bit_all_chains
abif__set_3bit_all_chains:
	.global L_8d0228
L_8d0228:
	push_s blink
L_8d022a:
	bl L_8c01dc
L_8d022e:
	mov_s r13,r0
L_8d0230:
	mov_s r0,0x0
L_8d0232:
	bl.d L_8cfe9c
L_8d0236:
	mov_s r1,r13
L_8d0238:
	mov_s r0,0x1
L_8d023a:
	bl.d L_8cfe9c
L_8d023e:
	mov_s r1,r13
L_8d0240:
	bic.f r15,r13,0x7
L_8d0244:
	bne_s L_8d027e
	.global L_8d0246
L_8d0246:
	mov_s r14,0x88af00
L_8d024c:
	ld_s r0,[r14,0x6c]
L_8d024e:
	mov r16,0x88b000
L_8d0256:
	bic r0,r0,0x7
L_8d025a:
	or_s r0,r0,r13
L_8d025c:
	st_s r0,[r14,0x6c]
L_8d025e:
	brne_s r15,0,L_8d0288
	.global L_8d0260
L_8d0260:
	ld_s r0,[r14,0x78]
L_8d0262:
	bic r0,r0,0x7
L_8d0266:
	or_s r0,r0,r13
L_8d0268:
	st_s r0,[r14,0x78]
L_8d026a:
	brne_s r15,0,L_8d0292
	.global L_8d026c
L_8d026c:
	ld r0,[r16, -0x7c]
L_8d0270:
	bic r0,r0,0x7
L_8d0274:
	or_s r13,r13,r0
L_8d0276:
	st r13,[r16, -0x7c]
L_8d027a:
	b L_8c0244
	.global L_8d027e
L_8d027e:
	mov_s r0,blink
L_8d0280:
	bl.d L_8c9b28
L_8d0284:
	mov_s r1,0xac
L_8d0286:
	b_s L_8d0246
	.global L_8d0288
L_8d0288:
	mov_s r0,blink
L_8d028a:
	bl.d L_8c9b28
L_8d028e:
	mov_s r1,0xac
L_8d0290:
	b_s L_8d0260
	.global L_8d0292
L_8d0292:
	mov_s r0,blink
L_8d0294:
	bl.d L_8c9b28
L_8d0298:
	mov_s r1,0xac
L_8d029a:
	b_s L_8d026c
