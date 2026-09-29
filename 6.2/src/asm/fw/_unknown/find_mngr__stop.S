/* find_mngr__stop @ 0x8e7efc, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND MNGR: STOP.
 * Зовут его: stop_find_session
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_log_emit0, lmac_if_discovery_mode_cfg_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_mngr__stop
find_mngr__stop:
	.global L_8e7efc
L_8e7efc:
	push_s blink
L_8e7efe:
	push_s r13
L_8e7f00:
	mov_s r13,r0
L_8e7f02:
	mov_s r0,0x0
L_8e7f04:
	bl.d L_8db724
L_8e7f08:
	mov_s r1,r0
L_8e7f0a:
	mov_s r1,0x1017a4c
L_8e7f10:
	bl.d L_8dcba8
L_8e7f14:
	mov_s r0,0x2c
L_8e7f16:
	add r0,r13,0x1c
L_8e7f1a:
	mov_s r1,0x6
L_8e7f1c:
	mov_s r2,0x0
L_8e7f1e:
	mov_s r3,0x0
L_8e7f20:
	bl.d L_8d9b6c
L_8e7f24:
	mov r4,0x0
L_8e7f28:
	b L_8c025c
