/* mac__set_880af8_afc_b30_b6 @ 0x8d1250, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__apply_mode_fw_8825c0__8d10c8, pcie__program_seq_fw_8825c0__8d1114
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__set_880af8_afc_b30_b6
mac__set_880af8_afc_b30_b6:
	.global L_8d1250
L_8d1250:
	push_s blink
L_8d1252:
	bl L_8c01e0
L_8d1256:
	bclr.f r15,r0,0x0
L_8d125a:
	mov_s r13,r0
L_8d125c:
	bne_s L_8d1280
	.global L_8d125e
L_8d125e:
	mov_s r14,0x880a80
L_8d1264:
	ld_s r1,[r14,0x78]
L_8d1266:
	asl r0,r13,0x1e
L_8d126a:
	bclr_s r1,r1,0x1e
L_8d126c:
	or_s r0,r0,r1
L_8d126e:
	st_s r0,[r14,0x78]
L_8d1270:
	brne_s r15,0,L_8d128a
	.global L_8d1272
L_8d1272:
	ld_s r0,[r14,0x7c]
L_8d1274:
	/* asl_s r13,r13,0x6 */
	.byte 0x06,0xbd
L_8d1276:
	bclr_s r0,r0,0x6
L_8d1278:
	or_s r0,r0,r13
L_8d127a:
	st_s r0,[r14,0x7c]
L_8d127c:
	b L_8c024c
	.global L_8d1280
L_8d1280:
	mov_s r0,blink
L_8d1282:
	bl.d L_8c9b28
L_8d1286:
	mov_s r1,0xac
L_8d1288:
	b_s L_8d125e
	.global L_8d128a
L_8d128a:
	mov_s r0,blink
L_8d128c:
	bl.d L_8c9b28
L_8d1290:
	mov_s r1,0xac
L_8d1292:
	b_s L_8d1272
