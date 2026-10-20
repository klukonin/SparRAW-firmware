/* maintain_sm__on_consecutive_high_per @ 0x8c63b0, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   maintain_sm.cpp
 * Зовёт сам: conn_mgr__by_cid, fw_sysassert_fatal, link_stats__get_cid
 * Глобалы (через gp): 0x8002d8
 */
	.section .text.maintain_sm__on_consecutive_high_per,"ax",@progbits
	.global maintain_sm__on_consecutive_high_per
maintain_sm__on_consecutive_high_per:
L_8c63b0:
	push_s blink
L_8c63b2:
	ld.as r1,[gp,0x5a]
L_8c63b6:
	breq_s r1,0,L_8c63c2
L_8c63b8:
	bl L_8c9d7c
L_8c63bc:
	bl L_8c9e44
L_8c63c0:
	breq_s r0,0,L_8c63c6
	.global L_8c63c2
L_8c63c2:
	pop_s blink
L_8c63c4:
	j_s [blink]
	.global L_8c63c6
L_8c63c6:
	mov_s r0,blink
L_8c63c8:
	mov_s r2,0x1011d6c
L_8c63ce:
	mov_s r1,0x126b
L_8c63d4:
	bl.d L_8c82c0
L_8c63d8:
	mov r3,0x228
L_8c63dc:
	b_s L_8c63c2
L_8c63de:
	nop_s
