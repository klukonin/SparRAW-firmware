/* ps_sm_801bec__on_ps_disable_in_ps_reenter @ 0x8e1308, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps_nonassoc__shallow_sleep_enter
 * Зовёт сам: basic_sm__handle_event, fw_sysassert_fatal, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_sm_801bec__on_ps_disable_in_ps_reenter
ps_sm_801bec__on_ps_disable_in_ps_reenter:
	.global L_8e1308
L_8e1308:
	push_s blink
L_8e130a:
	ld_s r0,[gp,-0x60]
L_8e130c:
	breq_s r0,0,L_8e131a
L_8e130e:
	bl L_8c8de0
L_8e1312:
	mov_s r0,0x0
L_8e1314:
	st.as r0,[gp,-0x18]
L_8e1318:
	b_s L_8e1326
	.global L_8e131a
L_8e131a:
	mov_s r0,blink
L_8e131c:
	mov_s r1,0x2110
L_8e1322:
	bl L_8c9b28
	.global L_8e1326
L_8e1326:
	pop_s blink
L_8e1328:
	j_s [blink]
L_8e132a:
	nop_s
L_8e132c:
	mov_s r1,0x1
L_8e132e:
	mov_s r2,r0
L_8e1330:
	mov_s r3,0x0
L_8e1332:
	b.d L_8d9b6c
L_8e1336:
	mov_s r4,r3
L_8e1338:
	add_s r0,r0,0xc
L_8e133a:
	ld_s r1,[r0,0x8]
L_8e133c:
	ld_s r1,[r1,0x8]
L_8e133e:
	j_s [r1]
L_8e1340:
	mov_s r1,0x1
L_8e1342:
	mov_s r2,r0
L_8e1344:
	mov_s r3,0x0
L_8e1346:
	b.d L_8d9b6c
L_8e134a:
	mov_s r4,r3
L_8e134c:
	add_s r0,r0,0xc
L_8e134e:
	ld_s r1,[r0,0x8]
L_8e1350:
	ld_s r1,[r1,0x8]
L_8e1352:
	j_s [r1]
