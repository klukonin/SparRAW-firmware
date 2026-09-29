/* detector__init_common @ 0x8d8fa0, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: detector__init_per_cid_a, detector__init_per_cid_b, ka_necessity_detector__start_monitoring, l2mgr__init_periodic_detector, tx_ppdu_ageing_timeout_detector__start_monitoring
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, u_schd__now
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global detector__init_common
detector__init_common:
	.global L_8d8fa0
L_8d8fa0:
	push_s blink
L_8d8fa2:
	bl L_8c01dc
L_8d8fa6:
	mov_s r13,r0
L_8d8fa8:
	mov_s r14,r1
L_8d8faa:
	mov_s r15,r2
L_8d8fac:
	mov_s r16,r3
L_8d8fae:
	bl.d L_8e9524
L_8d8fb2:
	st r4,[r0, 0xc]
L_8d8fb6:
	st_s r14,[r13]
L_8d8fb8:
	st_s r15,[r13,0x4]
L_8d8fba:
	st r16,[r13, 0x8]
L_8d8fbe:
	mov_s r0,0x0
L_8d8fc0:
	st_s r0,[r13,0x10]
L_8d8fc2:
	mov r0,-0x1
L_8d8fc6:
	st_s r0,[r13,0x14]
L_8d8fc8:
	st_s r0,[r13,0x18]
L_8d8fca:
	st_s r0,[r13,0x1c]
L_8d8fcc:
	st_s r0,[r13,0x20]
L_8d8fce:
	mov_s r0,0x1
L_8d8fd0:
	st_s r0,[r13,0x28]
L_8d8fd2:
	mov_s r0,0xff
L_8d8fd4:
	b.d L_8c0244
L_8d8fd8:
	stb r0,[r13, 0x24]
