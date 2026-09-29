/* ba_setup_sm__addba_req_sent @ 0x8e9278, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ba_setup_sm::addba_req_sent() tsf 0x%08x%08x
 * Зовёт сам: __ld_r13_ret, fw_log__emit2, mac_read_tsf64, u_schd__schedule
 * Глобалы (через gp): 0x80029c
 */
	.section .text.ba_setup_sm__addba_req_sent,"ax",@progbits
	.global ba_setup_sm__addba_req_sent
ba_setup_sm__addba_req_sent:
L_8e9278:
	/* b_s 0x008e924e */
	.byte 0xeb,0xf1
	.global fwlog_ba_setup_sm_addba_req_sent_tsf_0x_08x_08
fwlog_ba_setup_sm_addba_req_sent_tsf_0x_08x_08:
L_8e927a:
	nop_s
L_8e927c:
	push_s blink
L_8e927e:
	push_s r13
L_8e9280:
	sub_s sp,sp,0x8
L_8e9282:
	mov_s r13,r0
L_8e9284:
	mov_s r1,sp
L_8e9286:
	mov_s r0,0x0
L_8e9288:
	bl.d L_8e4840
L_8e928c:
	mov_s r2,r0
L_8e928e:
	mov_s r2,0x101041c
L_8e9294:
	ld r4,[sp]
L_8e9298:
	mov_s r0,0x7
L_8e929a:
	mov_s r1,0x2
L_8e929c:
	bl.d L_8edff8
L_8e92a0:
	ld_s r3,[sp,0x4]
L_8e92a2:
	ld_s r0,[r13,0x30]
L_8e92a4:
	/* brne_s r0,0,0x008e92c6 */
	.byte 0x91,0xe8
	.global L_8e92a6
L_8e92a6:
	mov_s r0,0x293b0
L_8e92ac:
	ld.as r4,[gp,0x4b]
L_8e92b0:
	mov_s r1,r13
L_8e92b2:
	mov_s r2,0x0
L_8e92b4:
	mov_s r3,r2
L_8e92b6:
	mov_s r5,r2
L_8e92b8:
	bl.d L_8dc92c
L_8e92bc:
	mov_s r6,r2
L_8e92be:
	st_s r0,[r13,0x30]
L_8e92c0:
	b.d L_8c033c
