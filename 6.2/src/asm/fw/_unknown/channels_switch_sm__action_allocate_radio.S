/* channels_switch_sm__action_allocate_radio @ 0x8c20b8, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::action_allocate_radio()
 * Зовёт сам: __ld_r13_to_r13_ret, discovery__rx_start, fw_log_emit0, radio_mgr__request, u_schd__schedule
 * Глобалы (через gp): 0x800484, 0x800488
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global channels_switch_sm__action_allocate_radio
channels_switch_sm__action_allocate_radio:
	.global L_8c20b8
L_8c20b8:
	push_s blink
L_8c20ba:
	push_s r13
L_8c20bc:
	mov_s r13,r0
L_8c20be:
	mov_s r1,0x101723c
L_8c20c4:
	bl.d L_8dcba8
L_8c20c8:
	mov_s r0,0x29
L_8c20ca:
	ld_s r2,[r13,0x8]
L_8c20cc:
	ld_s r1,[r2,0x6c]
L_8c20ce:
	mov_s r0,0x0
L_8c20d0:
	brne r1,0x3,L_8c20e2
L_8c20d4:
	ldb r1,[r2,0x216]
L_8c20dc:
	cmp_s r1,0x1
L_8c20de:
	mov.eq r0,0x1
	.global L_8c20e2
L_8c20e2:
	extb.f 0x0,r0
L_8c20e6:
	mov_s r0,0x1
L_8c20e8:
	bl.d L_8f80b8
L_8c20ec:
	sub.eq r0,r0,r0
L_8c20f0:
	ld_s r0,[r13,0x20]
L_8c20f2:
	mov_s r1,r13
L_8c20f4:
	ldb r4,[r0, 0x10]
L_8c20f8:
	mov_s r0,0x220b8
L_8c20fe:
	mov_s r3,0xffff
L_8c2104:
	bl.d L_8dcaf4
L_8c2108:
	mov_s r2,0x0
L_8c210a:
	st_s r0,[r13,0xc]
L_8c210c:
	mov_s r0,0x24698
L_8c2112:
	ld.as r4,[gp,0xc0]
L_8c2116:
	mov_s r1,r13
L_8c2118:
	mov_s r2,0x0
L_8c211a:
	mov_s r3,0x1
L_8c211c:
	mov_s r5,r2
L_8c211e:
	bl.d L_8e0c0c
L_8c2122:
	mov_s r6,r2
L_8c2124:
	st_s r0,[r13,0x10]
L_8c2126:
	mov_s r0,0x246c0
L_8c212c:
	ld.as r4,[gp,0xc1]
L_8c2130:
	mov_s r1,r13
L_8c2132:
	mov_s r2,0x0
L_8c2134:
	mov_s r3,0x1
L_8c2136:
	mov_s r5,r2
L_8c2138:
	bl.d L_8e0c0c
L_8c213c:
	mov_s r6,r2
L_8c213e:
	b.d L_8c025c
L_8c2142:
	st_s r0,[r13,0x18]
