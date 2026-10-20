/* frame__build_delba @ 0x8f5004, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_sm__send_delba, wmi_rcp_delba
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bits__set8_s4_w4, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global frame__build_delba
frame__build_delba:
	.global L_8f5004
L_8f5004:
	push_s blink
L_8f5006:
	bl L_8c01dc
L_8f500a:
	mov_s r13,r0
L_8f500c:
	mov_s r15,r1
L_8f500e:
	mov_s r16,r2
L_8f5010:
	mov_s r14,r3
L_8f5012:
	bl.d L_8c1cd8
L_8f5016:
	mov_s r1,0x6
L_8f5018:
	mov_s r0,0x3
L_8f501a:
	stb_s r0,[r13]
L_8f501c:
	mov_s r0,0x2
L_8f501e:
	stb_s r0,[r13,0x1]
L_8f5020:
	bmsk r1,r16,0x3
L_8f5024:
	add_s r0,r13,0x3
L_8f5026:
	bl.d L_8ed2a4
L_8f502a:
	bmsk_s r15,r15,0x0
L_8f502c:
	ldb_s r0,[r13,0x3]
L_8f502e:
	/* asl_s r15,r15,0x3 */
	.byte 0x03,0xbf
L_8f5030:
	bclr_s r0,r0,0x3
L_8f5032:
	or_s r0,r0,r15
L_8f5034:
	stb_s r0,[r13,0x3]
L_8f5036:
	stw_s r14,[r13,0x4]
L_8f5038:
	b.d L_8c0244
L_8f503c:
	mov_s r0,0x6
L_8f503e:
	nop_s
