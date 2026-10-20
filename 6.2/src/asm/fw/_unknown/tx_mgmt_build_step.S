/* tx_mgmt_build_step @ 0x8d7df4, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_mgmt_srvs__build_dmg_beacon
 * Зовёт сам: BUILDER_push_dmg_parameters, __ld_r17_to_r13_ret, __st_r17_to_r13, ie__push_awake_window, memset0_words, mgmt_tx__copy_addr_from_conn, mgmt_tx__copy_addr_from_mid, mgmt_tx__set_frame_control, mid__get_aw_len, sw_vring__ba_agreed
 * Глобалы (через gp): 0x8002d4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_mgmt_build_step
tx_mgmt_build_step:
	.global L_8d7df4
L_8d7df4:
	push_s blink
L_8d7df6:
	bl L_8c01d8
L_8d7dfa:
	mov_s r14,r0
L_8d7dfc:
	mov_s r15,r1
L_8d7dfe:
	bl.d L_8c068c
L_8d7e02:
	add3 r16,r1,0x9
L_8d7e06:
	mov_s r13,r0
L_8d7e08:
	add r0,r14,0xa
L_8d7e0c:
	bl.d L_8c1cd8
L_8d7e10:
	mov_s r1,0x8
L_8d7e12:
	ld.as r1,[gp,0x54]
L_8d7e16:
	add_s r13,r13,0xd
L_8d7e18:
	stb_s r1,[r14,0x15]
L_8d7e1a:
	lsr_s r1,r1,0x8
L_8d7e1c:
	stb_s r1,[r14,0x16]
L_8d7e1e:
	add r0,r14,0x17
L_8d7e22:
	bl.d L_8c0678
L_8d7e26:
	mov_s r1,r15
L_8d7e28:
	add_s r13,r13,r0
L_8d7e2a:
	add r0,r14,0x1d
L_8d7e2e:
	bl.d L_8c06d0
L_8d7e32:
	mov_s r1,r15
L_8d7e34:
	add_s r13,r13,r0
L_8d7e36:
	ldb_s r0,[r14,0x17]
L_8d7e38:
	add r17,r14,r13
L_8d7e3c:
	bbit0 r0,0x0,L_8d7e4e
L_8d7e40:
	mov_s r0,r17
L_8d7e42:
	bl.d L_8c0664
L_8d7e46:
	mov_s r1,r15
L_8d7e48:
	add_s r13,r13,r0
L_8d7e4a:
	add r17,r14,r13
	.global L_8d7e4e
L_8d7e4e:
	bl.d L_8c4120
L_8d7e52:
	mov_s r0,r16
L_8d7e54:
	brne_s r0,0,L_8d7e60
L_8d7e56:
	mov_s r0,0x803c00
L_8d7e5c:
	ld_s r0,[r0,0xc]
L_8d7e5e:
	breq_s r0,0,L_8d7e70
	.global L_8d7e60
L_8d7e60:
	bl.d L_8cb914
L_8d7e64:
	mov_s r0,r16
L_8d7e66:
	mov_s r1,r0
L_8d7e68:
	bl.d L_8e1f84
L_8d7e6c:
	mov_s r0,r17
L_8d7e6e:
	add_s r13,r13,r0
	.global L_8d7e70
L_8d7e70:
	b.d L_8c023c
L_8d7e74:
	mov_s r0,r13
L_8d7e76:
	nop_s
