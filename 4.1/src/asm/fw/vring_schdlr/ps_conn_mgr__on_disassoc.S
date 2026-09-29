/* ps_conn_mgr__on_disassoc @ 0x8c79c4, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps_conn_mgr__dispatch
 * Зовёт сам: PS_CONNECTION__disassoc_ntf
 * Глобалы (через gp): 0x80025c
 */
	.section .text.ps_conn_mgr__on_disassoc,"ax",@progbits
	.global ps_conn_mgr__on_disassoc
ps_conn_mgr__on_disassoc:
L_8c79c4:
	st_s r14,[r13,0x58]
	.global sub_8c79c6
sub_8c79c6:
L_8c79c6:
	nop_s
	.global L_8c79c8
L_8c79c8:
	push_s blink
L_8c79ca:
	mov_s r2,0x0
L_8c79cc:
	ld.as r1,[gp,0x3b]
L_8c79d0:
	bset r2,r2,r0
L_8c79d4:
	tst_s r1,r2
L_8c79d6:
	beq_s L_8c79ee
L_8c79d8:
	mul64 r0,0xf4
L_8c79dc:
	bic_s r1,r1,r2
L_8c79de:
	add r0,mlo,0x80361c
L_8c79e6:
	bl.d L_8c7990
L_8c79ea:
	st.as r1,[gp,0x3b]
	.global L_8c79ee
L_8c79ee:
	pop_s blink
