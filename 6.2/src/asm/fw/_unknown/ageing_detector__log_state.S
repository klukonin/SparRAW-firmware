/* ageing_detector__log_state @ 0x8e110c, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [NNL] | cid %d | ageing %d | ack_cnt %d
 *   [NNL]  | last_ack_cnt %d | tx_avail %d | ka_avail %d
 *   [NNL] | atim_tx_no_ack %d | vr_dur %d | nav %d
 * Зовут его: tx_ppdu_ageing_timeout_detector__task
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ageing_detector__log_state
ageing_detector__log_state:
	.global L_8e110c
L_8e110c:
	push_s blink
L_8e110e:
	bl.d L_8c01d4
L_8e1112:
	mov_s r9,r2
L_8e1114:
	mov_s r13,r0
L_8e1116:
	mov_s r14,r1
L_8e1118:
	mov_s r8,r3
L_8e111a:
	mov_s r15,r4
L_8e111c:
	mov r16,r5
L_8e1120:
	mov r18,r6
L_8e1124:
	mov r17,r7
L_8e1128:
	mov_s r1,0x1014a34
L_8e112e:
	mov_s r0,0x2b
L_8e1130:
	ldb r2,[r13, 0x30]
L_8e1134:
	mov_s r3,r9
L_8e1136:
	bl.d L_8dcd00
L_8e113a:
	mov r4,r8
L_8e113e:
	mov_s r1,0x1014a5c
L_8e1144:
	mov_s r0,0x2b
L_8e1146:
	mov_s r2,r15
L_8e1148:
	mov_s r3,r16
L_8e114a:
	bl.d L_8dcd00
L_8e114e:
	mov r4,r18
L_8e1152:
	mov_s r1,0x1014a94
L_8e1158:
	ld r4,[sp, 0x20]
L_8e115c:
	mov_s r0,0x2b
L_8e115e:
	mov_s r2,r17
L_8e1160:
	bl.d L_8dcd00
L_8e1164:
	ld_s r3,[sp,0x1c]
L_8e1166:
	ld_s r1,[r14]
L_8e1168:
	ld_s r0,[r14,0x4]
L_8e116a:
	st_s r1,[r13,0x4c]
L_8e116c:
	b.d L_8c0234
L_8e1170:
	st_s r0,[r13,0x50]
L_8e1172:
	nop_s
