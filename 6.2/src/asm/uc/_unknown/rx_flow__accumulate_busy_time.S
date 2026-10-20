/* rx_flow__accumulate_busy_time @ 0x924960, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__run
 * Зовёт сам: uc_read_tsf_lo
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_flow__accumulate_busy_time
rx_flow__accumulate_busy_time:
	.global L_924960
L_924960:
	st.a r13,[sp,-0x8]
L_924964:
	st_s r14,[sp,0x4]
L_924966:
	mov_s r14,blink
L_924968:
	bl.d L_9364c8
L_92496c:
	mov r13,r0
L_924970:
	mov r4,0x80063c
L_924978:
	ld r3,[r4]
L_92497c:
	breq.d r3,0x0,L_924994
L_924980:
	sub r2,r0,r13
L_924984:
	ldb r1,[0x800640]
L_92498c:
	sub_s r13,r13,r3
L_92498e:
	brlo r1,r13,L_924994
L_924992:
	add_s r2,r2,r13
	.global L_924994
L_924994:
	st r0,[r4]
L_924998:
	mov_s r1,0x801030
L_92499e:
	ld r0,[r1, 0xa8]
L_9249a2:
	mov_s blink,r14
L_9249a4:
	add_s r0,r0,r2
L_9249a6:
	st r0,[r1, 0xa8]
L_9249aa:
	ld_s r14,[sp,0x4]
L_9249ac:
	j.d [blink]
L_9249b0:
	ld.ab r13,[sp,0x8]
