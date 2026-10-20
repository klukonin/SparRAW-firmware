/* hwd_phy__set_881000 @ 0x927014, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: dma_mac_setup_step
 * Зовёт сам: uc_sysassert
 */
	.section .text.hwd_phy__set_881000,"ax",@progbits
	.global hwd_phy__set_881000
hwd_phy__set_881000:
	.global L_927014
L_927014:
	st.a r13,[sp,-0x8]
L_927018:
	st_s r14,[sp,0x4]
L_92701a:
	mov_s r14,blink
L_92701c:
	mov.f r13,r0
L_927020:
	cmp.ne r13,0x1
L_927024:
	cmp.ne r13,0x2
L_927028:
	beq L_927034
L_92702c:
	breq r13,0x3,L_927080
L_927030:
	brne r13,0x4,L_927080
	.global L_927034
L_927034:
	asl r6,r13,0x4
L_927038:
	or r6,r6,r13
L_92703c:
	asl r5,r13,0x8
L_927040:
	or r5,r5,r6
L_927044:
	asl r4,r13,0xc
L_927048:
	or r4,r4,r5
L_92704c:
	asl r3,r13,0x10
L_927050:
	or r3,r3,r4
L_927054:
	asl r2,r13,0x14
L_927058:
	or_s r2,r2,r3
L_92705a:
	asl r1,r13,0x18
L_92705e:
	or_s r1,r1,r2
L_927060:
	asl_s r13,r13,0x1c
L_927062:
	or_s r1,r1,r13
L_927064:
	mov r7,0x881000
L_92706c:
	st.as r1,[r7,-0xff]
L_927070:
	bmsk_s r1,r1,0x1b
L_927072:
	st.as r1,[r7,-0xfe]
L_927076:
	mov_s blink,r14
L_927078:
	ld_s r14,[sp,0x4]
L_92707a:
	j_s.d [blink]
L_92707c:
	ld.ab r13,[sp,0x8]
	.global L_927080
L_927080:
	mov_s r0,blink
L_927082:
	mov_s r2,0x1003448
L_927088:
	mov r1,0x12da
L_927090:
	bl.d L_925548
L_927094:
	mov r3,0x536
L_927098:
	b_s L_927034
L_92709a:
	nop_s
