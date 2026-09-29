/* uc_sleep_until_event @ 0x93187c, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: cf_end__tx_flow, rx_flow__run
 */
	.section .text.uc_sleep_until_event,"ax",@progbits
	.global uc_sleep_until_event
uc_sleep_until_event:
	.global L_93187c
L_93187c:
	st.a r13,[sp,-0x8]
L_931880:
	st_s r14,[sp,0x4]
L_931882:
	tst r42,r0
L_931886:
	mov_s r14,blink
L_931888:
	bne.d L_9318e8
L_93188c:
	mov_s r13,r0
L_93188e:
	breq_s r1,0,L_9318b8
L_931890:
	or r1,r1,0x23010000
L_931898:
	mov r32,r1
L_93189c:
	st.ab r1,[r25,0x4]
L_9318a0:
	bclr r25,r25,0xa
L_9318a4:
	mov_s r2,0x2000200
L_9318aa:
	mov_s r32,r2
L_9318ac:
	st.ab r2,[r25,0x4]
L_9318b0:
	bclr r25,r25,0xa
L_9318b4:
	bset r13,r13,0x9
	.global L_9318b8
L_9318b8:
	st r13,[0x886d3c]
L_9318c0:
	mov_s r2,0x21000002
L_9318c6:
	mov_s r32,r2
L_9318c8:
	st.ab r2,[r25,0x4]
L_9318cc:
	bclr r25,r25,0xa
L_9318d0:
	st.as r13,[gp,-0x17]
L_9318d4:
	st.as ilink2,[gp,-0x27]
L_9318d8:
	nop_s
L_9318da:
	sleep 0x0
L_9318de:
	mov_s r2,0x0
L_9318e0:
	st r2,[0x886d3c]
	.global L_9318e8
L_9318e8:
	mov_s blink,r14
L_9318ea:
	ld_s r14,[sp,0x4]
L_9318ec:
	j.d [blink]
L_9318f0:
	ld.ab r13,[sp,0x8]
