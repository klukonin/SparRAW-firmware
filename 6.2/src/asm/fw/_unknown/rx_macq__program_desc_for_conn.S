/* rx_macq__program_desc_for_conn @ 0x8e7690, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_main_sm__action_8e7a3c
 * Зовёт сам: rx_macq__program_desc_848018
 * Глобалы (через gp): 0x800478
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_macq__program_desc_for_conn
rx_macq__program_desc_for_conn:
	.global L_8e7690
L_8e7690:
	mov_s r1,r0
L_8e7692:
	ld_s r0,[gp,0x2f4]
L_8e7694:
	cmp_s r0,0x0
L_8e7696:
	mov.ne r0,0x1
L_8e769a:
	neg_s r2,r0
L_8e769c:
	add r0,r1,0x1c
L_8e76a0:
	ldb_s r1,[r1,0x8]
L_8e76a2:
	b.d L_8df968
L_8e76a6:
	bmsk_s r2,r2,0x4
