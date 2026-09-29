/* channels_switch_sm__action_allocate_radio @ 0x8e8f4c, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::action_allocate_radio()
 * Зовёт сам: RADIO_MGR__lock_secondary, __ld_r13_ret, discovery__rx_start, fw_log__emit0, u_schd__schedule
 * Глобалы (через gp): 0x80045c, 0x800460
 */
	.section .text.channels_switch_sm__action_allocate_radio,"ax",@progbits
	.global channels_switch_sm__action_allocate_radio
channels_switch_sm__action_allocate_radio:
L_8e8f4c:
	st_s r1,[r0,0x70]
	.global fwlog_channels_switch_sm_action_allocate_radio
fwlog_channels_switch_sm_action_allocate_radio:
L_8e8f4e:
	nop_s
L_8e8f50:
	push_s blink
L_8e8f52:
	push_s r13
L_8e8f54:
	mov_s r13,r0
L_8e8f56:
	mov_s r2,0x1014154
L_8e8f5c:
	mov_s r0,0x9
L_8e8f5e:
	bl.d L_8edfb0
L_8e8f62:
	mov_s r1,0x2
L_8e8f64:
	ld_s r2,[r13,0x2c]
L_8e8f66:
	ld_s r1,[r2,0x6c]
L_8e8f68:
	mov_s r0,0x0
L_8e8f6a:
	brne r1,0x3,L_8e8f78
L_8e8f6e:
	ldb r1,[r2, 0x8d]
L_8e8f72:
	cmp_s r1,0x1
L_8e8f74:
	mov.eq r0,0x1
	.global L_8e8f78
L_8e8f78:
	extb.f 0x0,r0
L_8e8f7c:
	mov_s r0,0x1
L_8e8f7e:
	bl.d L_8efd74
L_8e8f82:
	sub.eq r0,r0,r0
L_8e8f86:
	ld_s r0,[r13,0x44]
L_8e8f88:
	mov_s r1,r13
L_8e8f8a:
	ldb r4,[r0, 0x10]
L_8e8f8e:
	mov_s r0,0x2fc10
L_8e8f94:
	mov_s r3,0xffff
L_8e8f9a:
	bl.d L_8d938c
L_8e8f9e:
	mov_s r2,0x0
L_8e8fa0:
	st_s r0,[r13,0x30]
L_8e8fa2:
	mov_s r0,0x3010c
L_8e8fa8:
	ld.as r4,[gp,0xbb]
L_8e8fac:
	mov_s r1,r13
L_8e8fae:
	mov_s r2,0x0
L_8e8fb0:
	mov_s r3,0x1
L_8e8fb2:
	mov_s r5,r2
L_8e8fb4:
	bl.d L_8dc92c
L_8e8fb8:
	mov_s r6,r2
L_8e8fba:
	st_s r0,[r13,0x34]
L_8e8fbc:
	mov_s r0,0x30184
L_8e8fc2:
	ld.as r4,[gp,0xbc]
L_8e8fc6:
	mov_s r1,r13
L_8e8fc8:
	mov_s r2,0x0
L_8e8fca:
	mov_s r3,0x1
L_8e8fcc:
	mov_s r5,r2
L_8e8fce:
	bl.d L_8dc92c
L_8e8fd2:
	mov_s r6,r2
L_8e8fd4:
	b.d L_8c033c
