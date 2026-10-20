/* phy_monitor__on_system_state @ 0x8e889c, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sys_state__broadcast
 * Зовёт сам: __ld_r13_to_r13_ret, detector__arm_timer, fw_sysassert_fatal, periodic_service__start
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global phy_monitor__on_system_state
phy_monitor__on_system_state:
	.global L_8e889c
L_8e889c:
	push_s blink
L_8e889e:
	push_s r13
L_8e88a0:
	brhs.d r1,0x17,L_8e88fc
L_8e88a4:
	mov_s r13,r0
L_8e88a6:
	ldb.x r1,[0x80340c,r1]
L_8e88ae:
	add r0,pcl,0xa
L_8e88b2:
	add1_s r0,r0,r1
L_8e88b4:
	j_s [r0]
L_8e88b6:
	cmp_s r3,0x0
L_8e88b8:
	mov.ne r0,blink
L_8e88bc:
	mov.ne r1,0x1437
L_8e88c4:
	bl.ne L_8c9b28
L_8e88c8:
	b_s L_8e88d8
L_8e88ca:
	cmp_s r3,0x0
L_8e88cc:
	cmp.eq r2,0x1
L_8e88d0:
	bne_s L_8e88d8
L_8e88d2:
	mov_s r0,0x0
L_8e88d4:
	st_s r0,[r13,0x30]
L_8e88d6:
	b_s L_8e88f4
	.global L_8e88d8
L_8e88d8:
	mov_s r0,0x1
L_8e88da:
	st_s r0,[r13,0x30]
L_8e88dc:
	mov_s r0,r13
L_8e88de:
	bl.d L_8e77c4
L_8e88e2:
	mov_s r1,0x0
L_8e88e4:
	b_s L_8e8908
L_8e88e6:
	ld_s r0,[r13,0x30]
L_8e88e8:
	breq_s r0,0,L_8e88f4
L_8e88ea:
	mov_s r0,r13
L_8e88ec:
	bl.d L_8e77c4
L_8e88f0:
	mov_s r1,0x2
L_8e88f2:
	b_s L_8e8908
	.global L_8e88f4
L_8e88f4:
	bl.d L_8e7e8c
L_8e88f8:
	mov_s r0,r13
L_8e88fa:
	b_s L_8e8908
	.global L_8e88fc
L_8e88fc:
	mov_s r0,blink
L_8e88fe:
	mov_s r1,0x1435
L_8e8904:
	bl L_8c9b28
	.global L_8e8908
L_8e8908:
	b L_8c025c
