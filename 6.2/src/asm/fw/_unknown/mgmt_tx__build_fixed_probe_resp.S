/* mgmt_tx__build_fixed_probe_resp @ 0x8ea0d8, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIXED SW PROBE RESP header %d bytes, so far %d bytes, pkt at 0x%8X
 *   PROBE RESP fields %d bytes, so far %d bytes, pkt at 0x%8X
 * Зовут его: mgmt_tx__render_probe_resp
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit3, hexdump_words, memcpy_fw, mgmt_tx__copy_ie_hdr, mgmt_tx__probe_resp_ies_8d8378
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mgmt_tx__build_fixed_probe_resp
mgmt_tx__build_fixed_probe_resp:
	.global L_8ea0d8
L_8ea0d8:
	push_s blink
L_8ea0da:
	bl L_8c01d4
L_8ea0de:
	mov_s r13,r0
L_8ea0e0:
	mov_s r16,r1
L_8ea0e2:
	mov_s r14,r2
L_8ea0e4:
	mov_s r15,r3
L_8ea0e6:
	mov r17,r4
L_8ea0ea:
	mov_s r1,r3
L_8ea0ec:
	bl.d L_8c0380
L_8ea0f0:
	mov_s r2,0x18
L_8ea0f2:
	add r18,r13,0x18
L_8ea0f6:
	add_s r15,r15,0x24
L_8ea0f8:
	sub r17,r17,0x24
L_8ea0fc:
	extw r17,r17
L_8ea100:
	mov_s r1,0x1013cec
L_8ea106:
	mov_s r0,0x2d
L_8ea108:
	mov_s r2,0x18
L_8ea10a:
	mov_s r3,r2
L_8ea10c:
	bl.d L_8dcd00
L_8ea110:
	mov r4,r18
L_8ea114:
	add3 r1,r14,0x9
L_8ea118:
	bl.d L_8d7fd4
L_8ea11c:
	mov_s r0,r18
L_8ea11e:
	mov_s r2,r0
L_8ea120:
	add r18,r18,r0
L_8ea124:
	add r13,r0,0x18
L_8ea128:
	extw_s r13,r13
L_8ea12a:
	mov_s r1,0x1013d30
L_8ea130:
	mov_s r0,0x2d
L_8ea132:
	mov_s r3,r13
L_8ea134:
	bl.d L_8dcd00
L_8ea138:
	mov r4,r18
L_8ea13c:
	mov_s r0,r18
L_8ea13e:
	mov_s r1,r14
L_8ea140:
	mov_s r2,r15
L_8ea142:
	bl.d L_8d8378
L_8ea146:
	mov_s r3,r17
L_8ea148:
	add_s r13,r13,r0
L_8ea14a:
	extw_s r13,r13
L_8ea14c:
	mov_s r0,r18
L_8ea14e:
	bl.d L_8c9790
L_8ea152:
	mov_s r1,r13
L_8ea154:
	b.d L_8c0234
L_8ea158:
	stw r13,[r16]
