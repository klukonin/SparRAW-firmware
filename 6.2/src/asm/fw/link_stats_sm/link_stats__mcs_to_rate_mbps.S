/* link_stats__mcs_to_rate_mbps @ 0x8ddd50, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_stats__calc_throughput_mbps
 * Зовёт сам: fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_stats__mcs_to_rate_mbps
link_stats__mcs_to_rate_mbps:
	.global L_8ddd50
L_8ddd50:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8ddd52:
	brhs.d r0,0xc,L_8dddae
L_8ddd56:
	push_s blink
L_8ddd58:
	ldb.x r0,[0x802fa8,r0]
L_8ddd60:
	add r1,pcl,0x8
L_8ddd64:
	add1_s r1,r1,r0
L_8ddd66:
	j_s [r1]
L_8ddd68:
	mov r0,0x181
	.global L_8ddd6c
L_8ddd6c:
	pop_s blink
L_8ddd6e:
	j_s [blink]
L_8ddd70:
	mov r0,0x302
L_8ddd74:
	b_s L_8ddd6c
L_8ddd76:
	mov r0,0x3c2
L_8ddd7a:
	b_s L_8ddd6c
L_8ddd7c:
	mov r0,0x483
L_8ddd80:
	b_s L_8ddd6c
L_8ddd82:
	mov r0,0x604
L_8ddd86:
	b_s L_8ddd6c
L_8ddd88:
	mov r0,0x785
L_8ddd8c:
	b_s L_8ddd6c
L_8ddd8e:
	mov_s r0,0x906
L_8ddd94:
	b_s L_8ddd6c
L_8ddd96:
	mov_s r0,0xc08
L_8ddd9c:
	b_s L_8ddd6c
L_8ddd9e:
	mov_s r0,0xf0a
L_8ddda4:
	b_s L_8ddd6c
L_8ddda6:
	mov_s r0,0x120c
L_8dddac:
	b_s L_8ddd6c
	.global L_8dddae
L_8dddae:
	mov_s r0,blink
L_8dddb0:
	mov_s r1,0x125c
L_8dddb6:
	bl L_8c9b28
L_8dddba:
	mov_s r0,0x0
L_8dddbc:
	b_s L_8ddd6c
L_8dddbe:
	nop_s
