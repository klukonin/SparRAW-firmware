/* rx_chain__configure @ 0x8c44bc, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sw_vring__ba_agreed, wmi_cfg_rx_chain
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, macq_desc__write, rx_chain__build_desc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_chain__configure
rx_chain__configure:
	.global L_8c44bc
L_8c44bc:
	push_s blink
L_8c44be:
	bl.d L_8c01e4
L_8c44c2:
	mov_s r9,r1
L_8c44c4:
	mov_s r14,r0
L_8c44c6:
	mov_s r8,r2
L_8c44c8:
	mov_s r7,r3
L_8c44ca:
	mov r5,r4
L_8c44ce:
	mov_s r13,0x847fe8
L_8c44d4:
	ld r6,[r0, 0x8]
L_8c44d8:
	mov_s r0,r13
L_8c44da:
	ldb_s r1,[r14,0x1]
L_8c44dc:
	mov_s r2,r9
L_8c44de:
	mov_s r3,r8
L_8c44e0:
	bl.d L_8e40d4
L_8c44e4:
	mov r4,r7
L_8c44e8:
	mov_s r0,r13
L_8c44ea:
	ldb_s r1,[r14]
L_8c44ec:
	mov_s r2,0x1
L_8c44ee:
	mov_s r3,0x3
L_8c44f0:
	mov r4,0x0
L_8c44f4:
	mov r5,r4
L_8c44f8:
	mov r6,r4
L_8c44fc:
	bl.d L_8c5010
L_8c4500:
	mov_s r7,r3
L_8c4502:
	b L_8c0254
L_8c4506:
	nop_s
