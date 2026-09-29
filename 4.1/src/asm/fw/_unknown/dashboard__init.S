/* dashboard__init @ 0x8ed218, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__pcie_boot_init
 * Зовёт сам: __ld_r13_ret, bf_w_s24_w4, memset0_words
 */
	.section .text.dashboard__init,"ax",@progbits
	.global dashboard__init
dashboard__init:
	.global L_8ed218
L_8ed218:
	push_s blink
L_8ed21a:
	push_s r13
L_8ed21c:
	mov_s r13,0x854800
L_8ed222:
	mov_s r0,r13
L_8ed224:
	bl.d L_8c1a78
L_8ed228:
	mov r1,0x65c
L_8ed22c:
	mov_s r0,0x5
L_8ed22e:
	st_s r0,[r13]
L_8ed230:
	mov r0,0x65c
L_8ed234:
	stw_s r0,[r13,0x4]
L_8ed236:
	mov_s r1,0xf
L_8ed238:
	add3 r0,r13,0x1f
L_8ed23c:
	bl L_8e8444
L_8ed240:
	b L_8c033c
