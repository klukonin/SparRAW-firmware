/* conn_main_sm__start_disc_8e797c @ 0x8e797c, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_main_sm::start_disc() - Starting disconnection
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, basic_sm__handle_event, fw_log_emit0, sys_state__broadcast_7, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_main_sm__start_disc_8e797c
conn_main_sm__start_disc_8e797c:
	.global L_8e797c
L_8e797c:
	push_s blink
L_8e797e:
	bl L_8c01dc
L_8e7982:
	mov_s r14,r0
L_8e7984:
	mov_s r16,r1
L_8e7986:
	mov_s r15,r2
L_8e7988:
	mov_s r1,0x1011b0c
L_8e798e:
	bl.d L_8dcba8
L_8e7992:
	mov_s r0,0x2b
L_8e7994:
	mov_s r13,0x0
L_8e7996:
	ld_s r0,[r14,0x2c]
L_8e7998:
	st_s r13,[r14,0x38]
L_8e799a:
	st_s r13,[r14,0x34]
L_8e799c:
	breq_s r0,0,L_8e79a4
L_8e799e:
	bl L_8c8de0
L_8e79a2:
	st_s r13,[r14,0x2c]
	.global L_8e79a4
L_8e79a4:
	bl.d L_8f2790
L_8e79a8:
	ld_s r0,[r14,0x8]
L_8e79aa:
	add r0,r14,0xc
L_8e79ae:
	mov_s r1,0x0
L_8e79b0:
	mov_s r2,r16
L_8e79b2:
	mov_s r3,r15
L_8e79b4:
	bl.d L_8d9b6c
L_8e79b8:
	mov_s r4,r1
L_8e79ba:
	b L_8c0244
L_8e79be:
	nop_s
