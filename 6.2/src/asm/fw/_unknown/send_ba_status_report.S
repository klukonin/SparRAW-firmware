/* send_ba_status_report @ 0x8e5174, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   send_ba_status_report: m_conn_p or m_conn_p->get_conn_mid() already NULL, abort WMI report
 *   <<---- [HOST EVENT] WMI_BA_STATUS_EVENTID for midid %d.
 * Зовут его: ba__send_status_report_for_vring, sw_vring__ba_agreed, vring_ba_en__race_check
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log_emit0, fw_log_emit1, host_if__send_pair, low_sme__send_evt2sw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global send_ba_status_report
send_ba_status_report:
	.global L_8e5174
L_8e5174:
	push_s blink
L_8e5176:
	bl L_8c01d0
L_8e517a:
	mov_s r13,r0
L_8e517c:
	mov_s r15,r1
L_8e517e:
	mov_s r16,r2
L_8e5180:
	ld_s r0,[r0]
L_8e5182:
	mov r19,r4
L_8e5186:
	mov_s r17,r3
L_8e5188:
	mov r18,r5
L_8e518c:
	breq_s r0,0,L_8e5192
L_8e518e:
	ld_s r0,[r0,0x18]
L_8e5190:
	brne_s r0,0,L_8e51a0
	.global L_8e5192
L_8e5192:
	mov_s r1,0x1011030
L_8e5198:
	bl.d L_8dcba8
L_8e519c:
	mov_s r0,0x1b
L_8e519e:
	b_s L_8e5200
	.global L_8e51a0
L_8e51a0:
	bl L_8c32d8
L_8e51a4:
	mov_s r14,r0
L_8e51a6:
	stb r16,[r0]
L_8e51aa:
	stb r19,[r14, 0x6]
L_8e51ae:
	lsr r16,r16,0x8
L_8e51b2:
	stb r16,[r0, 0x1]
L_8e51b6:
	lsr r19,r19,0x8
L_8e51ba:
	mov_s r0,0x0
L_8e51bc:
	stb r19,[r14, 0x7]
L_8e51c0:
	stb_s r0,[r14,0x2]
L_8e51c2:
	stb_s r0,[r14,0x3]
L_8e51c4:
	stb_s r15,[r14,0x4]
L_8e51c6:
	stb r17,[r14, 0x5]
L_8e51ca:
	stb r18,[r14, 0x8]
L_8e51ce:
	ld_s r0,[r13]
L_8e51d0:
	mov_s r1,0x101108c
L_8e51d6:
	ld_s r2,[r0,0x18]
L_8e51d8:
	mov_s r0,0x2b
L_8e51da:
	bl.d L_8dcc10
L_8e51de:
	ldb_s r2,[r2,0x10]
L_8e51e0:
	ld_s r0,[r13]
L_8e51e2:
	mov_s r1,0x1823
L_8e51e8:
	ld_s r3,[r0,0x18]
L_8e51ea:
	mov_s r0,r14
L_8e51ec:
	mov_s r2,0x9
L_8e51ee:
	ldb_s r3,[r3,0x10]
L_8e51f0:
	mov r4,0x0
L_8e51f4:
	mov r5,r4
L_8e51f8:
	bl.d L_8e5474
L_8e51fc:
	mov r6,r4
	.global L_8e5200
L_8e5200:
	b L_8c022c
