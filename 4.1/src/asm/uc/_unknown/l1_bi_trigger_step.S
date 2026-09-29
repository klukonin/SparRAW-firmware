/* l1_bi_trigger_step @ 0x926984, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__entry
 * Зовёт сам: bi_ap_mon_if__trigger, perform_shallow_sleep, rx__set_enable_mask, uc_pm__enter_idle, uc_read_tsf_lo, uc_send_evt__link_lost
 * Глобалы (через gp): 0x80053c, 0x8005d6
 */
	.section .text.l1_bi_trigger_step,"ax",@progbits
	.global l1_bi_trigger_step
l1_bi_trigger_step:
	.global L_926984
L_926984:
	st.a r13,[sp,-0xc]
L_926988:
	st blink,[sp, 0x4]
L_92698c:
	st_s r14,[sp,0x8]
L_92698e:
	mov_s r3,0x8014dc
L_926994:
	ld_s r2,[r3,0x10]
L_926996:
	sub_s sp,sp,0xc
L_926998:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_92699a:
	st_s r2,[r3,0x10]
L_92699c:
	mov_s r13,0x1
L_92699e:
	mov_s r0,r13
L_9269a0:
	mov r14,0x0
L_9269a4:
	bl.d L_9304c8
L_9269a8:
	mov r1,r14
L_9269ac:
	mov_s r0,0x801ed0
L_9269b2:
	mov_s r1,r14
L_9269b4:
	mov_s r2,r14
L_9269b6:
	mov_s r3,r13
L_9269b8:
	bl.d L_92af4c
L_9269bc:
	mov r4,r13
L_9269c0:
	breq r0,0x0,L_9269cc
L_9269c4:
	st r13,[0x800660]
	.global L_9269cc
L_9269cc:
	bl.d L_936ca8
L_9269d0:
	mov r0,0x1
L_9269d4:
	bl L_9315e8
L_9269d8:
	stw.as r14,[gp,0x57]
L_9269dc:
	st.as r0,[gp,0x5]
L_9269e0:
	bl.d L_921f84
L_9269e4:
	mov r0,0x1
L_9269e8:
	st_s r13,[sp,0x8]
L_9269ea:
	mov_s r1,0x8
L_9269ec:
	ld r0,[0x8016b4]
L_9269f4:
	st_s r1,[sp,0x0]
L_9269f6:
	st_s r0,[sp,0x4]
L_9269f8:
	bl.d L_925c40
L_9269fc:
	mov r0,sp
L_926a00:
	add_s sp,sp,0xc
L_926a02:
	ld blink,[sp, 0x4]
L_926a06:
	ld_s r14,[sp,0x8]
L_926a08:
	j.d [blink]
L_926a0c:
	ld.ab r13,[sp,0xc]
