/* sw_vring__ba_params @ 0x8eabc8, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sw_vring__ba_agreed
 * Зовёт сам: __ld_r13_to_r13_ret, bits__set32_s0_w12, qh__write_or_conn_alloc, stream_params__copy_hdr
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sw_vring__ba_params
sw_vring__ba_params:
	.global L_8eabc8
L_8eabc8:
	push_s blink
L_8eabca:
	push_s r13
L_8eabcc:
	sub_s sp,sp,0x70
L_8eabce:
	mov_s r13,r0
L_8eabd0:
	bl.d L_8cc19c
L_8eabd4:
	mov_s r1,sp
L_8eabd6:
	ldw_s r1,[r13,0x6]
L_8eabd8:
	add_s r0,sp,0x8
L_8eabda:
	add.f r1,r1,0x7
L_8eabde:
	add.mi r1,r1,0x7
L_8eabe2:
	/* asr_s r1,r1,0x3 */
	.byte 0x43,0xb9
L_8eabe4:
	bmsk_s r1,r1,0xb
L_8eabe6:
	bl.d L_8ed340
L_8eabea:
	mov_s r2,sp
L_8eabec:
	ldb_s r0,[r13,0xa]
L_8eabee:
	mov_s r1,0x20
L_8eabf0:
	bl.d L_8ea5b0
L_8eabf4:
	mov_s r3,0x0
L_8eabf6:
	b.d L_8c025c
L_8eabfa:
	add_s sp,sp,0x70
