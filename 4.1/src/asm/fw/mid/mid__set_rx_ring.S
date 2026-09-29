/* mid__set_rx_ring @ 0x8e141c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret, rx_pool__set_fields
 */
	.section .text.mid__set_rx_ring,"ax",@progbits
	.global mid__set_rx_ring
mid__set_rx_ring:
L_8e141c:
	st_s r0,[r13,0x14]
	.global sub_8e141e
sub_8e141e:
L_8e141e:
	nop_s
L_8e1420:
	push_s blink
L_8e1422:
	push_s r13
L_8e1424:
	st_s r1,[r0,0x14]
L_8e1426:
	st_s r2,[r0,0x18]
L_8e1428:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8e142a:
	mov_s r1,r3
L_8e142c:
	bl.d L_8d6384
L_8e1430:
	mov_s r2,r4
L_8e1432:
	b L_8c033c
L_8e1436:
	nop_s
