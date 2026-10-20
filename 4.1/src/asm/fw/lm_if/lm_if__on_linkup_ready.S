/* lm_if__on_linkup_ready @ 0x8d7d1c, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lm_if.cpp
 * Зовут его: linkup__check_pcp_assoc_ready
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_read_timer, fw_sysassert_fatal, get_reg_880a3c_8d7210, lm__notify_linkup
 */
	.section .text.lm_if__on_linkup_ready,"ax",@progbits
	.global lm_if__on_linkup_ready
lm_if__on_linkup_ready:
	.global L_8d7d1c
L_8d7d1c:
	push_s blink
L_8d7d1e:
	push_s r13
L_8d7d20:
	bl.d L_8d7210
L_8d7d24:
	mov_s r13,r0
L_8d7d26:
	breq_s r0,0,L_8d7d32
L_8d7d28:
	mov_s r0,r13
L_8d7d2a:
	bl.d L_8d7d0c
L_8d7d2e:
	mov_s r1,0x0
L_8d7d30:
	b_s L_8d7d74
	.global L_8d7d32
L_8d7d32:
	ld_s r0,[r13]
L_8d7d34:
	breq_s r0,0,L_8d7d50
	.global L_8d7d36
L_8d7d36:
	bl L_8e4694
L_8d7d3a:
	ld_s r1,[r13,0x8]
L_8d7d3c:
	sub_s r0,r0,r1
L_8d7d3e:
	cmp r0,0x7d0
L_8d7d42:
	ld_s r1,[r13]
L_8d7d44:
	bhs_s L_8d7d66
L_8d7d46:
	add r2,r13,0xc
L_8d7d4a:
	mov_s r0,r1
L_8d7d4c:
	mov_s r1,0x0
L_8d7d4e:
	b_s L_8d7d6c
	.global L_8d7d50
L_8d7d50:
	mov_s r0,blink
L_8d7d52:
	mov_s r2,0x1010e10
L_8d7d58:
	mov_s r1,0x125f
L_8d7d5e:
	bl.d L_8c82c0
L_8d7d62:
	mov_s r3,0x80
L_8d7d64:
	b_s L_8d7d36
	.global L_8d7d66
L_8d7d66:
	mov_s r0,r1
L_8d7d68:
	mov_s r1,0x0
L_8d7d6a:
	mov_s r2,r1
	.global L_8d7d6c
L_8d7d6c:
	mov_s r3,0x0
L_8d7d6e:
	bl.d L_8d6a1c
L_8d7d72:
	mov_s r4,r3
	.global L_8d7d74
L_8d7d74:
	b L_8c033c
