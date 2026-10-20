/* l2mgr__send_vring_en_evt @ 0x8f8ee4, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_VRING_EN_EVENTID for VRING %d.
 * Зовут его: STREAM_MGR__ADD, l2mgr__data_port_open_and_keys, vring__send_en_evt_u8
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit1, host_if__send_pair, low_sme__send_evt2sw, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__send_vring_en_evt
l2mgr__send_vring_en_evt:
	.global L_8f8ee4
L_8f8ee4:
	push_s blink
L_8f8ee6:
	bl L_8c01e0
L_8f8eea:
	mov_s r13,r0
L_8f8eec:
	bl.d L_8c32d8
L_8f8ef0:
	mov_s r15,r1
L_8f8ef2:
	mov_s r14,r0
L_8f8ef4:
	bl.d L_8c1cd8
L_8f8ef8:
	mov_s r1,0x4
L_8f8efa:
	stb_s r13,[r14]
L_8f8efc:
	mov_s r1,0x100d534
L_8f8f02:
	mov_s r0,0x2b
L_8f8f04:
	bl.d L_8dcc10
L_8f8f08:
	mov_s r2,r13
L_8f8f0a:
	mov_s r0,r14
L_8f8f0c:
	mov_s r1,0x1865
L_8f8f12:
	mov_s r2,0x4
L_8f8f14:
	mov_s r3,r15
L_8f8f16:
	mov r4,0x0
L_8f8f1a:
	mov r5,r4
L_8f8f1e:
	bl.d L_8e5474
L_8f8f22:
	mov r6,r4
L_8f8f26:
	b L_8c024c
L_8f8f2a:
	nop_s
L_8f8f2c:
	mov_s r3,0x0
L_8f8f2e:
	st_s r3,[r0,0x4]
L_8f8f30:
	st_s r3,[r0,0x8]
L_8f8f32:
	mov_s r1,0x1
L_8f8f34:
	stw_s r1,[r0,0xc]
L_8f8f36:
	st_s r2,[r0,0x10]
L_8f8f38:
	st_s r3,[r0,0x14]
L_8f8f3a:
	st_s r3,[r0,0x18]
L_8f8f3c:
	st_s r3,[r0,0x1c]
L_8f8f3e:
	j_s.d [blink]
L_8f8f40:
	stw_s r3,[r0,0xe]
L_8f8f42:
	nop_s
