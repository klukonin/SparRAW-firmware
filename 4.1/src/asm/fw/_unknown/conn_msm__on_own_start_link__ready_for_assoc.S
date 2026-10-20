/* conn_msm__on_own_start_link__ready_for_assoc @ 0x8de71c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_msm__on_own_start_link__unresourced
 * Зовёт сам: basic_sm__store_pending_event, conn_msm__rearm_assoc_timer
 * Глобалы (через gp): 0x8002f0
 */
	.section .text.conn_msm__on_own_start_link__ready_for_assoc,"ax",@progbits
	.global conn_msm__on_own_start_link__ready_for_assoc
conn_msm__on_own_start_link__ready_for_assoc:
	.global L_8de71c
L_8de71c:
	push_s blink
L_8de71e:
	ld.as r1,[gp,0x60]
L_8de722:
	brne_s r1,0,L_8de726
L_8de724:
	brne_s r2,0,L_8de734
	.global L_8de726
L_8de726:
	mov_s r1,0x1
L_8de728:
	mov_s r2,r1
L_8de72a:
	mov_s r3,0x0
L_8de72c:
	bl.d L_8e20c0
L_8de730:
	mov_s r4,r3
L_8de732:
	b_s L_8de738
	.global L_8de734
L_8de734:
	bl L_8e15a8
	.global L_8de738
L_8de738:
	pop_s blink
L_8de73a:
	j_s [blink]
