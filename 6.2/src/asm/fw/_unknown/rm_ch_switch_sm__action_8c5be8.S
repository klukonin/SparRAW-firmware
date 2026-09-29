/* rm_ch_switch_sm__action_8c5be8 @ 0x8c5be8, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, tx_api__pause_for_ch_switch
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_ch_switch_sm__action_8c5be8
rm_ch_switch_sm__action_8c5be8:
	.global L_8c5be8
L_8c5be8:
	push_s blink
L_8c5bea:
	bl L_8c01e4
L_8c5bee:
	mov.f r14,r1
L_8c5bf2:
	mov_s r13,r0
L_8c5bf4:
	beq_s L_8c5c12
	.global L_8c5bf6
L_8c5bf6:
	st 0xffff,[r13, 0x18]
L_8c5bfe:
	mov_s r0,0x0
L_8c5c00:
	st_s r0,[r13,0x10]
L_8c5c02:
	st_s r0,[r13,0x14]
L_8c5c04:
	st_s r14,[r13,0xc]
L_8c5c06:
	mov_s r0,0x5
L_8c5c08:
	bl.d L_8e7f2c
L_8c5c0c:
	st_s r0,[r13,0x10]
L_8c5c0e:
	b L_8c0254
	.global L_8c5c12
L_8c5c12:
	mov_s r0,blink
L_8c5c14:
	mov_s r1,0x116b
L_8c5c1a:
	bl L_8c9b28
L_8c5c1e:
	b_s L_8c5bf6
