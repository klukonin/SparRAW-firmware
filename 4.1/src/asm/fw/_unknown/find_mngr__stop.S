/* find_mngr__stop @ 0x8e2dfc, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND MNGR: STOP.
 * Зовут его: stop_find_session
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_log__emit0, lmac_if_discovery_mode_cfg_handler
 */
	.section .text.find_mngr__stop,"ax",@progbits
	.global find_mngr__stop
find_mngr__stop:
	.global L_8e2dfc
L_8e2dfc:
	push_s blink
L_8e2dfe:
	push_s r13
L_8e2e00:
	mov_s r13,r0
L_8e2e02:
	mov_s r0,0x0
L_8e2e04:
	bl.d L_8d84a8
L_8e2e08:
	mov_s r1,r0
L_8e2e0a:
	mov_s r2,0x1013ffc
L_8e2e10:
	mov_s r0,0xc
L_8e2e12:
	bl.d L_8edfb0
L_8e2e16:
	mov_s r1,0x2
L_8e2e18:
	add r0,r13,0x1c
L_8e2e1c:
	mov_s r1,0x6
L_8e2e1e:
	mov_s r2,0x0
L_8e2e20:
	mov_s r3,0x0
L_8e2e22:
	bl.d L_8d6a1c
L_8e2e26:
	mov r4,0x0
L_8e2e2a:
	b L_8c033c
L_8e2e2e:
	nop_s
