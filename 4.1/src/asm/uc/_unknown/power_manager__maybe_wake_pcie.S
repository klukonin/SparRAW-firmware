/* power_manager__maybe_wake_pcie @ 0x926934, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_manager__decide_shallow_sleep
 * Зовёт сам: uc_send_evt__ps_wake_pcie
 */
	.section .text.power_manager__maybe_wake_pcie,"ax",@progbits
	.global power_manager__maybe_wake_pcie
power_manager__maybe_wake_pcie:
	.global L_926934
L_926934:
	push_s r13
L_926936:
	ld.as r2,[r0,0x51]
L_92693a:
	sub_s sp,sp,0x4
L_92693c:
	breq.d r2,0x0,L_926978
L_926940:
	mov_s r13,blink
L_926942:
	ld.as r3,[r0,0x50]
L_926946:
	breq_s r3,0,L_926978
L_926948:
	add r0,r0,0x200
L_92694c:
	ldb r4,[r0, -0xc4]
L_926950:
	breq r4,0x0,L_92695c
L_926954:
	ldb r5,[r0, -0xb8]
L_926958:
	bbit1 r5,0x0,L_92696c
	.global L_92695c
L_92695c:
	ldb r6,[r0, -0xc3]
L_926960:
	breq r6,0x0,L_926978
L_926964:
	ldb r7,[r0, -0xb8]
L_926968:
	bbit0 r7,0x1,L_926978
	.global L_92696c
L_92696c:
	stb r1,[sp]
L_926970:
	bl.d L_925d80
L_926974:
	mov r0,sp
	.global L_926978
L_926978:
	mov_s blink,r13
L_92697a:
	add_s sp,sp,0x4
L_92697c:
	j.d [blink]
L_926980:
	pop_s r13
L_926982:
	nop_s
