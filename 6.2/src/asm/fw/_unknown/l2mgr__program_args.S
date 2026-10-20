/* l2mgr__program_args @ 0x8c6c04, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__program_assoc_vring, vring__configure_tx
 * Зовёт сам: __ld_r13_to_r13_ret, qh__write_or_conn_alloc, tx_dma__build_desc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__program_args
l2mgr__program_args:
	.global L_8c6c04
L_8c6c04:
	push_s blink
L_8c6c06:
	push_s r13
L_8c6c08:
	sub_s sp,sp,0x70
L_8c6c0a:
	mov_s r13,r0
L_8c6c0c:
	mov r6,r4
L_8c6c10:
	add_s r0,sp,0x30
L_8c6c12:
	bl.d L_8ea2f0
L_8c6c16:
	mov r4,0x0
L_8c6c1a:
	mov_s r2,sp
L_8c6c1c:
	ldb_s r0,[r13,0xa]
L_8c6c1e:
	mov_s r1,0x8
L_8c6c20:
	bl.d L_8ea5b0
L_8c6c24:
	mov_s r3,0x0
L_8c6c26:
	b.d L_8c025c
L_8c6c2a:
	add_s sp,sp,0x70
