/* cnt_handler__clear_all @ 0x8d99e0, 232 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   cnt_handler.c
 * Зовут его: WBE_DRIVER__pcie_boot_init, l2mgr__disconnect_done
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 * Глобалы (через gp): 0x8003b8
 */
	.section .text.cnt_handler__clear_all,"ax",@progbits
	.global cnt_handler__clear_all
cnt_handler__clear_all:
	.global L_8d99e0
L_8d99e0:
	push_s blink
L_8d99e2:
	push_s r13
L_8d99e4:
	mov r2,0x3e8
L_8d99e8:
	mov_s r1,0x7b
L_8d99ea:
	mov_s r13,0x887000
L_8d99f0:
	st 0x3d8000,[r13, 0x8]
L_8d99f8:
	mov lp_count,0x3e9
L_8d99fc:
	asl_s r1,r1,0xf
L_8d99fe:
	lp L_8d9a10
L_8d9a02:
	ld_s r3,[r13,0x8]
L_8d9a04:
	bbit0 r3,0x1e,L_8d9a0e
L_8d9a08:
	ld_s r3,[r13,0x8]
L_8d9a0a:
	bbit1 r3,0x1f,L_8d9a10
	.global L_8d9a0e
L_8d9a0e:
	/* sub_s r2,r2,0x1 */
	.byte 0x61,0xba
	.global L_8d9a10
L_8d9a10:
	brne_s r2,0,L_8d9a38
L_8d9a12:
	ld_s r0,[gp,0x248]
L_8d9a14:
	mov lp_count,0x3e9
L_8d9a18:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8d9a1a:
	st.as r0,[gp,0x92]
L_8d9a1e:
	mov r0,0x3e8
L_8d9a22:
	st_s r1,[r13,0x8]
L_8d9a24:
	lp L_8d9a36
L_8d9a28:
	ld_s r2,[r13,0x8]
L_8d9a2a:
	bbit0 r2,0x1e,L_8d9a34
L_8d9a2e:
	ld_s r2,[r13,0x8]
L_8d9a30:
	bbit1 r2,0x1f,L_8d9a36
	.global L_8d9a34
L_8d9a34:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
	.global L_8d9a36
L_8d9a36:
	breq_s r0,0,L_8d9a84
	.global L_8d9a38
L_8d9a38:
	st 0x2a4000,[r13, 0x8]
L_8d9a40:
	mov lp_count,0x2711
L_8d9a48:
	mov_s r1,0x2710
L_8d9a4e:
	lp L_8d9a5a
L_8d9a52:
	ld_s r2,[r13,0x8]
L_8d9a54:
	bbit1 r2,0x1f,L_8d9a5a
L_8d9a58:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
	.global L_8d9a5a
L_8d9a5a:
	breq_s r1,0,L_8d9a9a
	.global L_8d9a5c
L_8d9a5c:
	st 0x1a2000,[r13, 0x8]
L_8d9a64:
	mov lp_count,0x2711
L_8d9a6c:
	mov_s r0,0x2710
L_8d9a72:
	lp L_8d9a7e
L_8d9a76:
	ld_s r2,[r13,0x8]
L_8d9a78:
	bbit1 r2,0x1e,L_8d9a7e
L_8d9a7c:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
	.global L_8d9a7e
L_8d9a7e:
	breq_s r0,0,L_8d9ab0
	.global L_8d9a80
L_8d9a80:
	b L_8c033c
	.global L_8d9a84
L_8d9a84:
	mov_s r0,blink
L_8d9a86:
	mov_s r2,0x1001508
L_8d9a8c:
	mov_s r1,0x1187
L_8d9a92:
	bl.d L_8c82c0
L_8d9a96:
	mov_s r3,0x50
L_8d9a98:
	b_s L_8d9a38
	.global L_8d9a9a
L_8d9a9a:
	mov_s r0,blink
L_8d9a9c:
	mov_s r2,0x1001508
L_8d9aa2:
	mov_s r1,0x1188
L_8d9aa8:
	bl.d L_8c82c0
L_8d9aac:
	mov_s r3,0x5f
L_8d9aae:
	b_s L_8d9a5c
	.global L_8d9ab0
L_8d9ab0:
	mov_s r0,blink
L_8d9ab2:
	mov_s r2,0x1001508
L_8d9ab8:
	mov_s r1,0x1189
L_8d9abe:
	bl.d L_8c82c0
L_8d9ac2:
	mov_s r3,0x6d
L_8d9ac4:
	b_s L_8d9a80
L_8d9ac6:
	nop_s
