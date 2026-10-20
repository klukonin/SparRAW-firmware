/* l2_mgr__has_active_pcp @ 0x8da47c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__pcp_stop, l2_mgr__send_pcp_start_status_evt
 * Глобалы (через gp): 0x80025a
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__has_active_pcp
l2_mgr__has_active_pcp:
	.global L_8da47c
L_8da47c:
	ldb_s r0,[gp,0xd6]
L_8da47e:
	cmp_s r0,0x0
L_8da480:
	mov_s r0,0x1
L_8da482:
	j_s.d [blink]
L_8da484:
	sub.le r0,r0,r0
