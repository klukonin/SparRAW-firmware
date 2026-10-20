/* frame__build_ftm_request @ 0x8f5040, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_mgmt_ftm_req
 * Зовёт сам: __ld_r13_to_r13_ret, bits__set8_s0_w2, bits__set8_s0_w4, bits__set8_s2_w5, bits__set8_s2_w6, bits__set8_s4_w4, frame__bits_set8_s3_w5
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global frame__build_ftm_request
frame__build_ftm_request:
	.global L_8f5040
L_8f5040:
	push_s blink
L_8f5042:
	push_s r13
L_8f5044:
	ld.as r3,[r1,0x60]
L_8f5048:
	mov_s r1,0x20
L_8f504a:
	stb_s r1,[r0,0x1]
L_8f504c:
	mov_s r1,0x4
L_8f504e:
	stb_s r1,[r0]
L_8f5050:
	mov_s r1,0x1
L_8f5052:
	stb_s r1,[r0,0x2]
L_8f5054:
	add_s r13,r0,0x3
L_8f5056:
	ld_s r0,[r2]
L_8f5058:
	/* add_s r0,0x3 */
	.byte 0x03,0xe0
L_8f505a:
	st_s r0,[r2]
L_8f505c:
	mov_s r0,0xce
L_8f505e:
	stb_s r0,[r13]
L_8f5060:
	mov_s r0,0x9
L_8f5062:
	stb_s r0,[r13,0x1]
L_8f5064:
	mov_s r2,0x0
L_8f5066:
	add_s r0,r13,0x2
L_8f5068:
	mov_s r1,r2
L_8f506a:
	bl.d L_8ed22c
L_8f506e:
	add_s r3,r3,0x8
L_8f5070:
	bl L_8ed274
L_8f5074:
	ldb_s r1,[r3,0x4]
L_8f5076:
	add_s r0,r13,0x3
L_8f5078:
	bmsk_s r1,r1,0x3
L_8f507a:
	bl L_8ed238
L_8f507e:
	ldb_s r1,[r3,0x5]
L_8f5080:
	bmsk_s r1,r1,0x3
L_8f5082:
	bl L_8ed2a4
L_8f5086:
	stb_s r2,[r13,0x4]
L_8f5088:
	stb_s r2,[r13,0x5]
L_8f508a:
	lsr_s r2,r2,0x8
L_8f508c:
	ldb_s r0,[r13,0x7]
L_8f508e:
	stb_s r2,[r13,0x6]
L_8f5090:
	or r0,r0,0x3
L_8f5094:
	stb_s r0,[r13,0x7]
L_8f5096:
	ldb_s r1,[r3,0x1]
L_8f5098:
	bclr_s r0,r0,0x2
L_8f509a:
	bic r1,r1,-0x3
L_8f509e:
	asr_s r1,r1
L_8f50a0:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8f50a2:
	or_s r0,r0,r1
L_8f50a4:
	stb_s r0,[r13,0x7]
L_8f50a6:
	ldb_s r1,[r3,0x3]
L_8f50a8:
	add_s r0,r13,0x7
L_8f50aa:
	bmsk_s r1,r1,0x4
L_8f50ac:
	bl L_8ed28c
L_8f50b0:
	add r0,r13,0x8
L_8f50b4:
	mov_s r1,0x1f
L_8f50b6:
	bl L_8ed280
L_8f50ba:
	ldw_s r1,[r3,0x6]
L_8f50bc:
	stb_s r1,[r13,0x9]
L_8f50be:
	lsr_s r1,r1,0x8
L_8f50c0:
	stb_s r1,[r13,0xa]
L_8f50c2:
	b.d L_8c025c
L_8f50c6:
	mov_s r0,0xe
