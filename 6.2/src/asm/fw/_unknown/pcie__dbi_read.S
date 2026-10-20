/* pcie__dbi_read @ 0x8c8208, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_pcie_config_lnkctl, hwd_pcie_l1_pm_sub_ctl_get, hwd_pcie_l1_sub_timing_config, pcie__fix_max_read_req, pcie__force_clear_l0s, pcie__l1_latency_wa
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, hwd_pcie__read_882650, pcie__ack__8e026c, pcie__dbi_set_addr, pcie__dbi_start_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__dbi_read
pcie__dbi_read:
	.global L_8c8208
L_8c8208:
	push_s blink
L_8c820a:
	bl L_8c01d0
L_8c820e:
	mov_s r14,r1
L_8c8210:
	mov_s r16,r2
L_8c8212:
	mov_s r15,r3
L_8c8214:
	mov r17,r4
L_8c8218:
	mov r19,r5
L_8c821c:
	mov r18,r6
L_8c8220:
	bl.d L_8d1220
L_8c8224:
	mov_s r13,0x0
L_8c8226:
	brne_s r15,0,L_8c823a
L_8c8228:
	brne r16,0x0,L_8c8240
L_8c822c:
	breq_s r14,0,L_8c823a
L_8c822e:
	breq r14,0x1,L_8c823e
L_8c8232:
	brne r14,0x2,L_8c8284
L_8c8236:
	mov_s r13,0x4
L_8c8238:
	b_s L_8c8240
	.global L_8c823a
L_8c823a:
	mov_s r13,0x1
L_8c823c:
	b_s L_8c8240
	.global L_8c823e
L_8c823e:
	mov_s r13,0x2
	.global L_8c8240
L_8c8240:
	bmsk r1,r13,0x2
L_8c8244:
	bmsk r0,r16,0x0
L_8c8248:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_8c824a:
	or_s r1,r1,r0
L_8c824c:
	bmsk_s r15,r15,0x0
L_8c824e:
	/* asl_s r15,r15,0x4 */
	.byte 0x04,0xbf
L_8c8250:
	or_s r1,r1,r15
L_8c8252:
	bmsk r0,r17,0x1
L_8c8256:
	/* asl_s r0,r0,0x5 */
	.byte 0x05,0xb8
L_8c8258:
	or_s r1,r1,r0
L_8c825a:
	bmsk r0,r19,0x0
L_8c825e:
	asl_s r0,r0,0xb
L_8c8260:
	or_s r1,r1,r0
L_8c8262:
	mov_s r13,0x0
L_8c8264:
	mov_s r0,r13
L_8c8266:
	and r1,r1,0x87f
L_8c826e:
	bl.d L_8d122c
L_8c8272:
	mov_s r2,r13
L_8c8274:
	bl L_8e026c
L_8c8278:
	breq_s r0,0,L_8c8284
L_8c827a:
	bl.d L_8d1458
L_8c827e:
	mov_s r13,0x1
L_8c8280:
	st r0,[r18]
	.global L_8c8284
L_8c8284:
	b.d L_8c022c
L_8c8288:
	mov_s r0,r13
L_8c828a:
	nop_s
