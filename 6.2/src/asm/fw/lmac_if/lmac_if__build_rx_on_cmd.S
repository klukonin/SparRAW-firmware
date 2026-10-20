/* lmac_if__build_rx_on_cmd @ 0x8dbcdc, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if_send_cmd_0x01
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, lmac_cmd__fill_rx_on_fields, rf_cfg__get_rf_mask_45e
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__build_rx_on_cmd
lmac_if__build_rx_on_cmd:
	.global L_8dbcdc
L_8dbcdc:
	sub_s sp,sp,0x8
L_8dbcde:
	push_s blink
L_8dbce0:
	bl.d L_8c01e4
L_8dbce4:
	mov_s r7,r1
L_8dbce6:
	mov_s r6,r2
L_8dbce8:
	mov_s r13,r0
L_8dbcea:
	asl r1,r3,0xa
L_8dbcee:
	mov_s r2,r7
L_8dbcf0:
	bl.d L_8dc25c
L_8dbcf4:
	mov_s r3,r6
L_8dbcf6:
	mov_s r0,0x1
L_8dbcf8:
	st.a r0,[r13,0x20]
L_8dbcfc:
	mov_s r14,0x8042c8
L_8dbd02:
	bl.d L_8ccb3c
L_8dbd06:
	mov_s r0,r14
L_8dbd08:
	stb_s r0,[r13,0x4]
L_8dbd0a:
	add r14,r14,0x400
L_8dbd0e:
	ld_s r1,[r14,0x68]
L_8dbd10:
	cmp_s r1,0x3
L_8dbd12:
	mov_s r1,0x1
L_8dbd14:
	sub_s.ne r1,r1,r1
L_8dbd16:
	extb.f 0x0,r1
L_8dbd1a:
	ldb r1,[r14, 0x70]
L_8dbd1e:
	stb_s r1,[r13,0x5]
L_8dbd20:
	mov.eq r0,0x0
L_8dbd24:
	stb_s r0,[r13,0x6]
L_8dbd26:
	mov_s r12,0xc
L_8dbd28:
	b L_8c0256
