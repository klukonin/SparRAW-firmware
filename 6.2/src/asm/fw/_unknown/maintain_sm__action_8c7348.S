/* maintain_sm__action_8c7348 @ 0x8c7348, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: conn__get_cid_via_field8, conn_mgr__by_cid, fw_sysassert_fatal
 * Глобалы (через gp): 0x8002e8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global maintain_sm__action_8c7348
maintain_sm__action_8c7348:
	.global L_8c7348
L_8c7348:
	push_s blink
L_8c734a:
	ld.as r1,[gp,0x59]
L_8c734e:
	breq_s r1,0,L_8c735a
L_8c7350:
	bl L_8cbec0
L_8c7354:
	bl L_8cbffc
L_8c7358:
	breq_s r0,0,L_8c735e
	.global L_8c735a
L_8c735a:
	pop_s blink
L_8c735c:
	j_s [blink]
	.global L_8c735e
L_8c735e:
	mov_s r0,blink
L_8c7360:
	mov_s r1,0x126b
L_8c7366:
	bl L_8c9b28
L_8c736a:
	b_s L_8c735a
