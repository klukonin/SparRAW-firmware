/* phy__power_up_and_wait_ack @ 0x8cf1b8, 236 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 *   hw_drivers_phy.c
 *   hwd_phy_pwr ON: phy_tx_power_ack =%d,phy_rx_power_ack = %d,phy_ldpc_power_ack=%d
 * Зовут его: hwd_phy__power_up_seq
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit0, fw_log__emit3, fw_sysassert_fatal
 */
	.section .text.phy__power_up_and_wait_ack,"ax",@progbits
	.global phy__power_up_and_wait_ack
phy__power_up_and_wait_ack:
	.global L_8cf1b8
L_8cf1b8:
	push_s blink
L_8cf1ba:
	bl L_8c02b8
L_8cf1be:
	bclr.f r14,r0,0x0
L_8cf1c2:
	mov_s r13,r0
L_8cf1c4:
	bne_s L_8cf268
	.global L_8cf1c6
L_8cf1c6:
	brne r14,0x0,L_8cf27c
	.global L_8cf1ca
L_8cf1ca:
	brne r14,0x0,L_8cf290
	.global L_8cf1ce
L_8cf1ce:
	mov_s r1,0x880c00
L_8cf1d4:
	ld_s r0,[r1,0x78]
L_8cf1d6:
	asl_s r2,r13
L_8cf1d8:
	bclr_s r0,r0,0x0
L_8cf1da:
	or_s r0,r0,r13
L_8cf1dc:
	bclr_s r0,r0,0x1
L_8cf1de:
	or_s r2,r2,r0
L_8cf1e0:
	bclr_s r2,r2,0x2
L_8cf1e2:
	asl_s r0,r13,0x2
L_8cf1e4:
	or_s r0,r0,r2
L_8cf1e6:
	st_s r0,[r1,0x78]
L_8cf1e8:
	mov lp_count,0xc8
L_8cf1ec:
	lp L_8cf210
L_8cf1f0:
	ld_s r2,[r1,0x7c]
L_8cf1f2:
	bmsk r14,r2,0x0
L_8cf1f6:
	lsr_s r15,r2
L_8cf1f8:
	lsr_s r2,r2,0x2
L_8cf1fa:
	bmsk r16,r15,0x0
L_8cf1fe:
	bmsk r17,r2,0x0
L_8cf202:
	cmp_s r13,r14
L_8cf204:
	cmp.eq r13,r16
L_8cf208:
	cmp.eq r13,r17
L_8cf20c:
	beq_s L_8cf210
L_8cf20e:
	nop_s
	.global L_8cf210
L_8cf210:
	cmp_s r13,r14
L_8cf212:
	cmp.eq r13,r16
L_8cf216:
	cmp.eq r13,r17
L_8cf21a:
	beq_s L_8cf240
L_8cf21c:
	mov_s r2,0x10186dc
L_8cf222:
	mov_s r0,0x0
L_8cf224:
	bl.d L_8edfb0
L_8cf228:
	mov_s r1,r0
L_8cf22a:
	mov_s r0,blink
L_8cf22c:
	mov_s r2,0x1018690
L_8cf232:
	mov_s r1,0x1334
L_8cf238:
	bl.d L_8c82c0
L_8cf23c:
	mov r3,0x5cf
	.global L_8cf240
L_8cf240:
	cmp_s r13,r14
L_8cf242:
	cmp.eq r13,r17
L_8cf246:
	cmp.eq r13,r16
L_8cf24a:
	beq_s L_8cf264
L_8cf24c:
	mov_s r2,0x10187ec
L_8cf252:
	mov_s r0,0x1
L_8cf254:
	mov_s r1,0x0
L_8cf256:
	mov_s r3,r14
L_8cf258:
	mov r4,r16
L_8cf25c:
	bl.d L_8ee034
L_8cf260:
	mov r5,r17
	.global L_8cf264
L_8cf264:
	b L_8c031c
	.global L_8cf268
L_8cf268:
	mov_s r0,blink
L_8cf26a:
	mov_s r2,0x1018690
L_8cf270:
	mov_s r1,0xaf
L_8cf272:
	bl.d L_8c82c0
L_8cf276:
	mov r3,0x5c2
L_8cf27a:
	b_s L_8cf1c6
	.global L_8cf27c
L_8cf27c:
	mov_s r0,blink
L_8cf27e:
	mov_s r2,0x1018690
L_8cf284:
	mov_s r1,0xb0
L_8cf286:
	bl.d L_8c82c0
L_8cf28a:
	mov r3,0x5c2
L_8cf28e:
	b_s L_8cf1ca
	.global L_8cf290
L_8cf290:
	mov_s r0,blink
L_8cf292:
	mov_s r2,0x1018690
L_8cf298:
	mov_s r1,0xb1
L_8cf29a:
	bl.d L_8c82c0
L_8cf29e:
	mov r3,0x5c2
L_8cf2a2:
	b_s L_8cf1ce
