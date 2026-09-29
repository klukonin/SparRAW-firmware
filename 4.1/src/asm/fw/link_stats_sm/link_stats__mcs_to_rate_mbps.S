/* link_stats__mcs_to_rate_mbps @ 0x8d9e0c, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   link_stats_sm.cpp
 * Зовут его: link_stats__calc_throughput_mbps
 * Зовёт сам: fw_sysassert_fatal
 */
	.section .text.link_stats__mcs_to_rate_mbps,"ax",@progbits
	.global link_stats__mcs_to_rate_mbps
link_stats__mcs_to_rate_mbps:
	.global L_8d9e0c
L_8d9e0c:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8d9e0e:
	brhs.d r0,0xc,L_8d9e6a
L_8d9e12:
	push_s blink
L_8d9e14:
	ldb.x r0,[0x802870,r0]
L_8d9e1c:
	add r1,pcl,0x8
L_8d9e20:
	add1_s r1,r1,r0
L_8d9e22:
	j_s [r1]
L_8d9e24:
	mov r0,0x181
	.global L_8d9e28
L_8d9e28:
	pop_s blink
L_8d9e2a:
	j_s [blink]
L_8d9e2c:
	mov r0,0x302
L_8d9e30:
	b_s L_8d9e28
L_8d9e32:
	mov r0,0x3c2
L_8d9e36:
	b_s L_8d9e28
L_8d9e38:
	mov r0,0x483
L_8d9e3c:
	b_s L_8d9e28
L_8d9e3e:
	mov r0,0x604
L_8d9e42:
	b_s L_8d9e28
L_8d9e44:
	mov r0,0x785
L_8d9e48:
	b_s L_8d9e28
L_8d9e4a:
	mov_s r0,0x906
L_8d9e50:
	b_s L_8d9e28
L_8d9e52:
	mov_s r0,0xc08
L_8d9e58:
	b_s L_8d9e28
L_8d9e5a:
	mov_s r0,0xf0a
L_8d9e60:
	b_s L_8d9e28
L_8d9e62:
	mov_s r0,0x120c
L_8d9e68:
	b_s L_8d9e28
	.global L_8d9e6a
L_8d9e6a:
	mov_s r0,blink
L_8d9e6c:
	mov_s r2,0x1011b18
L_8d9e72:
	mov_s r1,0x125c
L_8d9e78:
	bl.d L_8c82c0
L_8d9e7c:
	mov r3,0x24d
L_8d9e80:
	mov_s r0,0x0
L_8d9e82:
	b_s L_8d9e28
