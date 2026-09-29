/* mac_mode_kick @ 0x92910c, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_dti__kick_worker
 * Зовёт сам: mac__set_channel_word, mac_mode_program_c, uc_spin_until_event4
 * Глобалы (через gp): 0x8005d8
 */
	.section .text.mac_mode_kick,"ax",@progbits
	.global mac_mode_kick
mac_mode_kick:
	.global L_92910c
L_92910c:
	st.a r13,[sp,-0x8]
L_929110:
	ldw.as r3,[gp,0x58]
L_929114:
	ldw r1,[0x801a14]
L_92911c:
	st blink,[sp, 0x4]
L_929120:
	breq.d r3,r1,L_929150
L_929124:
	mov r13,r0
L_929128:
	stw.as r1,[gp,0x58]
L_92912c:
	or r1,r1,0x1730000
L_929134:
	st r1,[0x886d00]
L_92913c:
	sync
L_929140:
	mov_s r2,0x38000200
L_929146:
	mov_s r32,r2
L_929148:
	st.ab r2,[r25,0x4]
L_92914c:
	bclr r25,r25,0xa
	.global L_929150
L_929150:
	bl.d L_9317f0
L_929154:
	mov r0,0x140
L_929158:
	mov r2,r54
L_92915c:
	bbit0 r2,0x6,L_929174
L_929160:
	bl.d L_9290b4
L_929164:
	mov r0,r13
L_929168:
	ld blink,[sp, 0x4]
L_92916c:
	j.d [blink]
L_929170:
	ld.ab r13,[sp,0x8]
	.global L_929174
L_929174:
	mov_s r0,0x49000100
L_92917a:
	mov_s r32,r0
L_92917c:
	st.ab r0,[r25,0x4]
L_929180:
	bclr r25,r25,0xa
L_929184:
	bl.d L_929190
L_929188:
	mov r0,r13
L_92918c:
	b_s L_929150
L_92918e:
	nop_s
