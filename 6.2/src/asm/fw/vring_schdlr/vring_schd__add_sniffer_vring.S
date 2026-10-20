/* vring_schd__add_sniffer_vring @ 0x8c2c14, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: disc_sm__sw_data_stopped
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal, wmi_evt__init_desc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_schd__add_sniffer_vring
vring_schd__add_sniffer_vring:
	.global L_8c2c14
L_8c2c14:
	push_s blink
L_8c2c16:
	bl L_8c01d8
L_8c2c1a:
	mov_s r13,r0
L_8c2c1c:
	mov_s r17,r1
L_8c2c1e:
	mov_s r1,0x804e3c
L_8c2c24:
	ld_s r0,[r1,0x20]
L_8c2c26:
	mov_s r14,0x804dbc
L_8c2c2c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c2c2e:
	mov_s r16,r2
L_8c2c30:
	brhs.d r0,0x3,L_8c2c4e
L_8c2c34:
	st_s r0,[r1,0x20]
	.global L_8c2c36
L_8c2c36:
	mul64 r13,0x3c
L_8c2c3a:
	add r0,r14,0x28
L_8c2c3e:
	extw_s r1,r13
L_8c2c40:
	mov_s r2,r17
L_8c2c42:
	add_s r0,r0,mlo
L_8c2c44:
	bl.d L_8d9174
L_8c2c48:
	mov_s r3,r16
L_8c2c4a:
	b L_8c023c
	.global L_8c2c4e
L_8c2c4e:
	mov_s r0,blink
L_8c2c50:
	mov_s r1,0x12b5
L_8c2c56:
	bl L_8c9b28
L_8c2c5a:
	b_s L_8c2c36
