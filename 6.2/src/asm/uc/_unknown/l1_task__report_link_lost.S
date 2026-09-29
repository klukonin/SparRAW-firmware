/* l1_task__report_link_lost @ 0x928ab8, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__main_step
 * Зовёт сам: l1_task__dispatch, uc__set_evt_id_5c, uc_pm__enter_idle, uc_read_tsf_lo, uc_send_evt__link_lost
 * Глобалы (через gp): 0x800540, 0x8005bc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l1_task__report_link_lost
l1_task__report_link_lost:
	.global L_928ab8
L_928ab8:
	st.a r13,[sp,-0xc]
L_928abc:
	st blink,[sp, 0x4]
L_928ac0:
	st_s r14,[sp,0x8]
L_928ac2:
	mov r5,0x80242c
L_928aca:
	ld r4,[r5, 0x20]
L_928ace:
	sub_s sp,sp,0xc
L_928ad0:
	add r4,r4,0x1
L_928ad4:
	st r4,[r5, 0x20]
L_928ad8:
	mov_s r13,0x1
L_928ada:
	mov_s r0,r13
L_928adc:
	mov r14,0x0
L_928ae0:
	bl.d L_934e30
L_928ae4:
	mov r1,r14
L_928ae8:
	bl.d L_93c7d4
L_928aec:
	mov r0,r13
L_928af0:
	bl L_9364c8
L_928af4:
	stw.as r14,[gp,0x4a]
L_928af8:
	st.as r0,[gp,0x6]
L_928afc:
	bl.d L_921724
L_928b00:
	mov r0,r13
L_928b04:
	ldb r3,[0x802194]
L_928b0c:
	breq.d r3,0x0,L_928b24
L_928b10:
	st r13,[sp, 0x8]
L_928b14:
	norm r3,r3
L_928b18:
	rsub r2,r3,0x1e
L_928b1c:
	b.d L_928b28
L_928b20:
	st r2,[sp]
	.global L_928b24
L_928b24:
	mov_s r0,0x8
L_928b26:
	st_s r0,[sp,0x0]
	.global L_928b28
L_928b28:
	ld r1,[0x8025dc]
L_928b30:
	st r1,[sp, 0x4]
L_928b34:
	bl.d L_927690
L_928b38:
	mov r0,sp
L_928b3c:
	add_s sp,sp,0xc
L_928b3e:
	ld blink,[sp, 0x4]
L_928b42:
	ld_s r14,[sp,0x8]
L_928b44:
	j.d [blink]
L_928b48:
	ld.ab r13,[sp,0xc]
