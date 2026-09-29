/* uc_isr_l1_task3__body @ 0x928ae4, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_isr_l1_task3__body,"ax",@progbits
	.global uc_isr_l1_task3__body
uc_isr_l1_task3__body:
L_928ae4:
	mov_s r0,0x3
	.global sub_928ae6
sub_928ae6:
L_928ae6:
	pop_s blink
L_928ae8:
	pop_s r12
L_928aea:
	sr r12,[0x3]
L_928aee:
	pop_s r12
L_928af0:
	sr r12,[0x2]
L_928af4:
	pop_s r12
L_928af6:
	mov_s lp_count,r12
L_928af8:
	ld.ab r11,[sp,0x4]
L_928afc:
	ld.ab r10,[sp,0x4]
L_928b00:
	ld.ab r9,[sp,0x4]
L_928b04:
	ld.ab r8,[sp,0x4]
L_928b08:
	ld.ab r7,[sp,0x4]
L_928b0c:
	ld.ab r6,[sp,0x4]
L_928b10:
	ld.ab r5,[sp,0x4]
L_928b14:
	ld.ab r4,[sp,0x4]
L_928b18:
	pop_s r3
L_928b1a:
	pop_s r2
L_928b1c:
	pop_s r1
L_928b1e:
	pop_s r0
L_928b20:
	pop_s r12
L_928b22:
	mulu64 r12,0x1
L_928b26:
	mov 0x0,mlo
L_928b2a:
	pop_s r12
L_928b2c:
	sr r12,[0x12]
L_928b30:
	pop_s r12
L_928b32:
	.byte 0x20,0x20
