/* sw_vring__set_ba_params @ 0x8c60fc, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__setup_bcast_vring, tx_macq__setup
 * Зовёт сам: __ld_r13_ret, sw_vring__setup_ba_win
 */
	.section .text.sw_vring__set_ba_params,"ax",@progbits
	.global sw_vring__set_ba_params
sw_vring__set_ba_params:
	.global L_8c60fc
L_8c60fc:
	push_s blink
L_8c60fe:
	push_s r13
L_8c6100:
	stb_s r1,[r0,0x3]
L_8c6102:
	stb_s r3,[r0,0x5]
L_8c6104:
	bmsk r13,r2,0x0
L_8c6108:
	ldw_s r3,[r0,0x4]
L_8c610a:
	asl_s r13,r13
L_8c610c:
	bclr_s r3,r3,0x1
L_8c610e:
	or_s r3,r3,r13
L_8c6110:
	stw_s r3,[r0,0x4]
L_8c6112:
	bl.d L_8c6cdc
L_8c6116:
	ldb_s r3,[r0,0x5]
L_8c6118:
	b L_8c033c
