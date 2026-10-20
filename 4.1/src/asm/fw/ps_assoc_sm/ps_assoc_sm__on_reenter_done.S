/* ps_assoc_sm__on_reenter_done @ 0x8dd32c, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ps_assoc_sm.cpp
 * Зовут его: ps_conn_mgr__dispatch
 * Зовёт сам: basic_sm__inject_event, fw_sysassert_fatal
 */
	.section .text.ps_assoc_sm__on_reenter_done,"ax",@progbits
	.global ps_assoc_sm__on_reenter_done
ps_assoc_sm__on_reenter_done:
	.global L_8dd32c
L_8dd32c:
	j_s [blink]
	.global sub_8dd32e
sub_8dd32e:
L_8dd32e:
	nop_s
L_8dd330:
	ld.as r1,[gp,-0x14]
L_8dd334:
	/* breq_s r1,0,0x008dd364 */
	.byte 0x18,0xe9
L_8dd336:
	mov_s r1,0x0
L_8dd338:
	ldb_s r2,[r0]
L_8dd33a:
	st.as r1,[gp,-0x14]
L_8dd33e:
	cmp_s r2,0x3
L_8dd340:
	mov.eq r2,r0
L_8dd344:
	mov.eq r3,r1
L_8dd348:
	beq.d L_8d6a1c
L_8dd34c:
	mov.eq r4,r1
L_8dd350:
	mov_s r0,blink
L_8dd352:
	mov_s r2,0x10026ec
L_8dd358:
	mov_s r1,0x2112
L_8dd35e:
	b.d L_8c82c0
L_8dd362:
	mov_s r3,0xf0
